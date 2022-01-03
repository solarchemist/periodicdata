## ----packages, echo=T, message=FALSE------------------------------------------
library(dplyr)
library(magrittr) # extract2()
library(httr)
library(rvest)
library(stringr)
library(readr)
library(knitr)
library(usethis)
library(ggplot2)
library(ggrepel)
library(here)

## ----global_options, echo=T, message=FALSE----------------------------------------
options(
   digits   = 7,
   width    = 84,
   continue = " ",
   prompt   = "> ",
   warn = 0,
   stringsAsFactors = FALSE)
opts_chunk$set(
   dev        = 'svg',
   #out.width  = "100%",
	fig.width  = 7.10,
	fig.height = 4.39,
   fig.align  = 'center',
   echo       = FALSE,
   eval       = TRUE,
   cache      = TRUE,
   collapse   = TRUE,
   results    = 'hide',
   message    = FALSE,
   warning    = FALSE,
   tidy       = FALSE)

## ---- echo=TRUE-------------------------------------------------------------------
# Starting from this URL, we crawl the page and collect the URLs to all property pages, along with the name of each property.
# We put them together in a dataframe, so it is clear which URL belongs to which elemental property.
element_data <- read_html("http://periodictable.com/Elements/001/data.html")
elemental_properties <-
   data.frame(property = element_data %>%
                 html_nodes(xpath = "//a") %>%
                 html_text())
elemental_properties$links_raw <-
   element_data %>%
   html_nodes(xpath = "//a") %>%
   html_attr("href")
# drop any rows that do not begin "../../"
elemental_properties <-
   elemental_properties[
      grep(pattern = "^\\.\\./\\.\\./",
           x = elemental_properties$links_raw), ]
# remove the leading ../.. (relative link signifier)
elemental_properties$links_trail <-
   gsub(pattern = "^\\.\\./\\.\\./",
        replacement = "",
        x = elemental_properties$links_raw)
# keep only the rows that begin with "Properties"
elemental_properties <-
   elemental_properties[
      grep(pattern = "^Properties",
           x = elemental_properties$links_trail), ]
# make full urls
elemental_properties$url <-
   paste0("http://periodictable.com/",
          elemental_properties$links_trail)
# modify the URL so it sorts the table by atomic number
# (this is a feature of periodictable.com, they offer lists sortered in different ways
# for each property)
elemental_properties$url <-
   sub(pattern = "\\.html$",
       replacement = ".an.html",
       x = elemental_properties$url)
# we are done, go ahead and drop the no longer required columns
# links_raw, links_trail
elemental_properties <-
   elemental_properties[, -c(2,3)]
# oh, and add a sanitised version of the property names
elemental_properties$sanitized <-
   # replace spaces with underscores
   gsub("\\s+", "_",
        # replace "%" with "percent"
        gsub("%", "Percent",
             # remove parentheses and dashes
             gsub("[()-]", "",
                  # remove apostrophes
                  gsub("'", "", elemental_properties$property))))
# NOTE: Melting point and Boiling point are duplicated because they are displayed twice
#       on the data page for Hydrogen, both under "Overview" and "Thermal properties".
#       Other properties could be too, so we should deduplicate the dataframe.
elemental_properties <- unique(elemental_properties)
# reset the row numbering
row.names(elemental_properties) <- seq(1, dim(elemental_properties)[1])

## ---- echo=TRUE-------------------------------------------------------------------
# get the name of all the elements (two-step process)
element_names <-
   read_html(elemental_properties$url[1]) %>%
   html_nodes("table") %>% extract2(1) %>%
   html_nodes("table") %>% extract2(8) %>%
   html_nodes("td") %>%
   html_text()
# here we initialise the properties dataframe, which we will use later
# to read in all the properties (building the frame using ..._join() calls) 
properties_raw <-
   data.frame(Name = 
                 element_names[
                    read_html(elemental_properties$url[1]) %>%
                    html_nodes("table") %>%
                    extract2(1) %>%
                    html_nodes("table") %>%
                    extract2(8) %>%
                    html_nodes("td") %>%
                    html_attr("align") == "left"])

## ---- echo=TRUE-------------------------------------------------------------------
skip_properties <-
   c("Ionization_Energies", # has multiple values per element, plus formatting errors in HTML (cell 1 and 120)
     "NFPA_Label", # replacement has 120 rows, data has 118
     "Names_of_Allotropes", # has formatting errors in HTML (cell 1 and 120)
     "Discovery", # formatting errors in HTML, specifically in cell 1 and 120
     "Lattice_Angles", # formatting errors in HTML, specifically in cell 1 and 120
     "Lattice_Constants", # formatting errors in HTML, specifically in cell 1 and 120
     "Crystal_Structure", # replacement has 120 rows, data has 118
     "Known_Isotopes", # formatting errors in HTML, specifically in cell 1 and 120
     "Stable_Isotopes", # formatting errors in HTML, specifically in cell 1 and 120
     "Isotopic_Abundances" # formatting errors in HTML, specifically in cell 1 and 120
    )
# drop those rows from elemental_properties
elemental_properties <-
   elemental_properties[-which(elemental_properties$sanitized %in% skip_properties), ]

## ---- echo=TRUE-------------------------------------------------------------------
# This chunk does all the scraping of periodictable.com
# But it tries its best not to do any scraping
# If you really want to scrape the website and rebuild the entire dataset from scratch (this takes some time!), go ahead and delete the file "inst/extdata/periodicdata-raw.rdata" then run this chunk again.
if (!file.exists(here("inst", "extdata", "periodicdata-raw.rdata"))) {
   for (k in 2:length(elemental_properties$property)) {
      message(paste0("Reading property page (", k, " of ", length(elemental_properties$property), "): ",
                     elemental_properties$property[k]))
      # On these property pages, the source HTML appears to be malformed (but recoverable)
      # The HTML source looks weird: in essence, a number of cells <td></td> are repeated (but not all)
      # so that the table which is expected to contain 118 *2 = 236 cells contains something like 299 instead.
      # To be able to ingest such a table, we need to detect and get rid of the duplicated td cells.
      # My approach is based on the fact that duplicated td cells always lack any CSS attributes, whereas the cells
      # we want to keep always specify align (either left or right).
      td_nodes <- 
         read_html(elemental_properties$url[k]) %>%
         html_nodes("table") %>% extract2(1) %>%
         html_nodes("table") %>% extract2(8) %>% 
         html_nodes("td")
      # The formatting of periodictable.com's HTML is unfortunately not consistent across the property pages
      # On most, the label and value are inside td blocks neatly aligned left or right, but on other property
      # pages the value part is repeated inside free-standing td blocks lacking any CSS attributes.
      # To distinguish between these two cases (i.e., remove the duplicate values), I check for the align attr:
      check_htmltable_align <- 
         td_nodes %>% 
         # here we are just checking for the existence of "align" attribute
         # will return NA for the td cells that lack align attribute, and those are the duplicates we want to remove
         html_attr("align") 
      if (any(is.na(check_htmltable_align))) {
         # if it contains any NAs, print a message (for easier debugging)
         # example: https://periodictable.com/Properties/A/RTECSNumber.an.html
         message(paste0("Detected funky formatting on property page ", elemental_properties$property[k]))
      }
      # record the full table, element name/value pairs as a single vector
      property_table <- 
         td_nodes[which(!is.na(check_htmltable_align))] %>% html_text()
      property <-
         structure(
            data.frame(
               # just the element names
               Name = 
                  property_table[td_nodes[which(!is.na(check_htmltable_align))] %>% html_attr("align") == "right"],
               # the value of the current property (this column is renamed below)
               value = 
                  property_table[td_nodes[which(!is.na(check_htmltable_align))] %>% html_attr("align") == "left"]),
            .Names = c("Name", elemental_properties$sanitized[k]))
      ## NOTE: You CANNOT rely on the order of the element names staying consistent across property pages,
      ##       in particular not on "funky" property pages. Learned this the hard way.
      # So here we use what should be a reliable way of growing our properties df with each new property:
      properties_raw <- left_join(properties_raw, property, by = "Name")
   }
   properties_raw <- properties_raw %>% arrange(as.numeric(Atomic_Number))
   # save this dataframe to file
   # (it is not large, but re-scraping the contents takes time)
   save(properties_raw, file = here("inst", "extdata", "periodicdata-raw.rdata"))
   write_csv(properties_raw, here("inst", "extdata", "periodicdata-raw.csv"))
} else {
   load(file = here("inst", "extdata", "periodicdata-raw.rdata"))
}

## ---- echo=TRUE-------------------------------------------------------------------
property <- 
   structure(data.frame(matrix(c(
      # Name        # Autoignition_Point
      "Hydrogen",   "535.5°C",
      "Lithium",    "179.°C",
      "Carbon",     "485.°C",
      "Sodium",     "115.°C",
      "Magnesium",  "472.°C",
      "Aluminum",   "400.°C",
      "Silicon",    "150.°C",
      "Phosphorus", "300.°C",
      "Potassium",  "440.°C",
      "Titanium",   "250.°C",
      "Chromium",   "400.°C",
      "Iron",       "100.°C",
      "Zinc",       "460.°C",
      "Cadmium",    "250.°C",
      "Tin",        "630.°C",
      "Tellurium",  "340.°C",
      "Samarium",   "150.°C",
      "Thorium",    "130.°C"),
      ncol = 2,
      byrow = T)),
      .Names = c("Name", "Autoignition_Point"))
properties_raw <- left_join(properties_raw, property, by = "Name")

## ---- echo=TRUE-------------------------------------------------------------------
property <- 
   structure(data.frame(matrix(c(
      # Name        # Flashpoint
      "Hydrogen",   "-18.°C",
      "Sodium",     "4.°C",
      "Magnesium",  "500.°C",
      "Aluminum",   "645.°C",
      "Phosphorus", "30.°C",
      "Bromine",    "-18.°C"),
      ncol = 2,
      byrow = T)),
      .Names = c("Name", "Flashpoint"))
properties_raw <- left_join(properties_raw, property, by = "Name")

## ---- echo=TRUE-------------------------------------------------------------------
property <- 
   structure(data.frame(matrix(c(
      # Name      # Heat_of_Combustion
      "Lithium",  "-298.J/(Kg K)",
      "Carbon",   "-393.J/(Kg K)",
      "Magnesium","-668.J/(Kg K)",
      "Silicon",  "-9055.J/(Kg K)",
      "Potassium","-182.J/(Kg K)",
      "Calcium",  "-990.J/(Kg K)",
      "Germanium","-536.J/(Kg K)"),
      ncol = 2,
      byrow = T)),
      .Names = c("Name", "Heat_of_Combustion"))
properties_raw <- left_join(properties_raw, property, by = "Name")

## ---- echo=TRUE-------------------------------------------------------------------
property <- 
   structure(data.frame(matrix(c(
      # Name         # Gmelin_Number
      "Hydrogen",		"Gmelin3",
      "Neon",		   "Gmelin16211",
      "Sodium",		"Gmelin563",
      "Magnesium",	"Gmelin16207",
      "Aluminum",		"Gmelin16248",
      "Silicon",		"Gmelin61188",
      "Phosphorus",	"Gmelin8863",
      "Argon",		   "Gmelin821",
      "Potassium",	"Gmelin15203",
      "Helium",		"Gmelin16294",
      "Calcium",		"Gmelin16277",
      "Scandium",		"Gmelin16304",
      "Titanium",		"Gmelin16313",
      "Vanadium",		"Gmelin49047",
      "Chromium",		"Gmelin16274",
      "Manganese",	"Gmelin699",
      "Iron",		   "Gmelin6845",
      "Cobalt",		"Gmelin49017",
      "Nickel",		"Gmelin16229",
      "Copper",		"Gmelin16269",
      "Lithium",		"Gmelin30",
      "Zinc",		   "Gmelin16321",
      "Gallium",		"Gmelin16287",
      "Germanium",	"Gmelin93634",
      "Arsenic",		"Gmelin16247",
      "Selenium",		"Gmelin8872",
      "Bromine",		"Gmelin1182",
      "Krypton",		"Gmelin16201",
      "Rubidium",		"Gmelin16244",
      "Strontium",	"Gmelin16302",
      "Yttrium",		"Gmelin16319",
      "Beryllium",	"Gmelin16256",
      "Zirconium",	"Gmelin16322",
      "Niobium",		"Gmelin16213",
      "Molybdenum",	"Gmelin16205",
      "Ruthenium",	"Gmelin16241",
      "Rhodium",		"Gmelin16245",
      "Palladium",	"Gmelin16239",
      "Silver",		"Gmelin1253",
      "Cadmium",		"Gmelin16276",
      "Indium",		"Gmelin1081",
      "Boron",		   "Gmelin16262",
      "Tin",		   "Gmelin16300",
      "Tellurium",	"Gmelin1153",
      "Iodine",		"Gmelin1160",
      "Xenon",		   "Gmelin1125",
      "Cesium",		"Gmelin15188",
      "Barium",		"Gmelin16266",
      "Cerium",		"Gmelin16275",
      "Praseodymium","Gmelin16238",
      "Carbon",		"Gmelin8868",
      "Neodymium",	"Gmelin16212",
      "Samarium",		"Gmelin16301",
      "Europium",		"Gmelin15985",
      "Gadolinium",	"Gmelin16286",
      "Terbium",		"Gmelin16311",
      "Dysprosium",	"Gmelin16278",
      "Holmium",		"Gmelin16291",
      "Erbium",		"Gmelin16280",
      "Thulium",		"Gmelin16307",
      "Nitrogen",		"Gmelin150",
      "Ytterbium",	"Gmelin16014",
      "Lutetium",		"Gmelin16202",
      "Hafnium",		"Gmelin16293",
      "Tantalum",		"Gmelin16312",
      "Tungsten",		"Gmelin16317",
      "Rhenium",		"Gmelin16243",
      "Osmium",		"Gmelin16234",
      "Iridium",		"Gmelin16298",
      "Platinum",		"Gmelin79607",
      "Gold",		   "Gmelin16246",
      "Oxygen",		"Gmelin485",
      "Mercury",		"Gmelin1623",
      "Thallium",		"Gmelin16308",
      "Lead",		   "Gmelin16240",
      "Bismuth",		"Gmelin16267",
      "Radon",		   "Gmelin16242",
      "Radium",		"Gmelin40437",
      "Fluorine",		"Gmelin16281",
      "Thorium",		"Gmelin16314",
      "Uranium",		"Gmelin16315",
      "Plutonium",	"Gmelin40432"),
      ncol = 2,
      byrow = T)),
      .Names = c("Name", "Gmelin_Number"))
properties_raw <- left_join(properties_raw, property, by = "Name")

## ---- echo=TRUE-------------------------------------------------------------------
# create empty dataframes to hold quantities and units, respectively
values <- units  <-
   data.frame(matrix(
      nrow = dim(properties_raw)[1],
      ncol = dim(properties_raw)[2],
      dimnames = list(seq(1, dim(properties_raw)[1]), names(properties_raw)),
      byrow = TRUE))
# The dataset on periodictable.com also has footnotes.
# These are not saved in the current implementation of `periodicdata`

## ---- echo=T----------------------------------------------------------------------
# to re-create the matrix below, get started like this:
# cat(paste0(names(properties), collapse=",\n"))
property_types <- 
   structure(data.frame(matrix(c(
      "Name","character",
      "Symbol","character",
      "Atomic_Number","unitless number",
      "Atomic_Weight","unitless number",
      "Density","number with unit",
      "Melting_Point","number with unit",
      "Boiling_Point","number with unit",
      "Phase","character",
      "Absolute_Melting_Point","number with unit",
      "Absolute_Boiling_Point","number with unit",
      "Critical_Pressure","number with unit", # contains converted values in parentheses
      "Critical_Temperature","number with unit",
      "Heat_of_Fusion","number with unit",
      "Heat_of_Vaporization","number with unit",
      "Specific_Heat","number with unit", 
      "Adiabatic_Index","character",
      "Neel_Point","number with unit",
      "Thermal_Conductivity","number with unit", 
      "Thermal_Expansion","number with unit",
      "Density_Liquid","number with unit",
      "Molar_Volume","unitless number",
      "Brinell_Hardness","number with unit",
      "Mohs_Hardness","number with unit",
      "Vickers_Hardness","number with unit",
      "Bulk_Modulus","number with unit",
      "Shear_Modulus","number with unit",
      "Young_Modulus","number with unit",
      "Poisson_Ratio","unitless number",
      "Refractive_Index","unitless number",
      "Speed_of_Sound","number with unit",
      "Valence","unitless number",
      "Electronegativity","unitless number",
      "ElectronAffinity","number with unit",
      "DOT_Hazard_Class","unitless number",
      "DOT_Numbers","unitless number",
      "RTECS_Number","character",
      "Alternate_Names","character",
      "Block","character",
      "Group","character",
      "Period","character",
      "Series","character",
      "Electron_Configuration","character",
      "Color","character",
      "Gas_phase","character",
      "CAS_Number","character",
      "CID_Number","character",
      "Electrical_Type","character",
      "Electrical_Conductivity","number with unit",
      "Resistivity","number with unit",
      "Superconducting_Point","unitless number",
      "Magnetic_Type","character",
      "Curie_Point","number with unit",
      "Mass_Magnetic_Susceptibility","unitless number",
      "Molar_Magnetic_Susceptibility","unitless number",
      "Volume_Magnetic_Susceptibility","unitless number",
      "Percent_in_Universe","number with unit",
      "Percent_in_Sun","number with unit", 
      "Percent_in_Meteorites","number with unit",
      "Percent_in_Earths_Crust","number with unit",
      "Percent_in_Oceans","number with unit",
      "Percent_in_Humans","number with unit",
      "Atomic_Radius","number with unit",
      "Covalent_Radius","number with unit",
      "Van_der_Waals_Radius","number with unit",
      "Space_Group_Name","character",
      "Space_Group_Number","unitless number",
      "HalfLife","number with unit", # quantity includes "Stable" and num + unit. Units are a mix of time units: ms, s, m, d, y
      "Lifetime","number with unit", # quantity includes "Stable" and num + unit. Units are a mix of time units: ms, s, m, d, y
      "Decay_Mode","character",
      "Quantum_Numbers","character",
      "Neutron_Cross_Section","unitless number",
      "Neutron_Mass_Absorption","unitless number",
      "Autoignition_Point","number with unit",
      "Heat_of_Combustion","number with unit"), 
      ncol = 2, byrow = T)),
      .Names = c("Data", "Type"))

## ---- echo=T, warning=FALSE-------------------------------------------------------
# running this loop usually produces warnings "NAs introduced by coercion". We can disregard those.
for (k in 1:dim(property_types)[1]) {
   # clean up or convert the quantity or unit depending on type of data in each property
   # type is defined manually in the matrix in the chunk above
   if (property_types$Type[k] == "character") {
      values[, which(names(values) == property_types$Data[k])] <- 
         properties_raw %>%
         pull(property_types$Data[k]) %>%
         gsub("\\[note\\]", "", x = .) %>%
         gsub("^N/A$", "", x = .) %>%
         gsub("^None$", "", x = .)
   } else if (property_types$Type[k] == "unitless number") {
      values[, which(names(values) == property_types$Data[k])] <- 
         properties_raw %>%
         pull(property_types$Data[k]) %>%
         gsub("\\[note\\]", "", x = .) %>%
         gsub("×10", "E", x = .) %>%
         # final step, make sure the column is numeric
         as.numeric()
   } else if (property_types$Type[k] == "number with unit") {
      values[, which(names(values) == property_types$Data[k])] <- 
         properties_raw %>%
         pull(property_types$Data[k]) %>%
         gsub("\\[note\\]", "", x = .) %>%
         # replace "Stable" with Inf (only found in HalfLife, Lifetime)
         gsub("^Stable$", "Inf", x = .) %>%
         # replace ×10 with proper power notation
         gsub("×10", "E", x = .) %>%
         # extract the numeric quantity (including the string "Inf")
         str_extract("Inf|[-×\\.0-9E]+") %>%
         # final step, make sure this column is numeric
         as.numeric()
      units[, which(names(units) == property_types$Data[k])] <- 
         properties_raw %>%
         pull(property_types$Data[k]) %>%
         gsub("N/A", "", x = .) %>%
         gsub("\\[note\\]", "", x = .) %>%
         # replace "Stable" with Inf (only found in HalfLife, Lifetime)
         gsub("^Stable$", "Inf", x = .) %>%
         # remove any numbers+units within parentheses
         gsub("\\([.0-9]+\\s[A-Za-z]+\\)", "", x = .) %>%
         # remove the numeric quantity (including the string "Inf")
         # take care not to use gsub here, since numbers could also be part of the unit (e.g., "g/cm3")
         sub("Inf|[-×\\.0-9E]+", "", x = .) %>%
         # remove any leading and trailing whitespace
         str_trim(side="both") %>%
         # replace empty string with NA
         gsub("^$", NA, x = .)
   } else {
      message("This should never happen!")
   }
}

## ---- echo=TRUE, results='markup'-------------------------------------------------
# Units by property
sapply(units, unique)

## ---- echo=TRUE, results='markup'-------------------------------------------------
# All units in the dataset as a simple vector
cat(paste(sort(unique(unlist(sapply(units, unique)))), collapse = "\n"))

## ---- echo=TRUE-------------------------------------------------------------------
## %           (percent)
## °C          => K
## d           => s (day to second)
## g/cm3       => kg/m^3
## g/l         => kg/m^3
## GPa         => Pa
## h           => s (hour to second)
## J/(Kg K)    => J/(kg K) (fix wrong case)
## J/(kg K)
## K           (Kelvin)
## K-1         (per Kelvin)
## kJ/mol      (kilojoule per mol)
## m           => s (only exists in HalfLife and Lifetime property, so this is minutes not metres)
## m Ω         => Ohm m (electrical resistivity, Ohm metre) # avoid Ω, causes non-ASCII char warning on package build
## m/s         (metre per second)
## MPa         => Pa
## ms          => s (millisecond to second)
## pm          => m (picometre to metre)
## S/m         (Siemens per metre)
## W/(m K)     (Watt per metre-Kelvin)
## y           => s (year to second)

## ---- echo=TRUE-------------------------------------------------------------------
pcf <- 
   structure(data.frame(matrix(c(
      # from      # to        # conversion factor
      "°C",       "K",        "+273.15",
      "d",        "s",        "86400",
      "g/cm3",    "kg/m^3",   "1E3",
      "g/l",      "kg/m^3",   "1",
      "GPa",      "Pa",       "1E9",
      "h",        "s",        "3600",
      "J/(Kg K)", "J/(kg K)", "1",
      "m",        "s",        "60", # minutes to seconds
      "m Ω",      "Ohm m",    "1",
      "MPa",      "Pa",       "1E6",
      "ms",       "s",        "1E-3",
      "pm",       "m",        "1E-12", # be careful that this substitution doesn't precede "mins to secs"
      "y",        "s",        "3.154E7"), 
      ncol = 3, byrow = T)),
      .Names = c("pattern", "convert", "factor"))

## ---- echo=T----------------------------------------------------------------------
# Replace the units and convert values according to pcf
for (k in 1:dim(units)[2]) {
   # if the entire column is NA, move to the next one
   if (all(is.na(units[, k]))) {next}
   for (i in 1:dim(units)[1]) {
      # jump to the next cell immediately if unit is empty
      if (is.na(units[i, k])) {next}
      # for each cell, compare the unit to pcf$pattern,
      # and if they match, replace it with pcf$convert
      # and apply the conversion factor on the value
      # match() returns the position of the match
      # in pcf$pattern, or NA if no match was found
      hit <- match(units[i, k], pcf$pattern)
      if (!is.na(hit)) {
         # go ahead and replace unit and convert value
         units[i, k] <- pcf$convert[hit]
         # had to find a way to handle the odd addition operation,
         # opted to do it with a string operation and this if-else
         if (substr(pcf$factor[hit], 1, 1) %in% c("+", "-")) {
            if (substr(pcf$factor[hit], 1, 1) == "-") {
               values[i, k] <-
                  values[i, k] + as.numeric(pcf$factor[hit])
            } else {
               values[i, k] <-
                  values[i, k] + as.numeric(sub("^\\+", "", pcf$factor[hit]))
            }
         } else {
            # not addition/subtraction operation
            values[i, k] <-
               values[i, k] * as.numeric(pcf$factor[hit])
         }
      }
   }
}

## ----Density-vs-AtomicNumber, fig.cap="Density vs atomic number.", warning=FALSE----
ggplot() +
   geom_point(data = values %>% filter(!is.na(Density)), 
              aes(Atomic_Number, Density)) +
   geom_path(data = values %>% filter(!is.na(Density)), 
             aes(Atomic_Number, Density)) +
   geom_point(data = values %>% filter(!is.na(Density)) %>% filter(Group == "18"),
              aes(Atomic_Number, Density),
              colour = "red") +
   geom_text_repel(data = values %>% filter(!is.na(Density)) %>% filter(Group == "18"),
                   aes(Atomic_Number, Density, label = Symbol),
                   colour = "red") +
   scale_y_log10() +
   labs(x = "Atomic number",
        y = paste0("Density",
                   "/(",
                   unique(units$Density[which(!is.na(units$Density))]),
                   ")")
        )

## ---- echo=TRUE-------------------------------------------------------------------
values$IUPAC_Period <- values$Period %>% as.numeric()
values$IUPAC_Group <- values$Group %>% as.numeric()
values$IUPAC_Number <- values$Atomic_Number %>% as.character()
values$IUPAC_Series <- values$Series
# to maintain same dimensions as values dataframe
units$IUPAC_Period <- NA
units$IUPAC_Group <- NA
units$IUPAC_Number <- NA
# Fix coordinates for lanthanides and actinoids
# lanthanoids 57-71: Period = 8, Group = seq(4, 18)
values$IUPAC_Period[seq(57, 71)] <- 8.5
values$IUPAC_Group[seq(57, 71)] <- seq(4, 18)
values[which(values$Symbol == "Lu"), which(names(values) == "IUPAC_Series")] <- "Lanthanide"
# actinoids 89-103: Period = 9, Group = seq(4, 18)
# increase Period slightly to increase the gap up to the transition block
values$IUPAC_Period[seq(89, 103)] <- 9.5
values$IUPAC_Group[seq(89, 103)] <- seq(4, 18)
values[which(values$Symbol == "Lr"), which(names(values) == "IUPAC_Series")] <- "Actinide"
# add placeholder "element" for lanthanoids and actinoids after Ba and Ra, respectively
# (this is just to conform to the IUPAC table layout)
values[nrow(values) + 1, 
       which(names(values) %in% c("Name", "IUPAC_Period", "IUPAC_Group", "IUPAC_Number", "IUPAC_Series"))] <-
   data.frame("lanthanoids", 6, 3, "57-71", "Lanthanide")
values[nrow(values) + 1, 
       which(names(values) %in% c("Name", "IUPAC_Period", "IUPAC_Group", "IUPAC_Number", "IUPAC_Series"))] <-
   data.frame("actinoids", 7, 3, "89-103", "Actinide")
# add corresponding empty rows to units df to maintain the same dimensions:
units[nrow(units) + 1, ] <- NA
units[nrow(units) + 1, ] <- NA

## ----periodictable-ggplot2, echo=T, warning=F, fig.width=9, fig.height=5.25-------
p.periodictable_ggplot2 <-
   ggplot() +
   # lanthanoids and actinoids background colour drawn first
   geom_point(data = values %>% filter(IUPAC_Series == "Lanthanide"),
              size = 16,
              shape = 15,
              colour = "#cfc0c7",
              aes(y = IUPAC_Period, x = IUPAC_Group)) +
   geom_point(data = values %>% filter(IUPAC_Series == "Actinide"),
              size = 16,
              shape = 15,
              colour = "#a58394",
              aes(y = IUPAC_Period, x = IUPAC_Group)) +
   # boxes for all elements
   geom_point(data = values,
              # size 16 leaves no gaps between the element boxes at fig.width=9,fig.height=5.25
              size = 16,
              shape = 0,
              aes(y = IUPAC_Period,
                  x = IUPAC_Group)) +
   # element symbol
   geom_text(data = values,
             size = 3,
             colour = "black",
             fontface = "bold",
             aes(label = Symbol, 
                 y = IUPAC_Period - 0.1, x = IUPAC_Group)) +
   # atomic number
   geom_text(data = values,
             size = 1.8,
             colour = "black",
             aes(label = IUPAC_Number,
                 y = IUPAC_Period - 0.32, x = IUPAC_Group)) +
   # element name
   geom_text(data = values,
             size = 1.6,
             colour = "black",
             aes(label = tolower(Name),
                 y = IUPAC_Period + 0.12, x = IUPAC_Group)) +
   # atomic weight
   geom_text(data = values,
             size = 1.6,
             colour = "black",
             aes(label = Atomic_Weight,
                 y = IUPAC_Period + 0.32, x = IUPAC_Group)) + 
   # period labels
   geom_text(data = values %>% filter(IUPAC_Period < 8),
             size = 1.7,
             colour = "black",
             aes(label = IUPAC_Period,
                 y = IUPAC_Period),
             x = 0.38) +
   # group labels # positions manually adjusted
   geom_text(data = 
                data.frame(y = c(0.38, 1.38, rep(3.38, 10), rep(1.38, 5), 0.38),
                           x = seq(1,18)),
             size = 1.7,
             colour = "black",
             aes(label = x, x = x, y = y)) +
   # table title # position manually adjusted
   annotate("text",
            x = 9, y = 0.6, vjust = 0,
            size = 4.5,
            fontface = "bold",
            label = "Periodic Table of the Elements") +
   # table subtitle # position manually adjusted
   annotate("text", 
            x = 9, y = 0.74, vjust = 1,
            size = 2.6,
            label = "Created using ggplot2 and the periodicdata package") +
   scale_x_continuous(breaks = seq(min(values$IUPAC_Group),
                                   max(values$IUPAC_Group)),
                      limits = c(min(values$IUPAC_Group) - 1,
                                 max(values$IUPAC_Group) + 1),
                      expand = c(0,0)) +
   scale_y_continuous(trans = "reverse",
                      breaks = seq(min(values$IUPAC_Period),
                                   max(values$IUPAC_Period)),
                      limits = c(max(values$IUPAC_Period) + 1,
                                 min(values$IUPAC_Period) - 1.5),
                      expand = c(0,0)) +
   theme(panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         plot.margin = unit(c(0, 0, -0.85, -0.85), "line"),
         axis.title = element_blank(),
         axis.text = element_blank(),
         axis.ticks = element_blank(),
         # center (roughly) over transition metal block
         legend.position = c(0.42, 0.91),
         legend.justification = c(0.5, 1),
         legend.direction = "horizontal",
         # make the legend colourbar a little longer
         legend.key.width = unit(2.5, "line"),
         legend.title = element_blank(),
         legend.background = element_rect(fill = "transparent"))
print(p.periodictable_ggplot2)

## ---- echo=T----------------------------------------------------------------------
# use_data() saves each dataframe to `data/` as an *.rda file
use_data(values, units, overwrite = TRUE)
write_csv(values, here("inst", "extdata", "periodicdata-values.csv"))
write_csv(units, here("inst", "extdata", "periodicdata-units.csv"))

## ---- echo=T, eval=FALSE----------------------------------------------------------
#  purl(input = here("vignettes", "periodicdata.Rmd"), output = here("inst", "extdata", "periodicdata-raw.R"))

## ----ggsavechunk, echo=T, eval=TRUE, fig.width=9, fig.height=5.25-----------------
# note that the doc/ directory is only created after running devtools::build_vignettes()
ggsave(filename = here("doc", "periodictable-ggplot.png"), 
       plot = p.periodictable_ggplot2)
ggsave(filename = here("doc", "periodictable-ggplot.pdf"),
       plot = p.periodictable_ggplot2)
# ggsave() fails for SVG, so we resort to a "manual" conversion using pdf2svg
# ggsave(filename = here("doc", "periodictable-ggplot.svg"),
#        plot = p.periodictable_ggplot2)
# pdf2svg periodictable-ggplot.pdf periodictable-ggplot.svg
system(paste("pdf2svg", here("doc/periodictable-ggplot.pdf"), here("doc/periodictable-ggplot.svg")))


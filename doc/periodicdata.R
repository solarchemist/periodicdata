## ----load-packages------------------------------------------------------------
library(here)
library(yaml)
library(dplyr)
library(tibble)
library(tidyr)
library(ggplot2)
library(knitr)

## ----global_options---------------------------------------------------------------
options(
   digits   = 7,
   width    = 84,
   stringsAsFactors = FALSE)
yaml_path <- here("inst/extdata/periodicdata.yml")

## ----read-yaml--------------------------------------------------------------------
# imported YAML data (list of lists of lists)
# read_yaml() uses the YAML parser provided by libyaml, which conforms to the YAML 1.1 specification
pd_yaml <- yaml::read_yaml(
   file = yaml_path,
   # we want as.named.list = TRUE, otherwise we lose the property names
   as.named.list = TRUE, # TRUE is default
   merge.warning = FALSE, # FALSE is default
   # merge.precedence has no effect for this dataset, as far as I can tell
   merge.precedence = "order") # "order" is default, else "override"

## ----properties-yaml--------------------------------------------------------------
pd_yaml |> summary()

## ----yaml-to-tibbles--------------------------------------------------------------
# create a list of tibbles, where each tibble holds a property and the following fields
# (only "value" or those with length == 1 to ensure they can be recycled)
pdl_fields <- c("title", "title_symbol", "unit", "description", "footnote", "value")
# this list is also named with each property from the get-go
# https://stackoverflow.com/a/35035142/1198249
# Periodic Data List of tibbles
pdl <- setNames(vector("list", length = length(pd_yaml)), names(pd_yaml))
# The "note" field cannot be expected to have the same number of rows as "value",
# so to make my life easier we will import that into a separate variable
pdl_note <- setNames(vector("list", length = length(pd_yaml)), names(pd_yaml))
for (p in 1:length(pd_yaml)) {
   pdl[[p]] <-
      pd_yaml[[p]][names(pd_yaml[[p]]) %in% pdl_fields] %>%
      tibble::as_tibble() %>%
      # https://tidyr.tidyverse.org/reference/unnest_longer.html
      tidyr::unnest_longer(col = value, indices_to = "Symbol") %>%
      # note that this "value" column automatically gets an attribute "names"
      # which is redundant since we have the "symbol" column. Get rid of it.
      # To drop attributes from all columns at once: mutate(across(everything(), as.vector))
      mutate(value = as.vector(value))
   # now let's take care of the "note" field
   if (any(names(pd_yaml[[p]]) %in% c("note"))) {
      pdl_note[[p]] <-
         pd_yaml[[p]][names(pd_yaml[[p]]) %in% c("note")] %>%
         tibble::as_tibble() %>%
         tidyr::unnest_longer(col = note, indices_to = "Symbol")
      # now we can easily put "note" into place in each tibble
      # by joining by "symbol" we ensure that each note goes on the correct element's row
      pdl[[p]] <- left_join(pdl[[p]], pdl_note[[p]], by = "Symbol")
   }
}
# at this point we no longer need the pdl_note list - all its data is incorporated
# in the tibbles of pdl
# print three random tibbles from the list (poor man's quality control)
pdl[sample(1:length(pdl), 3)]

## ----yaml-reference-to-attribute--------------------------------------------------
for (p in 1:length(pd_yaml)) {
   if (any(names(pd_yaml[[p]]) %in% c("reference"))) {
      attr(pdl[[p]], "reference") <-
         pd_yaml[[p]][names(pd_yaml[[p]]) %in% c("reference")]$reference
   }
}

## ---------------------------------------------------------------------------------
pdl$Production_2010 |> attr("reference")

## ----wide-tibble-every-property---------------------------------------------------
# First, we need something to join against, for this I chose Symbol which is
# a natural choice as the unique identifier in this dataset
# For the sake of consistency, use capitalized name for Symbol column
pdt <- tibble(Symbol = pdl$Symbol$value)
for (p in which(names(pdl) != "Symbol")) {
   pdt <- left_join(
      x = pdt,
      y = pdl[[p]] |>
         # discard all columns except $value
         select(value, Symbol) |>
         # value in column $title should be set as new name for column $value.
         # Turns out it is doable, but note the unusual syntax !! :=
         # https://stackoverflow.com/questions/45472480/how-to-rename-a-column-to-a-variable-name-in-a-tidyverse-way
         dplyr::rename(!!names(pdl)[p] := value),
      by = "Symbol")
}

## ---------------------------------------------------------------------------------
pdt[, c(1, 2, sample(3:ncol(pdt)))]

## ----periodictable-dimensions-----------------------------------------------------
# dimensions (sensitive setting, box alignment will break if changed)
ptable.width  <- 9.00
ptable.height <- 5.25
element.symbol.voffset <- 0.1
element.name.voffset   <- 0.12
element.period.voffset <- 0.32
# adjusted vertical position for lanthanide period
lanthanoids.vpos <- 8.5
# adjusted vertical position for actinide period
actinoids.vpos <- 9.5
# position and size of key (legend, manual)
ptable.legend <- tibble(
   Group = 4, Period = 2,
   Symbol = "Symbol", Atomic_Number = "atomic number", Name = "name", Label = "Key:",
   Conventional_Atomic_Weight = "conventional atomic wt")

## ----periodictable-tibble---------------------------------------------------------
ptable_iupac <-
   pdt %>%
   select(Symbol, Name, Atomic_Number, Conventional_Atomic_Weight, Group, Period, Series) %>%
   # adjust vertical position for La and Ac periods *before* changing type to character
   # https://stackoverflow.com/questions/22337394/dplyr-mutate-with-conditional-values
   mutate(Period = case_when(
      # Atomic_Number >= 57 & Atomic_Number <= 71 ~ lanthanides.vpos,
      Series == "Lanthanide" ~ lanthanoids.vpos,
      # Atomic_Number >= 89 & Atomic_Number <= 103 ~ actinides.vpos,
      Series == "Actinide" ~ actinoids.vpos,
      TRUE ~ Period)) %>%
   mutate(Atomic_Number = as.character(Atomic_Number)) %>%
   # create two virtual elements as placeholders for the lanthanoids/lanthanoids labels
   tibble::add_row(
      Name = c("lanthanoids", "actinoids"),
      Group = c(3, 3),
      Period = c(6, 7),
      Atomic_Number = c("57-71", "89-103"),
      Series = c("Lanthanide", "Actinide"))

## ----periodictable-iupac-ggplot, fig.width=ptable.width, fig.height=ptable.height----
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_text()`).
## Warning: Removed 34 rows containing missing values or values outside the scale range
## (`geom_text()`).
ggplot() +
   ### LEGEND
   # key legend (manual)
   # a rectangular shape would be better... # ggstar extension? or just define a path?
   geom_point(
      data = ptable.legend,
      size = 22, shape = 0,
      aes(y = Period, x = Group)) +
   # key label
   geom_text(data = ptable.legend,
      size = 2.0, colour = "black",
      # manually adjusted until it aligned nicely with outer top-left of legend box
      aes(label = Label, y = Period - 0.8, x = Group - 0.5)) +
   # key atomic number
   geom_text(data = ptable.legend,
      size = 1.8, colour = "black",
      aes(label = Atomic_Number, y = Period - 1.1 * element.period.voffset, x = Group)) +
   # key element symbol
   geom_text(data = ptable.legend,
      size = 3, colour = "black", fontface = "bold",
      aes(label = Symbol, y = Period - element.symbol.voffset, x = Group)) +
   # key element name
   geom_text(data = ptable.legend,
      size = 1.6, colour = "black",
      aes(label = tolower(Name), y = Period + element.name.voffset, x = Group)) +
   # key atomic weight
   geom_text(data = ptable.legend,
      size = 1.6, colour = "black",
      aes(label = Conventional_Atomic_Weight, y = Period + 1.1 * element.period.voffset, x = Group)) +
   ### COPYLEFT
   annotate("text",
      x = 0.35, y = 9.5, vjust = 0.5, hjust = 0, size = 7.5,
      label = "🄍") +
   annotate("text",
      x = 0.85, y = 9.5, vjust = 0.5, hjust = 0, size = 2.6,
      label = paste0("Last updated ", Sys.Date(), "\nFreely licensed CC0")) +
   ### ELEMENTS
   scale_x_continuous(
      breaks = seq(
         min(ptable_iupac$Group),
         max(ptable_iupac$Group)),
      limits = c(
         min(ptable_iupac$Group) - 1.2,
         max(ptable_iupac$Group) + 0.8),
      expand = c(0, 0)) +
   scale_y_continuous(
      trans = "reverse",
      breaks = seq(
         min(ptable_iupac$Period),
         max(ptable_iupac$Period)),
      limits = c(
         max(ptable_iupac$Period) + 1,
         min(ptable_iupac$Period) - 1.5),
      expand = c(0, 0)) +
   # lanthanoids and actinoids background colour drawn before boxes
   geom_point(
      data = ptable_iupac %>% filter(Series == "Lanthanide"),
      size = 16,
      shape = 15,
      colour = "#cfc0c7",
      aes(y = Period, x = Group)) +
   geom_point(
      data = ptable_iupac %>% filter(Series == "Actinide"),
      size = 16,
      shape = 15,
      colour = "#a58394",
      aes(y = Period, x = Group)) +
   # boxes for all elements
   geom_point(
      data = ptable_iupac,
      # size 16 leaves no gaps between the element boxes at fig.width=9,fig.height=5.25
      size = 16,
      shape = 0,
      aes(y = Period, x = Group)) +
   # element symbol
   geom_text(
      data = ptable_iupac,
      size = 3,
      colour = "black",
      fontface = "bold",
      aes(label = Symbol, y = Period - element.symbol.voffset, x = Group)) +
   # atomic number
   geom_text(
      data = ptable_iupac,
      size = 1.8,
      colour = "black",
      aes(label = Atomic_Number, y = Period - element.period.voffset, x = Group)) +
   # element name
   geom_text(
      data = ptable_iupac,
      size = 1.6,
      colour = "black",
      aes(label = tolower(Name), y = Period + element.name.voffset, x = Group)) +
   # atomic weight
   geom_text(
      data = ptable_iupac,
      size = 1.6,
      colour = "black",
      aes(label = Conventional_Atomic_Weight, y = Period + element.period.voffset, x = Group)) +
   # period labels
   geom_text(
      data = ptable_iupac %>% filter(Period <= 7) %>% filter(Group == 1),
      size = 1.7, colour = "black",
      aes(label = Period, y = Period),
      x = 0.38) +
   # group labels # positions manually adjusted
   geom_text(
      data = data.frame(
         y = c(0.38, 1.38, rep(3.38, 10), rep(1.38, 5), 0.38),
         x = seq(1, 18)),
      size = 1.7,
      colour = "black",
      aes(label = x, x = x, y = y)) +
   # title # position manually adjusted
   annotate("text",
      x = 9, y = 0.6, vjust = 0,
      size = 4.5,
      fontface = "bold",
      label = "IUPAC Periodic Table of the Elements") +
   # subtitle # position manually adjusted
   annotate("text",
      x = 9, y = 0.74, vjust = 1,
      size = 2.6,
      label = "Created with the periodicdata package") +
   theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      plot.margin = unit(c(0, 0, -0.85, -0.85), "line"),
      axis.title = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      # center (roughly) over transition metal block
      legend.position.inside = c(0.42, 0.91),
      legend.justification = c(0.5, 1),
      legend.direction = "horizontal",
      # make the legend colourbar a little longer
      legend.key.width = unit(2.5, "line"),
      legend.title = element_blank(),
      legend.background = element_rect(fill = "transparent"))

## ----ggsave-periodictable-iupac-ggplot, eval=FALSE, echo=FALSE, warning=FALSE-----
# ### NOTE eval should not be flipped manually, use "rebuild_package.sh --refresh-demo" instead!
# # ggsave() saves the last generated plot by default
# # create.dir=TRUE creates the directory even if it does not already exist
# # PNG file uses much wider font than expected, causes overflow in some places!
# ggplot2::ggsave(filename = here::here("doc", "periodictable-iupac.png"),
#    create.dir = TRUE, width = ptable.width, height = ptable.height)
# # ggsave to PDF fails when running build_vignettes() if plot contains Unicode characters
# # but running render() works, although the CC0 symbol is not properly printed in PDF
# # https://git.solarchemist.se/taha/periodicdata/issues/18
# # https://stackoverflow.com/questions/62837580/save-unicode-characters-to-pdf-in-r
# # also, font is slightly wider than expected (but not as wide as PNG)
# ggplot2::ggsave(filename = here::here("doc", "periodictable-iupac.pdf"),
#    create.dir = TRUE, width = ptable.width, height = ptable.height)
# ggplot2::ggsave(filename = here("doc", "periodictable-iupac.svg"),
#    create.dir = TRUE, width = ptable.width, height = ptable.height)

## ----echo=FALSE, message=FALSE, results="asis"------------------------------------
source(here::here("vignettes/code/generate-markdown.R"), local = knitr::knit_global())

## ----save-package-data, eval=FALSE, echo=TRUE-------------------------------------
# ### NOTE eval should not be flipped manually, use "rebuild_package.sh --refresh-data" instead!
# periodicdata <- pdt
# usethis::use_data(periodicdata, internal = FALSE, overwrite = TRUE)
# # I think YAML format is much easier to work with than CSV in this case
# # but just in case others don't agree, let's also write a CSV for each dataframe
# readr::write_csv(periodicdata, here("inst/extdata", "periodicdata.csv"))
# # generate R/data.R
# source(here::here("vignettes/code/generate-roxygen.R"), local = knitr::knit_global())


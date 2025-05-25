
<!-- README.md is generated from README.Rmd. Please edit that file -->

# periodicdata

<!-- badges: start -->

[![DOI](https://raw.githubusercontent.com/solarchemist/periodicdata/master/man/figures/badge-doi.svg)](https://doi.org/10.5281/zenodo.5898567)
[![Vignettes](https://raw.githubusercontent.com/solarchemist/periodicdata/master/man/figures/badge-vignette.svg)](https://github.com/solarchemist/periodicdata#package-vignettes)
<!-- badges: end -->

This is an R *data* package with data in YAML format (for ease of entry
and to more easily keep track of metadata) including necessary R code to
import said data into a rectangularized tibble.

The dataset contains around 70 properties of the chemical elements. The
package has two vignettes; the first demonstrates how the YAML file is
read and saved into the tibble exported by this package, the second
show-cases how the data can be used to visualize different properties on
the canvas of the periodic table.

My hope is that this package will make it easier for chemists, teachers,
and anyone interested in chemistry to generate periodic tables of
whatever trend they wish to visualize.

<!-- PERIODIC TABLE -->

<figure>
<img
src="https://raw.githubusercontent.com/solarchemist/periodicdata/master/doc/periodictable-iupac.png"
alt="IUPAC periodic table" />
<figcaption aria-hidden="true">IUPAC periodic table</figcaption>
</figure>

## Package vignettes

- [Vignette \#1: Importing data from
  YAML](https://htmlpreview.github.io/?https://github.com/solarchemist/periodicdata/blob/master/doc/periodicdata.html)
- [Vignette \#2: Show-case of data
  visualizations](https://htmlpreview.github.io/?https://github.com/solarchemist/periodicdata/blob/master/doc/showcase.html)

## Install this package

To install this package:

    install.packages("remotes")
    remotes::install_github("solarchemist/periodicdata")

To also build the vignettes when installing this package, modify the
last line to:

    remotes::install_github("solarchemist/periodicdata", build_opts = c("--no-resave-data", "--no-manual"), build_vignettes = TRUE)

## Properties in this dataset

This list of all the properties in this dataset is dynamically generated
from the YAML dataset every time the vignette is rebuilt:

| Property | Description (truncated) | DOI | URL |
|:---|:---|:---|---:|
| Adiabatic_Index | Adiabatic index, also known as the heat capacity ratio, the ratio of specific… |  | [1](https://periodictable.com/Properties/A/AdiabaticIndex.an.html), [2](https://en.wikipedia.org/wiki/Heat_capacity_ratio) |
| Atomic_Number | Atomic number |  | [1](https://en.wikipedia.org/wiki/Atomic_number) |
| Atomic_Radius | Atomic radius | [1](https://doi.org/10.1063/1.1712084) |  |
| Atomic_Weight | Atomic weight of the longest-lived isotope. |  | [1](https://www.britannica.com/science/atomic-weight) |
| Autoignition_Point | Autoignition point |  |  |
| Block | Block |  |  |
| Boiling_Point | Boiling point at STP |  |  |
| Brinell_Hardness | Brinell hardness |  | [1](https://en.wikipedia.org/wiki/Brinell_hardness_test), [2](https://en.wikipedia.org/wiki/Hardnesses_of_the_elements_(data_page)) |
| Bulk_Modulus | Bulk modulus |  |  |
| CAS_Number | CAS registry number |  | [1](https://en.wikipedia.org/wiki/CAS_Registry_Number) |
| CID_Number | CID number |  |  |
| Colour | Colour at STP |  |  |
| Conventional_Atomic_Weight | Standard atomic weight abridged to four significant digits, for uses where a … | [1](https://doi.org/10.1021/acs.jchemed.6b00510) |  |
| Covalent_Radius | Covalent radius |  |  |
| Critical_Pressure | Critical pressure |  | [1](https://en.wikipedia.org/wiki/Critical_points_of_the_elements_(data_page)) |
| Critical_Temperature | Critical temperature |  | [1](https://en.wikipedia.org/wiki/Critical_points_of_the_elements_(data_page)) |
| Curie_Temperature | Curie temperature |  | [1](https://en.wikipedia.org/wiki/Curie_temperature) |
| DOT_Hazard_Class | US DOT hazard class |  | [1](https://en.wikipedia.org/wiki/Dangerous_goods#United_States) |
| DOT_Numbers | US DOT number |  |  |
| Decay_Mode | Decay mode |  |  |
| Density | Density at STP |  | [1](https://periodictable.com/Properties/A/Density.html) |
| Density_Liquid | Density in the liquid state |  | [1](https://periodictable.com/Properties/A/LiquidDensity.an.html) |
| Electrical_Conductivity | Electrical conductivity |  |  |
| Electrical_Resistivity | Electrical resistivity |  |  |
| Electrical_Type | Electrical type |  |  |
| Electron_Affinity | Electron affinity |  | [1](https://en.wikipedia.org/wiki/Electron_affinity_(data_page)), [2](https://en.wikipedia.org/wiki/Electron_affinity) |
| Electron_Configuration | Electron configuration |  |  |
| Electronegativity | Electronegativity (Pauling) |  | [1](https://periodictable.com/Properties/A/Electronegativity.html), [2](https://en.wikipedia.org/wiki/Electronegativity#Pauling_electronegativity), [3](https://www.webelements.com/periodicity/eneg_pauling) |
| Element_Descriptions | Element descriptions from the Debian dict-elements package v20001107-a-9.1. L… |  | [1](https://packages.debian.org/sid/all/dict-elements) |
| Gas_Phase_Configuration | Configuration in gas phase |  |  |
| Gmelin_Number | Gmelin number |  |  |
| Group | Group assignments per the IUPAC periodic table. |  |  |
| Group_Left_Step | Group assignments per the left step periodic table (Janet’s table). |  | [1](https://en.wikipedia.org/wiki/Template:Periodic_table_(left_step)) |
| Half_Life | Half-life |  |  |
| Heat_of_Combustion | Heat of combustion |  |  |
| Heat_of_Fusion | Heat of fusion |  |  |
| Heat_of_Vapourization | Heat of vapourization |  |  |
| Lifetime | Lifetime |  | [1](https://periodictable.com/Properties/A/Lifetime.html) |
| Magnetic_Susceptibility_Volume | Magnetic susceptibility by volume |  | [1](https://en.wikipedia.org/wiki/Magnetic_susceptibility#Volume_susceptibility) |
| Magnetic_Type | Magnetic type |  |  |
| Melting_Point | Melting point at STP |  |  |
| Mohs_Hardness | Mohs hardness |  | [1](https://en.wikipedia.org/wiki/Mohs_scale), [2](https://en.wikipedia.org/wiki/Hardnesses_of_the_elements_(data_page)) |
| Molar_Volume | Molar volume |  |  |
| Name | Name |  |  |
| Natural_Occurrence | Natural occurrence of the elements, whether primordial, from radioactive deca… |  | [1](https://en.wikipedia.org/wiki/Periodic_table#Structure), [2](https://en.wikipedia.org/wiki/Primordial_nuclide), [3](https://en.wikipedia.org/wiki/Trace_radioisotope), [4](https://en.wikipedia.org/wiki/Synthetic_element) |
| Neel_Point | Neel point |  | [1](https://w.wiki/E9rs) |
| Neutron_Cross_Section | Neutron cross section |  |  |
| Neutron_Mass_Absorption | Neutron mass absorption |  |  |
| Percent_in_Earths_Crust | Percent in Earth’s crust |  |  |
| Percent_in_Humans | Percent in the human body |  |  |
| Percent_in_Meteorites | Percent in meteorites |  |  |
| Percent_in_Oceans | Percent in the Earth’s oceans |  |  |
| Percent_in_Sun | Percent in the Sun |  |  |
| Percent_in_Universe | Percent in the Universe |  |  |
| Period | Period assignments per the IUPAC periodic table. |  |  |
| Period_Left_Step | Period assignments per the left step periodic table (Janet’s table). |  |  |
| Phase | Phase at STP |  |  |
| Poisson_Ratio | Poisson’s ratio |  |  |
| Price_2010 | Price in 2010 | [1](https://doi.org/10.1039/C2RA20839C) |  |
| Production_2010 | Global primary production in 2010 | [1](https://doi.org/10.1039/C2RA20839C) |  |
| Quantum_Numbers | Quantum numbers |  |  |
| RTECS_Number | RTECS number |  | [1](https://en.wikipedia.org/wiki/Registry_of_Toxic_Effects_of_Chemical_Substances) |
| Refractive_Index | Refractive index |  |  |
| Series | Series per the IUPAC periodic table. |  |  |
| Shear_Modulus | Shear modulus |  |  |
| Space_Group_Name | Space group name |  |  |
| Space_Group_Name_LaTeX | Space group name |  |  |
| Space_Group_Number | Space group number |  |  |
| Specific_Heat_Capacity | The specific heat capacity, or the isobaric mass heat capacity. |  | [1](https://periodictable.com/Properties/A/SpecificHeat.html), [2](https://en.wikipedia.org/wiki/Table_of_specific_heat_capacities), [3](https://material-properties.org/specific-heat-capacity-of-chemical-elements), [4](https://www.engineersedge.com/heat_transfer/heat_capacity_of_the_elements_13260.htm) |
| Speed_of_Sound | Speed of sound |  |  |
| Standard_Atomic_Weight | Standard atomic weight, or more correctly, standard relative atomic mass, is … | [1](https://doi.org/10.1515/pac-2019-0603), [2](https://doi.org/10.1515/pac-2016-0402) | [1](https://www.ciaaw.org/atomic-weights.htm) |
| Superconducting_Point | Superconducting point |  |  |
| Symbol | Symbol |  |  |
| Thermal_Conductivity | Thermal conductivity |  | [1](https://en.wikipedia.org/wiki/List_of_thermal_conductivities) |
| Thermal_Expansion | Thermal expansion |  |  |
| Valence | Valence electrons |  |  |
| Van_der_Waals_Radius | Corresponds well to published vdW radii in literature. |  |  |
| Vickers_Hardness | Vickers hardness |  | [1](https://en.wikipedia.org/wiki/Hardnesses_of_the_elements_(data_page)) |
| XKCD_Four_Elements | Reproduction of XKCD \#2975 published 2024-08-21. |  | [1](https://xkcd.com/2975), [2](https://www.explainxkcd.com/wiki/index.php/2975:_Classical_Periodic_Table) |
| Young_Modulus | Young’s modulus |  |  |

## Contribute to this package

Your contributions are most welcome! Please report corrections as an
issue or PR.

To add more data to the dataset, check out this repository and edit the
YAML file `inst/extdata/periodicdata.yml`.

To rebuild the package, I recommend you run the provided bash script in
`tools/`. You will of course need **R**. Other rebuild requirements are

- [`yq`](https://github.com/mikefarah/yq),
- [`pajv`](https://github.com/json-schema-everywhere/pajv),
- renv (use renv and the provided `renv.lock` file to install required R
  packages).

To checkout this repository:

``` bash
$ git clone https://github.com/solarchemist/periodicdata.git
```

To rebuild the package after having made edits to the YAML data:

``` bash
$ rebuild_package.sh --refresh-data
```

The rebuild script has more functionality; use the `--help` flag or read
its source code to familiarize yourself.

As part of the rebuild procedure `R CMD check` runs and should complete
without any errors, warnings, or notes.

## Other works citing this package

It is not really possible for me to keep track of how anyone uses this
package, nor do I have such an intention. But if you feel like letting
me know how you made use of this data or visualizations in your teaching
or work, I will gladly list you here!

- [Chemistry Student Handbook](https://dornshuld.com/books/chemistry),
  by prof. Eric Van Dornshuld, University of Georgia (2023). CC BY-NC-SA
  4.0. [Visualizes common periodic
  trends](https://dornshuld.com/books/chemistry/properties.html) and
  [kindly credits me and this
  package](https://dornshuld.com/books/chemistry/periodic-table.html).

## Package history

I released this package in 2019 spurred by the International Year of
Chemistry ([\#IYPT2019](https://www.iypt2019.org)), building mostly on
earlier work which I had until then not packaged:

- [Properties of the elements: data collection and ggplot2
  tables](https://solarchemist.se/2014/11/16/element-data), Ahmed (2014)
- [All available elemental properties plotted as periodic
  tables](https://solarchemist.se/2015/01/30/element-properties), Ahmed
  (2015)

These original web scraping scripts are preserved as package *articles*
in the vignettes directory, but no longer fill any role in maintaining
this dataset.

## Links and notes

- [Periodic table of elements by
  IUPAC](https://iupac.org/what-we-do/periodic-table-of-elements)
- [periodictable.com](http://periodictable.com), provides “curated data
  provided by Mathematica’s ElementData function from Wolfram Research,
  Inc.” on their website as HTML/CSS tables
- [Wolfram’s `ElementData()`
  function](https://reference.wolfram.com/language/ref/ElementData.html)
- [Wolfram’s `ElementData()` function -
  sources](https://reference.wolfram.com/language/note/ElementDataSourceInformation.html)
- <https://periodic-table.io>
- [NIST Chemistry WebBook](https://webbook.nist.gov/chemistry)
- [webelements.com](https://www.webelements.com) by Winter, M. (2007)
- [Atomic Weights and Isotopic Compositions with Relative Atomic Masses,
  NIST Physical Measurement
  Laboratory](https://www.nist.gov/pml/atomic-weights-and-isotopic-compositions-relative-atomic-masses)
- [Atomic Mass Data Center,
  NUBASE](http://amdc.in2p3.fr/web/nubase_en.html)
- [Barbalace, K. “Periodic Table of Elements.”
  2007](https://environmentalchemistry.com/yogi/periodic)
- [Elements in the Human Body and What They
  Do](https://sciencenotes.org/elements-in-the-human-body-and-what-they-do)
- Vesborg & Jaramillo, Addressing the terawatt challenge: scalability in
  the supply of chemical elements for renewable energy. [RSC Advances 2,
  7933–7947 (2012)](https://doi.org/10.1039/C2RA20839C).

### Other periodic table datasets

- [pTable: equation balancer, solution calculator and chemistry
  database, Python (10+ stars, ~30
  properties)](https://github.com/GideonWolfe/pTable)
- [Periodic elements data, npm (100+ stars, ~20
  properties)](https://github.com/andrejewski/periodic-table)
- [PeriodicTable.jl, Julia (20+ stars, ~20 properties with unitful
  physical
  quantities)](https://github.com/JuliaPhysics/PeriodicTable.jl)
- [Periodic-Table-JSON, simply a JSON file (100+ stars, ~20
  properties)](https://github.com/Bowserinator/Periodic-Table-JSON)
- [Extensible periodic table with x-ray and neutron scattering data,
  Python (60+ stars)](https://github.com/pkienzle/periodictable)
- [PeriodicTable, R package on CRAN, ~25
  properties](https://cran.r-project.org/web/packages/PeriodicTable/index.html)
  by Julien Idé, with data from [Data
  Explorer](http://www.data-explorer.com/data)
  <!-- http://www.data-explorer.com/content/data/periodic-table-of-elements-csv.zip -->
- [QCElemental, Python (50+ stars, exposes NIST CODATA, quantum
  chemistry data, and more)](https://github.com/MolSSI/QCElemental)
- [GTK-Periodic-Table-Molecular-Formula, C++ (\<10 stars, ~20
  properties)](https://github.com/ekuester/Periodic-Table-Molecular-Formula)
- [Periodica.Data, .NET (\<10 stars, ~20
  properties)](https://github.com/bluegrams/Periodica.Data)
- [Chemistry Utility, Python script with JSON/spreadsheets (\<10 stars,
  ~70 properties)](https://github.com/jwaitze/Chemistry-Calculations)
- [Comprehensive Periodic Table of the Elements Scrape, Python script
  with JSON/spreadsheets (\<10 stars, ~700
  properties)](https://github.com/jwaitze/Periodic-Table-of-the-Elements-Data-Scrape)
- [chemr, R package which uses Wikipedia’s chemical elements data (\<10
  stars, ~10 properties)](https://github.com/paleolimbot/chemr)
- [mendeleev package, Python (10+ stars, ~60
  properties)](https://github.com/lmmentel/mendeleev). Authored by
  Łukasz Mentel. Project supported by the Norwegian Research Council.
- [List of chemical elements, Wikipedia (~10
  properties)](https://en.wikipedia.org/wiki/List_of_chemical_elements)
- [NIST Chemistry WebBook](https://webbook.nist.gov/chemistry)
- [NIST Atomic Weights and Isotopic Compositions with Relative Atomic
  Masses](https://www.nist.gov/pml/atomic-weights-and-isotopic-compositions-relative-atomic-masses)

### More notes on the periodic table

- <https://www.chemistryworld.com/opinion/symbols-and-tables-in-chemistry/4021317.article>
- <https://blog.oup.com/2019/01/happy-sesquicentennial-periodic-table-elements>
- <https://blog.oup.com/2019/05/predicting-past-periodic-table>
- <https://blog.wikimedia.org/2017/03/21/why-i-elements>

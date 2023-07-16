<!-- badges: start -->
[![DOI](https://raw.githubusercontent.com/solarchemist/periodicdata/master/man/figures/badge-doi.svg)](https://doi.org/10.5281/zenodo.5898567)
[![Vignettes](https://raw.githubusercontent.com/solarchemist/periodicdata/master/man/figures/badge-vignette.svg)](https://github.com/solarchemist/periodicdata#read-the-vignette)
<!-- badges: end -->

# Periodic data

We have scraped a dataset consisting of all chemical elements and around 80 properties and placed them in a more easily accessible format.

This R package includes two vignettes that demonstrate a few different approaches to construct the periodic table and how to plot a property.
Our hope is that this package will make it easier for chemists and others interested in the chemical sciences to generate periodic tables of whatever trend they wish to visualise.

This package was based on some of my old projects (see Earlier work below).
But I reworked most of the code in honour of the [#IYPT2019](https://www.iypt2019.org/) and released it as an R package.

![IUPAC periodic table](https://raw.githubusercontent.com/solarchemist/periodicdata/master/doc/periodictable-ggplot.png)



## Read the vignette

+ [The vignette demonstrates how the dataset was collected, how it can be extended,
  and shows how the periodic table shown in this README was created](https://htmlpreview.github.io/?https://github.com/solarchemist/periodicdata/blob/master/doc/periodicdata.html).

If that piqued your curiosity, you might also like to read these blog posts
that provide some more examples of working with the periodic data:

+ [Properties of the elements: data collection and ggplot2 tables](https://solarchemist.se/2014/11/16/element-data/)
+ [All available elemental properties plotted as periodic tables](https://solarchemist.se/2015/01/30/element-properties/)



## Install this package

To install this package on your system, I suggest:

```
install.packages("remotes")
remotes::install_github("solarchemist/periodicdata")
```

To also build the vignette locally on your computer when installing this package,
modify the last line to:
```
remotes::install_github("solarchemist/periodicdata", build_opts = c("--no-resave-data", "--no-manual"), build_vignettes = TRUE)
```


## Develop this package

Check out the source code from this repo:
```
git clone https://github.com/solarchemist/periodicdata.git
```

I suggest the following package rebuild procedure:

+ Run `devtools::check()`.
  Should complete with no errors, warnings, or notes:
```
── R CMD check results ──────────────────────────── periodicdata 0.2.1.9000 ────
Duration: 19.1s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
```
+ Run `devtools::build_vignettes()` in the console. This recompiles the vignette
  and populates the `doc/` directory.
+ Manually remove the line `doc` from `.gitignore` (the build step keeps adding it).

Contributions are welcome, no matter whether code, bug reports or suggestions!



## Contributions welcome!

To correct or extend this dataset please open an issue or a create a pull request.
Other contributions or feedback are also welcome via this repo or
[contact me directly](https://solarchemist.se/contact).


## Data sources

+ [IUPAC periodic table of elements](https://iupac.org/what-we-do/periodic-table-of-elements/)
+ [periodictable.com](http://periodictable.com), provides "curated data provided by Mathematica's ElementData function from Wolfram Research, Inc." on their website as HTML/CSS tables
+ [PeriodicTable CRAN package by Julien Idé](https://cran.r-project.org/web/packages/PeriodicTable/index.html) with data from [Data Explorer](http://www.data-explorer.com/data)
+ [Wolfram's `ElementData()` function](https://reference.wolfram.com/language/note/ElementDataSourceInformation.html)
+ https://periodic-table.io
+ [NIST Chemistry WebBook](https://webbook.nist.gov/chemistry/)
+ [Winter, M. "WebElements." 2007](https://www.webelements.com)
+ [Atomic Weights and Isotopic Compositions with Relative Atomic Masses, NIST Physical Measurement Laboratory](https://www.nist.gov/pml/atomic-weights-and-isotopic-compositions-relative-atomic-masses)
+ [Barbalace, K. "Periodic Table of Elements." 2007](https://environmentalchemistry.com/yogi/periodic/)
+ [Atomic Mass Data Center, NUBASE](http://amdc.in2p3.fr/web/nubase_en.html)
+ [Elements in the Human Body and What They Do](https://sciencenotes.org/elements-in-the-human-body-and-what-they-do/)
+ Vesborg & Jaramillo, Addressing the terawatt challenge: scalability in the supply of chemical elements for renewable energy. [RSC Advances 2, 7933–7947 (2012)](https://doi.org/10.1039/C2RA20839C).



## Related periodic table datasets

+ [pTable: equation balancer, solution calculator and chemistry database, Python (10+ stars, ~30 properties)](https://github.com/GideonWolfe/pTable)
+ [Periodic elements data, npm (100+ stars, ~20 properties)](https://github.com/andrejewski/periodic-table)
+ [PeriodicTable.jl, Julia (20+ stars, ~20 properties with unitful physical quantities)](https://github.com/JuliaPhysics/PeriodicTable.jl)
+ [Periodic-Table-JSON, simply a JSON file (100+ stars, ~20 properties)](https://github.com/Bowserinator/Periodic-Table-JSON)
+ [Extensible periodic table with x-ray and neutron scattering data, Python (60+ stars)](https://github.com/pkienzle/periodictable)
+ [PeriodicTable, R (~25 properties, CRAN package including dataset)](https://cran.r-project.org/package=PeriodicTable)[^julianide]
+ [QCElemental, Python (50+ stars, exposes NIST CODATA, quantum chemistry data, and more)](https://github.com/MolSSI/QCElemental)
+ [GTK-Periodic-Table-Molecular-Formula, C++ (<10 stars, ~20 properties)](https://github.com/ekuester/Periodic-Table-Molecular-Formula)
+ [Periodica.Data, .NET (<10 stars, ~20 properties)](https://github.com/bluegrams/Periodica.Data)
+ [Chemistry Utility, Python script with JSON/spreadsheets (<10 stars, ~70 properties)](https://github.com/jwaitze/Chemistry-Calculations)
+ [Comprehensive Periodic Table of the Elements Scrape, Python script with JSON/spreadsheets (<10 stars, ~700 properties)](https://github.com/jwaitze/Periodic-Table-of-the-Elements-Data-Scrape)
+ [chemr, R package which uses Wikipedia's chemical elements data (<10 stars, ~10 properties)](https://github.com/paleolimbot/chemr)
+ [mendeleev package, Python (10+ stars, ~60 properties)](https://github.com/lmmentel/mendeleev). Authored by Łukasz Mentel. Project supported by the Norwegian Research Council.
+ [List of chemical elements, Wikipedia (~10 properties)](https://en.wikipedia.org/wiki/List_of_chemical_elements)
+ [NIST Chemistry WebBook](https://webbook.nist.gov/chemistry/)
+ [NIST Atomic Weights and Isotopic Compositions with Relative Atomic Masses](https://www.nist.gov/pml/atomic-weights-and-isotopic-compositions-relative-atomic-masses)
+ [Wolfram language `ElementData()` function (closed-source)](https://reference.wolfram.com/language/note/ElementDataSourceInformation.html)

[^julianide]: [http://www.data-explorer.com/content/data/periodic-table-of-elements-csv.zip](http://www.data-explorer.com/content/data/periodic-table-of-elements-csv.zip)



## Properties in this dataset

A list of every property in this dataset.
If comment does not mention source then it was sourced from [periodictable.com](http://periodictable.com).

| Property                       | Comment |
| ---                            | --- |
| Name                           |  |
| Symbol                         |  |
| Atomic_Number                  | [Atomic_number (Wikipedia)](https://en.wikipedia.org/wiki/Atomic_number) |
| Atomic_Weight                  | given for the longest lived isotope  |
| Density                        |  |
| Melting_Point                  |  |
| Boiling_Point                  |  |
| Phase                          | at NTP |
| Absolute_Melting_Point         |  |
| Absolute_Boiling_Point         |  |
| Critical_Pressure              |  |
| Critical_Temperature           |  |
| Heat_of_Fusion                 |  |
| Heat_of_Vaporization           |  |
| Specific_Heat                  |  |
| Adiabatic_Index                |  |
| Neel_Point                     | [Neel temperature (Wikipedia)](https://en.wikipedia.org/wiki/N%C3%A9el_temperature) |
| Thermal_Conductivity           |  |
| Thermal_Expansion              |  |
| Density_Liquid                 |  |
| Molar_Volume                   |  |
| Brinell_Hardness               |  |
| Mohs_Hardness                  |  |
| Vickers_Hardness               |  |
| Bulk_Modulus                   |  |
| Shear_Modulus                  |  |
| Young_Modulus                  |  |
| Poisson_Ratio                  |  |
| Refractive_Index               |  |
| Speed_of_Sound                 |  |
| Valence                        |  |
| Electronegativity              | [Electronegativity by Pauling scale](https://en.wikipedia.org/wiki/Electronegativity) |
| ElectronAffinity               | [Wiki article](https://en.wikipedia.org/wiki/Electron_affinity), [Wiki data page](https://en.wikipedia.org/wiki/Electron_affinity_(data_page)) |
| DOT_Hazard_Class               | [US DOT Hazard class (Wikipedia)](https://en.wikipedia.org/wiki/Dangerous_goods#United_States) |
| DOT_Numbers                    | US DOT number |
| RTECS_Number                   | [Registry of Toxic Effects of Chemical Substances](https://en.wikipedia.org/wiki/Registry_of_Toxic_Effects_of_Chemical_Substances) |
| Alternate_Names                |  |
| Block                          | *s*, *p*, *d* and so on |
| Group                          |  |
| Period                         |  |
| Series                         | `Series` and `IUPAC_Series` should perhaps be remade and more rigorously sourced |
| Electron_Configuration         |  |
| Color                          |  |
| Gas_phase                      | Mono- or diatomic gas in its natural state |
| CAS_Number                     | [CAS registry number (Wikipedia)](https://en.wikipedia.org/wiki/CAS_Registry_Number) |
| CID_Number                     | Compound identification number (PubChem?) |
| Electrical_Type                |  |
| Electrical_Conductivity        |  |
| Resistivity                    |  |
| Superconducting_Point          |  |
| Magnetic_Type                  |  |
| Curie_Point                    | [Curie temperature (Wikipedia)](https://en.wikipedia.org/wiki/Curie_temperature) |
| Mass_Magnetic_Susceptibility   |  |
| Molar_Magnetic_Susceptibility  |  |
| Volume_Magnetic_Susceptibility |  |
| Percent_in_Universe            |  |
| Percent_in_Sun                 |  |
| Percent_in_Meteorites          |  |
| Percent_in_Earths_Crust        |  |
| Percent_in_Oceans              |  |
| Percent_in_Humans              |  |
| Atomic_Radius                  | corresponds well to radii computed from theoretical models by [Clementi et al.](https://doi.org/10.1063%2F1.1712084) |
| Covalent_Radius                | not sure what source periodictable.com got this property from... [Atomic radius (Wikipedia)](https://en.wikipedia.org/wiki/Atomic_radius) |
| Van_der_Waals_Radius           | correspond to published vdW radii in literature |
| Space_Group_Name               |  |
| Space_Group_Number             |  |
| HalfLife                       |  |
| Lifetime                       |  |
| Decay_Mode                     |  |
| Quantum_Numbers                |  |
| Neutron_Cross_Section          |  |
| Neutron_Mass_Absorption        |  |
| Autoignition_Point             |  |
| Flashpoint                     |  |
| Heat_of_Combustion             |  |
| Gmelin_Number                  |  |
| Production                     | global primary production in 2010, kg/yr (Vesborg & Jaramillo, 2012) |
| Price                          | price in 2010, USD/kg (Vesborg & Jaramillo, 2012) |
| IUPAC_Period                   | period numbers re-defined to produce IUPAC-style table |
| IUPAC_Group                    | group numbers re-defined to produce IUPAC-style table |
| IUPAC_Number                   | atomic numbers as shown in IUPAC-style table |
| IUPAC_Series                   |  |

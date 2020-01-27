# Periodic data

We have scraped a dataset consisting of all chemical elements and around 80 properties and placed them in a more easily accessible format.

This package includes two vignettes that demonstrate a few different approaches to construct the periodic table and how to plot a property. 
Our hope is that this package will make it easier for chemists and others interested in the chemical sciences to generate periodic tables of whatever trend they wish to visualise.

This package was based on some of my old projects (see Earlier work below).
But I reworked most of the code in honour of the [#IYPT2019](https://www.iypt2019.org/) and released it as an R package.

![IUPAC periodic table](https://raw.githubusercontent.com/chepec/periodicdata/master/doc/periodictable-ggplot.png)



## So what can this package do?

Please [have a look at the vignette](https://htmlpreview.github.io/?https://github.com/chepec/periodicdata/blob/master/doc/periodicdata.html).
You might also like to skim through these blog posts that demonstrate some more examples:

+ [Properties of the elements: data collection and ggplot2 tables](https://chepec.se/2014/11/16/element-data/)
+ [All available elemental properties plotted as periodic tables](https://chepec.se/2015/01/30/element-properties/)



## Install this package

To install this package on your system, I suggest: 

```
install.packages("devtools")
devtools::install_github("chepec/periodicdata")
```

Note that `devtools` [does not build vignettes by default](https://github.com/r-lib/devtools/issues/1896) 
[when installing packages](https://stackoverflow.com/a/33617870/1198249). 
To build the vignette when installing this package, replace the last line above with

```
devtools::install_github("chepec/periodicdata", build_opts = c("--no-resave-data", "--no-manual"), build_vignettes = TRUE)
```


## Develop this package

To check out the source code (perhaps to work on the code and contribute code back ;-), you should `git clone`. Note that this does not tell your R anything about the package.

```
git clone https://github.com/chepec/periodicdata.git
```


## Contributions welcome

If you would like to add to this dataset you're very welcome. Open an issue or a pull request.

And please let me know if you find any errors in the data or the code.


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

Most properties in this dataset were sourced from http://periodictable.com/. 
Below follows a short description of each property. Source is only noted if other than the one mentioned above.

| Property                       | Comment | 
| ---                            | --- | 
| Name                           |  |
| Symbol                         |  |
| Atomic_Number                  | [^atomicnumber] |
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
| Neel_Point                     | [antiferromagnetic elements](https://en.wikipedia.org/wiki/N%C3%A9el_temperature) |
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
| DOT_Hazard_Class               | US DOT Hazard class[^dothazardclass] |
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
| CAS_Number                     | [CAS registry number](https://en.wikipedia.org/wiki/CAS_Registry_Number) |
| CID_Number                     | Compound identification number (PubChem?) |
| Electrical_Type                |  |
| Electrical_Conductivity        |  |
| Resistivity                    |  |
| Superconducting_Point          |  |
| Magnetic_Type                  |  |
| Curie_Point                    | [temperature above which permanent magnetic property is lost](https://en.wikipedia.org/wiki/Curie_temperature) |
| Mass_Magnetic_Susceptibility   |  |
| Molar_Magnetic_Susceptibility  |  |
| Volume_Magnetic_Susceptibility |  |
| Percent_in_Universe            |  |
| Percent_in_Sun                 |  |
| Percent_in_Meteorites          |  |
| Percent_in_Earths_Crust        |  |
| Percent_in_Oceans              |  |
| Percent_in_Humans              |  |
| Atomic_Radius                  | corresponds well to radii computed from theoretical models by Clementi et al.[^Clementi1967] |
| Covalent_Radius                | not sure what source periodictable.com got this property from...[^atomicradius] |
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
| IUPAC_Period                   | period numbers re-defined to produce IUPAC-style table |
| IUPAC_Group                    | group numbers re-defined to produce IUPAC-style table |
| IUPAC_Number                   | atomic numbers as shown in IUPAC-style table |
| IUPAC_Series                   |  |

[^atomicnumber]: [https://en.wikipedia.org/wiki/Atomic_number](https://en.wikipedia.org/wiki/Atomic_number)
[^dothazardclass]: [https://en.wikipedia.org/wiki/Dangerous_goods#United_States](https://en.wikipedia.org/wiki/Dangerous_goods#United_States)
[^Clementi1967]:  [Clementi, E.; Raimond, D. L.; Reinhardt, W. P. (1967). "Atomic Screening Constants from SCF Functions. II. Atoms with 37 to 86 Electrons". Journal of Chemical Physics. 47 (4): 1300–1307](https://doi.org/10.1063%2F1.1712084)
[^atomicradius]: [https://en.wikipedia.org/wiki/Atomic_radius](https://en.wikipedia.org/wiki/Atomic_radius)

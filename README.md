# Periodic data

We have scraped a dataset consisting of all chemical elements and around 80 properties and placed them in a more easily accessible format.

This package includes two vignettes that demonstrate a few different approaches to construct the periodic table and how to plot a property. 
Our hope is that this package will make it easier for chemists and others interested in the chemical sciences to generate periodic tables of whatever trend they wish to visualise.

This package was based on some of my old projects (see Earlier work below).
But I reworked most of the code in honour of the [#IYPT2019](https://www.iypt2019.org/) and released it as an R package.

![IUPAC periodic table](https://raw.githubusercontent.com/chepec/periodicdata/master/vignettes/periodictable-ggplot.png)


## Install this package

To install this package on your system, I suggest: 

```
install.packages("devtools")
library(devtools)
install_github("chepec/periodicdata")
```


## Develop this package

To check out the source code (perhaps to work on the code and contribute code back ;-), you should `git clone`. Note that this does not tell your R anything about the package.

```
git clone https://github.com/chepec/periodicdata.git
```


## Contributions welcome

If you would like to add to this dataset you're very welcome. Open an issue or a pull request.

And please let me know if you find any errors in the data or the code.



## Own work in the same vein

+ [Properties of the elements: data collection and ggplot2 tables](https://chepec.se/2014/11/16/element-data/)
+ [All available elemental properties plotted as periodic tables](https://chepec.se/2015/01/30/element-properties/)




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

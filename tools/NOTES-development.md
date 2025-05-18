## setting up fresh

```
$ R

R version 4.5.0 (2025-04-11) -- "How About a Twenty-Six"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu

> renv::init()
This project contains a DESCRIPTION file.
Which files should renv use for dependency discovery in this project?

1: Use only the DESCRIPTION file. (explicit mode)
2: Use all files in this project. (implicit mode)

Selection: 2
- Using 'implicit' snapshot type. Please see `?renv::snapshot` for more details.

- Linking packages into the project library ... Done!
- Resolving missing dependencies ...
# Installing packages --------------------------------------------------------
- Installing ggrepel ...                        OK [linked from cache]
The following package(s) will be updated in the lockfile:

# CRAN -----------------------------------------------------------------------
- askpass        [* -> 1.2.1]
- base64enc      [* -> 0.1-3]
- bit            [* -> 4.6.0]
- bit64          [* -> 4.6.0-1]
- bslib          [* -> 0.9.0]
- cachem         [* -> 1.1.0]
- cli            [* -> 3.6.5]
- clipr          [* -> 0.8.0]
- cpp11          [* -> 0.5.2]
- crayon         [* -> 1.5.3]
- credentials    [* -> 2.0.2]
- curl           [* -> 6.2.2]
- desc           [* -> 1.4.3]
- digest         [* -> 0.6.37]
- dplyr          [* -> 1.1.4]
- evaluate       [* -> 1.0.3]
- fansi          [* -> 1.0.6]
- farver         [* -> 2.1.2]
- fastmap        [* -> 1.2.0]
- fontawesome    [* -> 0.5.3]
- fs             [* -> 1.6.6]
- generics       [* -> 0.1.3]
- gert           [* -> 2.1.5]
- ggplot2        [* -> 3.5.2]
- ggrepel        [* -> 0.9.6]
- gh             [* -> 1.4.1]
- gitcreds       [* -> 0.1.2]
- glue           [* -> 1.8.0]
- gtable         [* -> 0.3.6]
- here           [* -> 1.0.1]
- highr          [* -> 0.11]
- hms            [* -> 1.1.3]
- htmltools      [* -> 0.5.8.1]
- httr           [* -> 1.4.7]
- httr2          [* -> 1.1.2]
- ini            [* -> 0.3.1]
- isoband        [* -> 0.2.7]
- jquerylib      [* -> 0.1.4]
- jsonlite       [* -> 2.0.0]
- knitr          [* -> 1.50]
- labeling       [* -> 0.4.3]
- lattice        [* -> 0.22-6]
- lifecycle      [* -> 1.0.4]
- magrittr       [* -> 2.0.3]
- MASS           [* -> 7.3-65]
- Matrix         [* -> 1.7-3]
- memoise        [* -> 2.0.1]
- mgcv           [* -> 1.9-1]
- mime           [* -> 0.13]
- nlme           [* -> 3.1-168]
- openssl        [* -> 2.3.2]
- pillar         [* -> 1.10.2]
- pkgconfig      [* -> 2.0.3]
- prettyunits    [* -> 1.2.0]
- progress       [* -> 1.2.3]
- purrr          [* -> 1.0.4]
- R6             [* -> 2.6.1]
- rappdirs       [* -> 0.3.3]
- RColorBrewer   [* -> 1.1-3]
- Rcpp           [* -> 1.0.14]
- readr          [* -> 2.1.5]
- renv           [* -> 1.1.4]
- rlang          [* -> 1.1.6]
- rmarkdown      [* -> 2.29]
- rprojroot      [* -> 2.0.4]
- rstudioapi     [* -> 0.17.1]
- rvest          [* -> 1.0.4]
- sass           [* -> 0.4.10]
- scales         [* -> 1.4.0]
- selectr        [* -> 0.4-2]
- stringi        [* -> 1.8.7]
- stringr        [* -> 1.5.1]
- svglite        [* -> 2.1.3]
- sys            [* -> 3.4.3]
- tibble         [* -> 3.2.1]
- tidyselect     [* -> 1.2.1]
- tinytex        [* -> 0.57]
- tzdb           [* -> 0.5.0]
- usethis        [* -> 3.1.0]
- utf8           [* -> 1.2.5]
- vctrs          [* -> 0.6.5]
- viridisLite    [* -> 0.4.2]
- vroom          [* -> 1.6.5]
- whisker        [* -> 0.4.1]
- withr          [* -> 3.0.2]
- xfun           [* -> 0.52]
- xml2           [* -> 1.3.8]
- yaml           [* -> 2.3.10]
- zip            [* -> 2.3.2]

The version of R recorded in the lockfile will be updated:
- R              [* -> 4.5.0]

- Lockfile written to "/media/bay/taha/chepec/chetex/common/R/periodicdata/renv.lock".
- renv activated -- please restart the R session.
```

Also for the sake of VScodium it is a good idea to install the following packages:
```
> install.packages(c("languageserver", "jsonlite"))
# Downloading packages -------------------------------------------------------
- Downloading languageserver from CRAN ...      OK [file is up to date]
- Downloading collections from CRAN ...         OK [file is up to date]
- Downloading lintr from CRAN ...               OK [file is up to date]
- Downloading backports from CRAN ...           OK [30 Kb in 0.29s]
- Downloading rex from CRAN ...                 OK [file is up to date]
- Downloading lazyeval from CRAN ...            OK [file is up to date]
- Downloading xmlparsedata from CRAN ...        OK [file is up to date]
- Downloading styler from CRAN ...              OK [file is up to date]
- Downloading R.cache from CRAN ...             OK [file is up to date]
- Downloading R.methodsS3 from CRAN ...         OK [file is up to date]
- Downloading R.oo from CRAN ...                OK [file is up to date]
- Downloading R.utils from CRAN ...             OK [file is up to date]
Successfully downloaded 12 packages in 5.2 seconds.

The following package(s) will be installed:
- backports      [1.5.0]
- collections    [0.3.7]
- languageserver [0.3.16]
- lazyeval       [0.2.2]
- lintr          [3.2.0]
- R.cache        [0.17.0]
- R.methodsS3    [1.8.2]
- R.oo           [1.27.1]
- R.utils        [2.13.0]
- rex            [1.2.1]
- styler         [1.10.3]
- xmlparsedata   [1.0.5]
These packages will be installed into "~/.cache/R/renv/library/periodicdata-437acd4d/linux-ubuntu-jammy/R-4.5/x86_64-pc-linux-gnu".

Do you want to proceed? [Y/n]: Y
```




## renv

I could not find any `renv/library/`, which I thought was weird. Although renv was not complaining.
So I issued `renv::rebuild()`, which proceeded to redownload and recompile all packages
into `~/.cache/R/renv/library/periodicdata-437acd4d/linux-ubuntu-jammy/R-4.5/x86_64-pc-linux-gnu`
(there was no choice about that path).

So it seems renv prefers to put its library there rather than in `renv/library/`? I'm not sure if
this is because of some config setting, or simply new renv default behaviour.
In any case this entire folder is gitignored, so I don't really mind except for the slight
overhead if wanting to inspect the library (in case of problems).




## Gemerate Roxygen2 documentation for dataset

Would it be possible to generate the entire `data.R` file or at least the list
of column names (the `\describe{...}` block) as part of our package rebuild shell script?

Good news, we might not need to re-invent the wheel - look into `sinew::makeOxygen()`.


+ https://r-pkgs.org/data.html
+ https://roxygen2.r-lib.org/articles/rd-other.html
+ https://grasshoppermouse.github.io/posts/2017-10-18-put-your-data-in-an-r-package
+ https://rstudio4edu.github.io/rstudio4edu-book/data-pkg.html
+ https://stackoverflow.com/questions/2310409/how-can-i-document-data-sets-with-roxygen
+ http://r-posts.com/adding-sinew-to-roxygen2-skeletons
+ https://yonicd.github.io/sinew/reference/makeOxyFile.html
+ https://stackoverflow.com/questions/51092509/whats-the-best-way-to-automatically-generate-roxygen2-documentation-for-a-data
+ https://blog.r-hub.io/2020/05/29/distribute-data

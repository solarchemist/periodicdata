# Data


## Top-level organization of YAML data

I have chosen to structure the YAML to make it easy to add new properties.

Each property **must** have the following dicts:

+ `title` - human-readable name of the property (string)
+ `value` - value for each element (named list of strings/numeric)

Each property may also have any of the following dicts:

+ `unit` - a string (important that it is string and not numeric, even when
  dimensionless `"1"`)
+ `title_symbol` - a string, in Markdown notation, rendered in plots with `ggtext`
  (note that subscripts and/or superscripts require HTML tags even in Markdown).
  I considered naming this field simply `symbol`, but the risk for confusion with
  the table's unique column `Symbol` would be too great.
+ `description` - a string, optionally multi-line
+ `footnote` - a string, optionally multi-line
+ `reference` - a list of arbitrary length, where each list element is a dict
  of `url`, `doi`, and/or `citation`
+ `note` - a note for each element (named list), *not* necessarily
  same length as `value` list



An example:
```
Symbol:
  title: Symbol
  value:
    - "H":  "H"
    - "He": "He"
    - "Li": "Li"
Density:
  title: Density at STP
  unit: "kg/m^3"
  reference:
    - url: https://periodictable.com/Properties/A/Density.html
  note:
    - "H":  "Density given for H2 at 0 °C."
    - "He": "Density at 0 °C."
    - "C":  "Value given for graphite form. Density of diamond form is 3500."
  value:
    - "H":  0.0899
    - "He": 0.1785
    - "Li": 535
Space_Group_Name_LaTeX:
  title: Space group name
  footnote: >
    In LaTeX syntax to remove any ambiguities.
  value:
    - "H":  '\ensuremath{P6_3/mmc}'
    - "He": '\ensuremath{Fm\bar{3}m}'
    - "Li": '\ensuremath{Im\bar{3}m}'
Specific_Heat_Capacity:
  title: Specific heat capacity
  unit: "J/(kg K)"
  description: >
    The specific heat capacity, or the isobaric mass heat capacity.
  reference:
    - url: https://periodictable.com/Properties/A/SpecificHeat.html
    - url: https://en.wikipedia.org/wiki/Table_of_specific_heat_capacities
  note:
    - "H":  "Value for gas phase of H2."
    - "He": "Value for gas phase."
    - "Li": "Value for solid phase."
  value:
    - "H":  14300
    - "He": 5193.1
    - "Li": 3570
```



## Data entry "gotchas"


### Letters Y, N, etc. converted to boolean unless explicitly strings

The single letters `Y` (yes, but which for us is yttrium) and `N` (no, but which we know as nitrogen)
are automatically converted to boolean, and so are `No` (which we know as nobelium).

To avoid this you need to explicitly make them strings (`"Y"`, `"N"`, `"No"`, etc.).

Note that this affects the left-hand side of named lists as well!


### How to enter `NA`, `NaN` and other numeric specials

YAML does not recognize `NA`, so don't use it!
Instead, enter `null` which becomes `NA` after importing to R, or
enter `.nan` which becomes `NaN` in R.

We can also use `.inf` to get `Inf` in R (YAML knows both `+.inf` and `-.inf`).

+ https://ref.coddy.tech/yaml/yaml-numbers
+ https://github.com/crystal-lang/crystal/issues/4384#issuecomment-319305802


### Scientific format becomes string(!) unless it includes decimal point

When entering numeric values in scientific format, a value such as `5.9e-06`
will be correctly translated to an R `double`, but the value `1e-05` will
be translated to type `character`!
This is correctly highlighted by the syntax highlighter, by the way, but I
did not at first believe it.
It is enough to add a decimal point to correctly translate it to `double` again:
`1.e-05`.



## Links and notes

+ https://github.com/ropensci/DataPackageR
+ https://cran.r-project.org/web/packages/DataPackageR/vignettes/Using_DataPackageR.html
+ https://ropensci.org/blog/2019/12/08/precompute-vignettes
+ https://r-pkgs.org/vignettes.html#sec-vignettes-article

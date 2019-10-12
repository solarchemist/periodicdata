## ----'R-setup', echo=F, results='hide', cache=FALSE-------------------------------
# Note that we are not doing anything with R in this document
# It's just included so the vignette check in devtools package build does not complain
options(
   digits   = 7,
   width    = 84,
   continue = "  ",
   prompt   = "> ",
   stringsAsFactors = FALSE)

## ----'load-R-packages', echo=F, results='hide', message=FALSE---------------------
library(periodicdata)
# packages listed here should also be listed under Suggests in DESCRIPTION
library(dplyr)
library(knitr)
opts_knit$set(
   self.contained = FALSE,
   child.path = '')
opts_chunk$set(
   cache = FALSE,
   size = 'footnotesize',
   echo = FALSE,
   eval = TRUE,
   results = 'hide',
   message = FALSE,
   tidy = FALSE)

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "1")
cat(paste0("\\node[name=", this$Symbol,
       # this construct makes sure we always refer to the element above in the group
       # head(x, -1) removes the last element of a vector
       c("", paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       # the following row: {Atomic_Number}{Atomic_Weight}{Symbol}{Name}
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[2]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "2")
cat(paste0("\\node[name=", this$Symbol,
       # this construct makes sure we always refer to the element above in the group
       # head(x, -1) removes the last element of a vector
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[3]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(IUPAC_Group == "3")
cat(paste0("\\node[name=", this$Name,
       # this construct makes sure we always refer to the element above in the group
       # head(x, -1) removes the last element of a vector
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Name, -1))), ", ",
       this$IUPAC_Series, "] {",
       "\\NaturalElementTextFormat",
       # we make special consideration so NAs are not printed
       "{", this$IUPAC_Number, "}{",
       ifelse(is.na(this$Atomic_Weight), "", this$Atomic_Weight), "}{",
       ifelse(is.na(this$Symbol), "", this$Symbol), "}{", this$Name, "}};\n"))
this.rightof <- this$Name[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "4")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "5")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "6")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "7")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "8")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "9")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "10")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "11")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "12")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "13") %>% arrange(factor(Period, levels = c(4:2,5:7)))
cat(paste0("\\node[name=", this$Symbol,
       # note: order is important here, the element above of or right of needs to exist first
       c(paste0(", right of=", this.rightof),   # Ga to the right of Zn
         paste0(", above of=", this$Symbol[1]), # Al above of Ga
         paste0(", above of=", this$Symbol[2]), # B above of Al
         paste0(", below of=", this$Symbol[c(1,4,5)])), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[which(this$Period == 2)]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "14")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "15")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "16")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$IUPAC_Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "17")
cat(paste0("\\node[name=", this$Symbol,
       c(paste0(", right of=", this.rightof),
         paste0(", below of=", head(this$Symbol, -1))), ", ",
       this$IUPAC_Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(Group == "18") %>% arrange(factor(Period, levels = c(2,1,3:7)))
cat(paste0("\\node[name=", this$Symbol,
       # note: order is important here, the element above of or right of needs to exist first
       c(paste0(", right of=", this.rightof),   # Ne to the right of F
         paste0(", above of=", this$Symbol[1]), # He above of Ne
         paste0(", below of=", this$Symbol[c(1,3:6)])), ", ",
       this$Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))

## ----echo=F, results='asis'-------------------------------------------------------
periods <- values %>% filter(!is.na(Period)) %>% pull(Period) %>% unique() %>% as.numeric()
for (p in 1:max(periods)) {
   cat(paste0("\\node[name=Period", p, ", ",
              "left of=", values %>% filter(Period == p) %>% filter(Group == 1) %>% pull(Symbol), ", ",
              "PeriodLabel] {", p, "};\n"))
}

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(IUPAC_Series == "Lanthanide") %>% filter(!is.na(Atomic_Number))
cat(paste0("\\node[name=", this$Symbol,
       # place the first lanthanide below Rutherfordium
       c(", below of=Rf, yshift=-1.4cm",
         paste0(", right of=", head(this$Symbol, -1))), ", ",
       this$IUPAC_Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))
this.rightof <- this$Symbol[1]

## ----echo=F, results='asis'-------------------------------------------------------
this <- values %>% filter(IUPAC_Series == "Actinide") %>% filter(!is.na(Atomic_Number))
cat(paste0("\\node[name=", this$Symbol,
       # place the first actinide below La
       c(paste0(", below of=", this.rightof),
         paste0(", right of=", head(this$Symbol, -1))), ", ",
       this$IUPAC_Series, "] {",
       ifelse(is.infinite(this$Lifetime),
              "\\NaturalElementTextFormat",
              "\\SyntheticElementTextFormat"),
       "{", this$Atomic_Number, "}{", this$Atomic_Weight, "}{", this$Symbol, "}{", this$Name, "}};\n"))


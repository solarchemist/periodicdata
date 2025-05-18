#!/usr/bin/env bash

# This script streamlines the package rebuild procedure
# By solarchemist, 2025-05-18

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
# https://betterdev.blog/minimal-safe-bash-script-template
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") <flags>

This script calls R CMD check, builds vignettes, and cleans up after itself.

Available flags:
--help             --> display this usage guide
--skip-check       --> skip the devtools::check() step
--skip-vignettes   --> skip the devtools::build_vignettes() step
--refresh-data     --> overwrite exported package data
--refresh-demo     --> regenerate periodictable image files on disk
--render-articles  --> render articles (not vignettes)

EOF
   exit
}

msg() {
   # prepended by a unique-ish symbol to distinguish script's own output
   echo >&2 -e "<\/> ${1-}"
}

# die() examples:
# die "some message"
# die "some message and wait 6 seconds before exiting" 6
# die "some message and exit immediately" 0
die() {
   local msg=$1
   msg "$msg"
   # short delay to aid reading last message in case terminal closes on exit
   # if $2 was provided, use that as delay
   # if $2 was unset or null, use a three (3) second delay
   simpledelay.sh ${2:-3}
   exit 0
}

parse_params() {
   while :; do
      case "${1-}" in
      -h | --help) usage ;;
      -v | --verbose) set -x ;;
      --skip-check)
         skip_check=true
         ;;
      --skip-vignettes)
         skip_vignettes=true
         ;;
      --refresh-data)
         refresh_data=true
         ;;
      --refresh-demo)
         refresh_demo=true
         # if refresh-demo let's assume the user has already run check, no need
         # to waste their time re-running it
         # vignette building can be safely skipped because we will re-run it
         # as part of regenerating the doc/ files anyway
         skip_check=true
         skip_vignettes=true
         ;;
      --render-articles)
         render_articles=true
         skip_check=true
         skip_vignettes=true
         ;;
      -?*) die "Unknown option: $1" ;;
      *) break ;;
      esac
      shift
   done
   args=("$@")
   return 0
}

skip_check=false
skip_vignettes=false
refresh_data=false
refresh_demo=false
render_articles=false
parse_params "$@"


msg "Rebuild package README"
Rscript -e "devtools::build_readme()"

msg "Clearing vignette caches"
rm -rf ./vignettes/**/*_cache
rm -rf ./vignettes/**/*_files

if [[ $skip_check == "false" ]]; then
   msg "devtools::check()"
   Rscript -e "devtools::check()"
fi

# NOTE!!!
# > Most developers should avoid using build_vignettes() [except for preparing CRAN submissions]
# > https://r-pkgs.org/vignettes.html#sec-vignettes-how-built
# But I do not see a way to build Quarto vignettes without using build_vignettes or,
# devtools::install which in my eyes would be even worse. Plus, I would prefer a function
# that renders all vignettes irrespective of type (I still use Rnw and Rmd).
# https://github.com/quarto-dev/quarto-cli/discussions/2307
# https://github.com/quarto-dev/quarto-r/pull/146
if [[ $skip_vignettes == "false" ]]; then
   msg "devtools::build_vignettes()"
   # this creates the doc/ directory and its contents
   Rscript -e "devtools::build_vignettes()"
fi

# because periodicdata tibble is rebuilt in vignette, this chunk should occur after
# build_vignettes for package data to be updated
if [[ $refresh_data == "true" ]]; then
   msg "Overwrite package data objects in R/sysdata.rda"
   # find this line in vignettes/periodicdata.Rmd
   # ```{r save-package-data, eval=FALSE}
   # and reset eval to TRUE
   # This sed command works even if other knitr params precede/follow on the same line
   sed -E -i 's/(^```\{r save-package-data.+?)eval=FALSE/\1eval=TRUE/' vignettes/periodicdata.Rmd
   Rscript -e "rmarkdown::render('vignettes/periodicdata.Rmd', output_format = 'html_vignette')"
   # reset eval back to FALSE
   sed -E -i 's/(^```\{r save-package-data.+?)eval=TRUE/\1eval=FALSE/' vignettes/periodicdata.Rmd
fi

if [[ $refresh_demo == "true" ]]; then
   msg "Regenerate periodictable image files (PNG, PDF, SVG) in doc/"
   # find this line in vignettes/periodicdata.Rmd
   # ```{r ggsavechunk, echo=TRUE, eval=FALSE}
   # and reset eval to TRUE
   # This sed command appears to work very nicely - works even if other params follow without affecting them
   sed -E -i 's/(^```\{r ggsavechunk.+?)eval=FALSE/\1eval=TRUE/' vignettes/periodicdata.Rmd
   Rscript -e "rmarkdown::render('vignettes/periodicdata.Rmd', output_format = 'html_vignette')"
   # reset eval back to FALSE
   sed -E -i 's/(^```\{r ggsavechunk.+?)eval=TRUE/\1eval=FALSE/' vignettes/periodicdata.Rmd
fi

if [[ $render_articles == "true" ]]; then
   msg "Rendering any articles in vignettes/articles/ directory"
   # If using output_format=NULL then the output format is the first one defined in the YAML
   # frontmatter in the input file (this defaults to HTML if no format is specified there).
   # https://rmarkdown.rstudio.com/docs/reference/render.html
   # note it is crucial to surround the filepath in render() with quotes
   find "vignettes/articles" \( -name "*.[Rr]nw" -o -name "*.[Rr]md" -o -name "*.[Qq]md" \) -type f -exec Rscript -e "rmarkdown::render('{}', output_format = NULL)" \;
fi


# it's important to push doc/ to remote forge (contains generated HTML of vignette, and more)
# unfortunately build_vignettes() keeps adding "doc" to .gitignore
msg "Ensure doc/ is not present in .gitignore"
# note: sed default BRE syntax is annoying, so -E to enable Extended RE syntax
# this command should delete the entire line (and not just its contents), not
# leaving any trailing extra empty line (these empty lines add up otherwise)
sed -E -i '/^\/?doc\/?/d' .gitignore

exit 0

source(here::here("vignettes/code/build-metadata.R"), local = knitr::knit_global())


# in this script we are working under the assumption that this package's data
# is loaded in the namespace (periodicdata) and that we have access
# to readme_tibble_wide and readme_tibble_long (achieved by source() above)

tibble_head <- tibble::tribble(
   ~labels,        ~text,
   "@name",        deparse(substitute(periodicdata)),
   "@title",       "Properties of the chemical elements",
   "@description", "Tibble with many physical and chemical properties of the elements.",
   "@docType",     "data",
   "@keywords",    "datasets",
   "@usage",       "data(periodicdata)"
)


## header (@name, @title, @description, @docType, @keywords, @usage)
roxy_header <- sprintf("#' %s %s", tibble_head$labels, tibble_head$text)


## @format
tibble_format <- readme_tibble_wide
tibble_format <-
   tibble_format %>%
   # for properties without any description, use their title instead
   dplyr::mutate(description = ifelse(description == "", title, description)) %>%
   # remove newline char and limit length of description to something suitable
   dplyr::mutate(description = stringr::str_replace(description, "\n", " ")) %>%
   dplyr::mutate(description = trimws(description)) %>%
   dplyr::mutate(description = stringr::str_trunc(description, 50)) %>%
   # not strictly necessary to drop columns, just neater
   dplyr::select(-title, -starts_with("doi"), -starts_with("url")) %>%
   # add each columns type to a new column (char, double, etc.)
   left_join(
      periodicdata %>% lapply(typeof) %>% as_tibble() %>% pivot_longer(cols = everything(), names_to = "property", values_to = "typeof"),
      by = "property"
   )
roxy_format <- c(
   paste0("#' @format A tibble with ", dim(periodicdata)[1], " rows (the chemical elements) and ", dim(periodicdata)[2], " variables:"),
   "#' \\describe{",
   sprintf("#'   \\item{\\code{%s}}{%s %s}", tibble_format$property, tibble_format$typeof, tibble_format$description),
   "#' }"
)


## @source
# collect list of URLs and DOIs to create \sources{}
roxy_sources <- sprintf("#' @source \\url{%s}", readme_tibble_long %>% filter(grepl("^(doi|url)_", type)) %>% pull(text) %>% unname() %>% unique())


## closing
roxy_closing <- paste0('"', deparse(substitute(periodicdata)), '"')


# write to data.R
cat(
   roxy_header,
   roxy_format,
   roxy_sources,
   roxy_closing,
   sep = "\n",
   file = here("R/data.R"),
   append = FALSE
)

source(here::here("vignettes/code/build-metadata.R"), local = knitr::knit_global())
library(knitr)  # kable

knitr::kable(
   x = readme_tibble_wide %>%
      # for properties without any description, use their title instead
      dplyr::mutate(description = ifelse(description == "", title, description)) %>%
      dplyr::select(property, description, starts_with("doi_"), starts_with("url_")) %>%
      # remove newlines and limit length of description to something suitable
      dplyr::mutate(description = stringr::str_replace(description, "\n", " ")) %>%
      dplyr::mutate(description = stringr::str_trunc(description, 80)) %>%
      tidyr::unite("DOI", starts_with("doi_"), na.rm = TRUE, sep = ", ") %>%
      # ditto for URLs
      tidyr::unite("URL", starts_with("url_"), na.rm = TRUE, sep = ", "),
   col.names = c("Property", "Description (truncated)", "DOI", "URL"),
   # DOI and URL columns oppositely aligned just for visual separation's sake
   align = c("l", "l", "l", "r")
) %>% print()

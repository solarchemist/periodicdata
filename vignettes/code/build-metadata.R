library(here)   # here
library(yaml)   # yaml.load
library(dplyr)  # required everywhere
library(tibble) # tibble
library(tidyr)  # unnest_longer, pivot_wider

yaml_path <- here("inst/extdata/periodicdata.yml")

# get the references field from YAML
yq_query <- paste("yq '.[] |= pick([\"reference\"]) | ... comments=\"\"'", yaml_path)
readme_tibble_long <-
   system(yq_query, intern = TRUE) %>%
   yaml.load() %>%
   tibble::tibble(property = names(.), text = .) %>%
   unnest_longer(col = text, indices_to = "field") %>%
   unnest_longer(col = text) %>%
   unnest_longer(col = text, indices_to = "type") %>%
   # we can drop all rows with type == "citation", no need, doi is enough in readme table
   filter(type != "citation") %>%
   arrange(property, field, type) %>%
   # number "type" sequentially within each property for each type
   group_by(property, type) %>%
   # number "type" to make each url_*, doi_* uniquely labelled
   mutate(type = paste0(type, "_", row_number())) %>%
   # now we can ungroup to avoid unexpected side-effects later
   ungroup() %>%
   # to conform to the next dataframe, drop the column "field"
   select(-field)
# get the other metadata fields from YAML
yq_query <- paste(
   "yq '.[] |= pick([\"title\", \"title_symbol\", \"description\", \"unit\"]) | ... comments=\"\"'",
   yaml_path)
readme_tibble_long %<>%
   dplyr::bind_rows(
      system(yq_query, intern = TRUE) %>%
      yaml.load() %>%
      # names(.) gets the character vector of all property names
      tibble(property = names(.), text = .) %>%
      unnest_longer(col = text, indices_to = "type")
   ) %>%
   arrange(property, type)

# to aid converting this data frame to a HTML/Markdown table, let's widen it
# so we have only one property per row
readme_tibble_wide <-
   readme_tibble_long %>%
   tidyr::pivot_wider(names_from = type, values_from = text, values_fill = "") %>%
   # to make the subsequent conversion to character string easier I want to sort
   # the columns alphabetically except property, description, title, unit
   select(property, title, unit, title_symbol, description, sort(names(.)))
# not sure I can avoid an explicit loop here
# for all the columns that start with doi_ or url_, replace all strings
numbered_cols <- names(readme_tibble_wide)[grepl("^(doi|url)_", names(readme_tibble_wide))]
for (col in 1:length(numbered_cols)) {
   this_num <- unlist(strsplit(numbered_cols[col], "_"))[2]
   this_col <- readme_tibble_wide %>% pull(numbered_cols[col])
   readme_tibble_wide[, numbered_cols[col]] <-
      # replace empty strings with NA to make unite() work without leaving
      # ugly leading/trailing sep marks (in next chunk)
      ifelse(this_col == "", NA, paste0("[", this_num, "](", this_col, ")"))
}

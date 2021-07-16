#!/usr/bin/env Rscript
#
# Check Refinebio-Frontend urls and return anything missing that was expected or NULL

library(optparse)
library(jsonlite)

option_list <- list(
  make_option(
    opt_str = c("-l", "--links"), type = "character",
    default = NULL,
    help = "JSON array that will be interpreted as the expected urls.",
    metavar = ".json"
  )
)

# Parse options
opt <- parse_args(OptionParser(option_list = option_list))

expected_urls <- fromJSON(txt=opt$links)

# urls -> relatative file paths
expected_files <- stringr::word(expected_urls, 2, sep = '/refinebio-examples/')
expected_id_paths <- stringr::str_subset(expected_files, '#')
# remove anchors
expected_files <- unique(stringr::word(expected_files, 1, sep = '#'))

# get a list of all html files in the project
existing_files <- list.files(pattern = 'html$', recursive = TRUE)

# get anything thats not in the project
missing_files <- expected_files[!expected_files %in% existing_files]

# check for missing ids after we know the file isnt missing
# if a file and id is missing it will first complain that the file is missing
if (any(missing_files)) {
  expected_id_paths <- expected_id_paths[!grepl(paste(missing_files, collapse="|"), expected_id_paths)]
}
# find missing ids
missing_ids = c()

expected_id_parts_list <- strsplit(expected_id_paths, "#")
for (expected_id_parts in expected_id_parts_list) {
  expected_file <- expected_id_parts[1]
  expected_id <- expected_id_parts[2]
  expected_id_lines <- readr::read_lines(expected_file)

  # check if the id="{expected_id}" exists
  found <- any(stringr::str_detect(expected_id_lines, paste0('id="', expected_id, '"')))

  # add it to missing if not found
  if (!found) {
    missing_ids <- c(missing_ids, paste0(expected_id_parts, collapse = "#"))
  }
}


# group the missing things
missing <- c(missing_files, missing_ids)

# exit with the list or "OK" if nothing missing
if(length(missing) == 0) {
  cat('OK')
} else {
  cat(paste0(missing, collapse="\n"))
}

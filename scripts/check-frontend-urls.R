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
expected_files <- sapply(strsplit(expected_urls, '/refinebio-examples/'), '[', 2)

expected_id_paths <- expected_files[grepl('#', expected_files)]

# remove expected ids from expected_files
expected_files <- expected_files[!expected_files %in% expected_id_paths]
# add back the file part of expected_id_paths to test
expected_files <- c(expected_files, sapply(strsplit(expected_id_paths, "#"), "[", 1))

# get a list of all html files in the project
existing_files <- list.files(pattern = 'html$', recursive = TRUE)

# get anything thats not in the project
missing_files <- expected_files[!expected_files %in% existing_files]

# check for missing ids after we know the file isnt missing
# if a file and id is missing it will first complain that the file is missing
expected_id_paths <- expected_id_paths[!grepl(paste(missing_files, collapse="|"), expected_id_paths)]
# find missing ids
missing_ids = c()

for (expected_id_path in expected_id_paths) {
  expected_id_parts <- strsplit(expected_id_path, "#")
  expected_file <- expected_id_parts[[1]][1]
  expected_id <- expected_id_parts[[1]][2]
  expected_id_lines <- readr::read_lines(expected_file)

  # check if the id="{expected_id}" exists
  found_index <- which(grepl(paste0("id=\"", expected_id, "\""), expected_id_lines))

  # add it to missing if not found
  if (identical(found_index, integer(0))) {
    missing_ids <- append(missing_ids, expected_id_path)
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

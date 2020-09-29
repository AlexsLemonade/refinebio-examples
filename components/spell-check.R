#!/usr/bin/env Rscript
#
# Run spell check and save results

library(magrittr)

# Read in dictionary
dictionary <- readLines(file.path('components', 'dictionary.txt'))

# Only declare Rmd files
files <- list.files(pattern = 'Rmd$', recursive = TRUE, full.names = TRUE)

# Run spell check
sp_errors <- spelling::spell_check_files(files, ignore = dictionary) %>% 
  data.frame() %>%
  tidyr::unnest(cols = found)

# Print out how many spell check errors
print(nrow(sp_errors))

# Save spell errors to file temporarily
readr::write_tsv(sp_errors, file.path('components', 'spell_check_results.tsv'))

#!/usr/bin/env Rscript
#
# Make rendered versions of .Rmd files with automagic citations with a specified
# .bib file.

# Example use:

# Rscript scripts/render-notesbooks.R \
# -r 01-getting-started/getting-started.Rmd
# -b references.bib

# Load library:
library(optparse)

# Set up optparse options
option_list <- list(
  make_option(
    opt_str = c("-r", "--rmd"), type = "character",
    default = NULL,
    help = "File path to an .Rmd file that should have the bib_file added",
    metavar = "character"
  ),
  make_option(
    opt_str = c("-b", "--bib_file"), type = "character",
    default = "references.bib", # Default is this file, but it can be changed
    help = "File name of the references file. Can be any format pandoc works with. Will be normalized with normalizePath().",
    metavar = "character"
  )
)

# Parse options
opt <- parse_args(OptionParser(option_list = option_list))

# Make these file paths
opt$bib_file <- file.path(opt$bib_file)
opt$rmd <- file.path(opt$rmd)

# Check that the file exists
if (!file.exists(opt$rmd)) {
  stop("Rmd file specified with --rmd is not found.")
}

# Check that the file exists
if (!file.exists(opt$bib_file)) {
  stop("File specified for --bib_file option is not at the specified file path.")
} else {
  bib_specify_line <- paste("bibliography:", normalized_bib_file)
}

# Specify the output file
outfile <-  stringr::str_replace(infile, ".Rmd", "tmp-header-changed.Rmd")

# Read in as lines
lines <- readr::read_lines(infile)

# Find which lines are the beginning and end of the header chunk
header_range <- which(lines == "---")

# Add the bibliography specification line at the beginning of the chunk
new_lines <- append(lines, header_line, header_range[1])

# Write to an outfile
readr::write_lines(new_lines, outfile)

# Render the header added notebook
rmarkdown::render(outfile,
  output_format = rmarkdown::html_document(),
  # Save to original html output file name
  output_file = stringr::str_replace(infile, ".Rmd", ".nb.html")
)

# Remove the temporary header change .Rmd output file
file.remove(outfile)

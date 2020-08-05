#!/usr/bin/env Rscript
#
# Make rendered versions of .Rmd files with automagic citations with a specified
# .bib file.

# Find the project root
root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))

# List of files to render
infiles <- c(
  file.path(root_dir, "01-getting-started", "getting-started.Rmd"),
  file.path(
    root_dir, "02-microarray",
    file.path("clustering", "clustering_example.Rmd")
  )
)

# Load library:
library(optparse)

# Set up optparse options
option_list <- list(
  make_option(
    opt_str = c("-b", "--bib_file"), type = "character",
    default = "references.bib", # Default is this file, but it can be changed
    help = "File path relative to root directory (where .git is) 
    and file name of the references file. Can be any format pandoc works with",
    metavar = "character"
  )
)

# Parse options
opt <- parse_args(OptionParser(option_list = option_list))

# Make it normalized to root_dir
normalized_bib_file <- file.path(root_dir, opt$bib_file)

# Check that the file exists in the root directory
if (!file.exists(normalized_bib_file)) {
  message(normalized_bib_file)
  stop("File specified for --bib_file option is not at the specified file path.")
} else {
  bib_specify_line <- paste("bibliography:", normalized_bib_file)
}

# Make specialized function for adding a header specification
add_header_line <- function(infile,
                            header_line = bib_specify_line,
                            outfile = file.path(dirname(infile), "tmp-header-changed.Rmd")) {

  # Read in as lines
  lines <- readr::read_lines(infile)

  # Find which lines are the beginning and end of the header chunk
  header_range <- which(stringr::str_detect(lines, "---"))

  # Add the bibliography specification line at the beginning of the chunk
  new_lines <- append(lines, bib_specify_line, header_range[1])

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
}

# Render all the notebooks but with added header line
purrr::map(infiles, add_header_line)

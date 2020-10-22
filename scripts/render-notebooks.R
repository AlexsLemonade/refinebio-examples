#!/usr/bin/env Rscript
#
# Make rendered versions of .Rmd files with automagic citations with a specified
# .bib file.

# Example use:

# Rscript scripts/render-notebooks.R \
# -r 01-getting-started/getting-started.Rmd \
# -b references.bib \
# --style

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
    opt_str = c("-b", "--bib_file"),
    type = "character",
    default = "references.bib", # Default is this file, but it can be changed
    help = "File name of the references file. Can be any format pandoc works with. Will be normalized with normalizePath().",
    metavar = "character"
  ),
  make_option(
    opt_str = c("--cite_style"),
    type = "character",
    default = NULL,
    help = "File name of the citation style file, csl format. Will be normalized with normalizePath().",
    metavar = "character"
  ),
  make_option(
    opt_str = c("-o", "--html"), type = "character",
    default = NULL,
    help = "Desired filename for rendered output html file",
    metavar = "character"
  ),
  make_option(
    opt_str = c("-s", "--style"), action = "store_true",
    default = FALSE,
    help = "Style input file before processing"
  )
)

# Parse options
opt <- parse_args(OptionParser(option_list = option_list))

# Get working directory
base_dir <- getwd()

# Normalize file path
opt$bib_file <- normalizePath(opt$bib_file)

# Check that the rmd file exists
if (!file.exists(opt$rmd)) {
  stop("Rmd file specified with --rmd is not found.")
}

# Check that the bib file exists
if (!file.exists(opt$bib_file)) {
  stop("File specified for --bib_file option is not at the specified file path.")
} else {
  header_line <- paste("bibliography:", opt$bib_file)
}
# Check for a citation style
if (!is.null(opt$cite_style)){
  if (!file.exists(opt$cite_style)) {
    stop("File specified for --cite_style option is not at the specified file path.")
  } else {
    header_line <- paste0(header_line, "\n", "csl: ", normalizePath(opt$cite_style))
  }
}

# If no output html filename specification, make one from the original filename
if (is.null(opt$html)) {
  output_file <- stringr::str_replace(normalizePath(opt$rmd), "\\.Rmd$", ".html")
} else {
  # Render is weird about relative file paths, so we have to do this
  output_file <- file.path(base_dir, opt$html)
}

# Run styler if option is used
if (opt$style) {
  styler::style_file(opt$rmd)
}

# Specify the temp file
tmp_file <- stringr::str_replace(opt$rmd, "\\.Rmd$", "-tmp-header-changed.Rmd")

# Read in as lines
lines <- readr::read_lines(opt$rmd)

# Find which lines are the beginning and end of the header chunk
header_range <- which(lines == "---")

# Stop if no chunk found
if (length(header_range) == 0) {
  stop("Not finding the `---` which is at the beginning of the header.")
}

# Add the bibliography specification line at the beginning of the chunk
new_lines <- append(lines, header_line, header_range[1])

# Write to an tmp file
readr::write_lines(new_lines, tmp_file)

# Declare path to google analytics bit
google_analytics_file <- normalizePath(file.path("components", "google-analytics.html"))

# Render the header added notebook
rmarkdown::render(tmp_file,
  output_format = rmarkdown::html_document(
    toc = TRUE, toc_depth = 2,
    toc_float = TRUE, number_sections = TRUE,
    highlight = "haddock",
    df_print = "paged",
    css = normalizePath(file.path("components", "styles.css")),
    includes = rmarkdown::includes(in_header = google_analytics_file, 
                                   after_body = file.path("..", "components", "footer.html"))
  ),
  # Save to original html output file name
  output_file = output_file
)

# Remove the temporary header change .Rmd tmp file
file.remove(tmp_file)

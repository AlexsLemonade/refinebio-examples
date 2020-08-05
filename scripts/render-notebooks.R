#!/usr/bin/env Rscript
#
# Make citation rendered versions of .Rmd files in training modules
#
# If --skiprendering option is used, the rendering is skipped.

# Load library:
library(optparse)

# Set up optparse options
option_list <- list(
  make_option(
    opt_str = c("-b", "--bib_file"), type = "character",
    default = NULL, help = "File path and file name of the references file. Can be 
    any format pandoc works with",
    metavar = "character"
  )
)

# Parse options
opt <- parse_args(OptionParser(option_list = option_list))
opt$bib_file <- "../../references.bib"

if (!file.exists(opt$bib_file)){
  stop("File specified for --bib_file option is not at the specified file path.")
} else { 
  bib_specify_line <- paste("bibliography:", opt$bib_file)
}

add_header_line <- function (infile, 
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
                    output_file = stringr::str_replace(infile, ".Rmd", ".nb.html"))
  
  # Remove the temporary header change .Rmd output file
  file.remove(outfile)
}

add_header_line(infile)

# find the project root
root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))

# list of files to transform
infiles <- c(file.path(root_dir, "01-getting-started", "getting-started.Rmd"),
             file.path(root_dir, "02-microarray", c("clustering", "clustering_example.Rmd"))
             )

# Rerender notebooks if --skiprendering is FALSE
if (!opt$skiprendering) {
  purrr::map(infiles, rmarkdown::render, envir = new.env(), quiet = TRUE)
}

out_form <- rmarkdown::html_document()
rmarkdown::render(file, output_format = out_form)

# Generate live versions
# capture to avoid printing to stdout
out <- purrr::map2(infiles, outfiles, 
                   exrcise::exrcise)

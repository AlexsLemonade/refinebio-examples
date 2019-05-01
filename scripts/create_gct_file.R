# C. Savonen 2018
#
# Purpose: Convert a gene expression tab separated values (tsv) file provided
# into a gene cluster text (gct) file for use in GenePattern notebooks.
#
# Options:
# "-f" name of the file in your current directory that you would like to convert.
# "-r" file of the same name as the output will be rewritten
# "-o" name for the output file (optional)

# Example of usage in command line:
# $ Rscript create_gct_file.R -f GSE111111.tsv -o outputfilename -r

# This script requires optparse library. If optparse library is not installed,
# this script will install it for you.

if (!("optparse" %in% installed.packages())) {
  message("Installing optparse library...")
  install.packages("optparse", repos='http://cran.us.r-project.org')
}

# Require optparse
require(optparse)

option_list <- list(
  make_option(opt_str = c("-f", "--file"), type = "character", default = NULL,
              help = "Name of tsv file to be converted to gct",
              metavar = "character"),
  make_option(c("-r", "--rewrite"), action ="store_true", default = FALSE,
              help="Rewrite gct file"),
  make_option(opt_str = c("-o", "--output"), type = "character", default = NULL,
              help = "Name for output gct file", metavar = "character")
)

# Get command line options, if help option encountered print help and exit,
# otherwise if options not found on command line then set defaults,
opt <- parse_args(OptionParser(option_list=option_list))

# Only continue with execution if filename is given
if (is.null(opt$file)) {
  stop("Input file name needed.
  Use '-f' followed by the name of the file you wish to convert", call. = FALSE)
}
# If no output file name is specified, use input filename
if (is.null(opt$output)) {
  opt$output <- gsub("\\.tsv$", ".gct", opt$file)
}
# Check if file is a tsv file
if(grepl("\\.tsv$", opt$file) == FALSE) {
    stop("Only tsv files can be used as input files", call. = FALSE)
}

# Assign output file name, and if it doesn't include a ".gct" suffix, then add
# a ".gct" suffix.
opt$output <- ifelse(grepl("\\.gct$", opt$output), opt$output,
                      paste0(opt$output, ".gct"))

# Read in the file
df <- read.delim(opt$file, stringsAsFactors = FALSE)

# Format columns to gct column names. Create a "Description" dummy variable
# column.
df <- data.frame("Name" = df[ ,1], "Description" = rep(NA, nrow(df)),
                 df[ ,2:ncol(df)])

# Get the number of genes and samples.
num.samples <- ncol(df) - 2
num.genes <- nrow(df)

# Make .gct specific Header with the number of genes and samples in the second
# line.
header <- c("#1.2", paste0(c(num.genes, num.samples), collapse = "\t"))

  # Produce error if output file already exists.
if (file.exists(opt$output)) {
  if(opt$rewrite){
    warning(paste0("Overwriting file named '", opt$output, "'"))
  } else {
    stop(paste(opt$output, "already exists.
        Use '--rewrite' option if you want this file to be overwritten."))
  }
}
# Write the header and then append the data to the header
write(header, file = opt$output)

# write.table will throw a warning that we are appending column names to the file,
# but that's what we want to do since we need that header at the top for GenePattern
# to recognize it so we suppress that warning
suppressWarnings(write.table(df, row.names = FALSE, opt$output, append = TRUE,
                             quote = FALSE, sep="\t"))


# Print out message so the user knows the file is made
message(paste("Your .gct file has been made and is called:", opt$output))

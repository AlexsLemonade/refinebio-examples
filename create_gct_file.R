# C. Savonen 2018

# Purpose: Convert a gene expression tab separated values (tsv) file provided into a gene cluster text (gct) file for use in GenePattern notebooks.
# How to use: In command line, reference the create_gct_file.R script, followed by the name of the file in your current directory that you would like to convert.
# Optionally you can designate the name of the output file by adding an argument following the name of the input file.

# Example of usage in command line:
# $ Rscript create_gct_file.R GSE111111.tsv outputname

args <- commandArgs(trailingOnly=TRUE)

# Only continue with execution if filename is given
if (length(args) == 0) {
  stop("Input file name needed", call. = FALSE)
} else if (length(args) == 1) {
  # If no output file name is specified, use input filename
  args[2] <- gsub("\\.tsv$", ".gct", args[1])
}

# Check if file is a tsv file
if(grepl("\\.tsv$", args[1]) == FALSE){
    stop("Only tsv files can be used as input files", call. = FALSE)
}

# Assign input file name
file.name <- args[1]

# Assign output file name, and if it doesn't include a ".gct" suffix, then add a ".gct" suffix.
output.file <- ifelse(grepl("\\.gct$", args[2]), args[2], paste0(args[2], ".gct"))

# Read in the file
df <- read.table(file.name, stringsAsFactors = FALSE)

# Format columns to gct column names. Create a "Description" dummy variable column.
df <- data.frame("Name" = rownames(df), "Description" = rep(NA, nrow(df)), df)

# Get the number of genes and samples.
num.samples <- ncol(df) - 2
num.genes <- nrow(df)

# Make .gct specific Header with the number of genes and samples in the second line. 
header <- c("#1.2", paste0(c(num.genes, num.samples), collapse = "\t"))

# Produce error if output file already exists. 
if (file.exists(output.file)) {
    stop(paste(output.file, "already exists"))
}
# Write the header and then append the data to the header
write(header, file = output.file)

suppressWarnings(write.table(df, row.names = FALSE, output.file, append = TRUE, quote = FALSE, sep="\t"))

# It will warn us that we are appending column names to the file, but that's what we want to do since we need that header at the top for GenePattern to recognize it.


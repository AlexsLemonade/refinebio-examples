# C. Savonen 2018 

# Objective: Convert a "Tab Separated Values" file into a "Gene Cluster Text" file, for use in GenePattern Notebooks.

# Read in whatever tsv file is in the directory
file.name <- grep(".tsv", dir(), value=TRUE)

# Read in the file
df <- read.table(file.name, stringsAsFactors = FALSE)

# Format columns to GCT column names. Create a "Description" dummy variable column.
df <- data.frame("Name" = rownames(df), "Description" = rep(NA, nrow(dat)), dat)

# Get rid of ".CEL" prefix if it exists.
colnames(df) <- gsub("\\.CEL", "" , colnames(df))

# Get rid of old ".tsv" suffix and replace with "gct"
file.name <- gsub("tsv", "gct", file.name)

# Get the number of genes and samples.
num.samples <- ncol(df) - 2
num.genes <- nrow(df)

# Make .gct specific Header with the number of genes and samples in the second line. 
header <- c("#1.2", paste0( c(num.genes, num.samples), collapse="\t"))

# Write the header and then append the data to the header
write(header, file = file.name)
write.table(df, row.names = FALSE, file.name,append = TRUE, quote = FALSE, sep="\t")

# It will warn us that we are appending column names to the file, but that's what we want to do since we need that header at the top for GenePattern to recognize it. 

sessionInfo()




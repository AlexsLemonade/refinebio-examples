# CCDL 2018
# Extract gene expression matrix and sample title from the series matrix from
# GEO

series.matrix.file <- file.path("data", "GSE39842_series_matrix.txt")

# read in expression matrix
exprs.data <- readr::read_delim(series.matrix.file, 
                                delim = "\t", 
                                comment = "!",
                                col_names = TRUE, 
                                skip = 1)

# get sample title from line 29 of the series matrix
conn <- file(series.matrix.file)
open(conn)
sample.title <- as.vector(as.matrix(read.table(conn, skip = 28, nrow = 1)))
close(conn)

# set the column names as the titles and write to file
colnames(exprs.data)[2:ncol(exprs.data)] <- sample.title[2:length(sample.title)]
output.file <- file.path("data", "GSE39842_RMA.tsv")
readr::write_tsv(exprs.data, output.file)

# modified from
# https://github.com/AlexsLemonade/refinebio/commit/df52ca5c722e5256eab29054bf8c7c7945da4001

###
# gene_convert.R
# Alex's Lemonad Stand Foundation
# Childhood Cancer Data Lab
#
###

# import magrittr pipe
`%>%` <- dplyr::`%>%`

#######################
# The command interface!
#######################

library("optparse")
library(data.table)
library("dplyr")
library("rlang")

option_list = list(
  make_option(c("-g", "--geneIndexPath"), type="character", default="",
              help="Gene Index File", metavar="character"),
  make_option(c("-i", "--inputFile"), type="character", default="",
              help="inputFile", metavar="character"),
  make_option(c("-o", "--outputFile"), type="character", default="",
              help="outputFile", metavar="character")
);

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

geneIndexPath <- opt$geneIndexPath
filePath <- opt$inputFile
outFilePath <- opt$outputFile

# Get and use this DB
message("Loading...")
source("http://bioconductor.org/biocLite.R")

# Read the data file
message("Reading data file...")
suppressWarnings(data <- fread(filePath,
					stringsAsFactors=FALSE,
					sep="\t", header=TRUE,
					autostart=10,
					data.table=FALSE,
					check.names=FALSE,
					fill=TRUE,
					na.strings="",
					showProgress=FALSE)
				)

# Read the data file
message("Reading master index...")
index_path <- paste('zcat', geneIndexPath)
suppressWarnings(index_data <- fread(index_path,
					stringsAsFactors=FALSE,
					sep="\t",
					header=TRUE,
					autostart=10,
					data.table=FALSE,
					check.names=FALSE,
					fill=TRUE,
					na.strings="",
					showProgress=FALSE)
				)

# find % overlap by column
overlap <- apply(index_data, 2, function(x) length(intersect(data$ID_REF, x)) / length(data$ID_REF))

# threshold here can be adjusted
if (any(overlap >= 0.5)) {
	# take column name with highest overlap value
  	# overlap is a named numeric vector
  	detected_id <- names(which.max(overlap))
} else {
	# Less than 50%? Get outta here!
  	stop(paste("Not enough overlapping ids detected! Max of ", which.max(overlap), names(which.max(overlap))))
}

message("Merging..")
colnames(data)[1] <- detected_id

converted_exprs <- index_data %>%
  dplyr::select(c("ENSEMBL", detected_id)) %>%
  dplyr::distinct() %>%
  dplyr::inner_join(data, by = detected_id)

converted_exprs <- converted_exprs %>%
  dplyr::select(-rlang::UQ(rlang::sym(detected_id)))

message(head(converted_exprs))

# Typically we don't do any kind of summarization of duplicates at this point
# in the refine.bio data pipeline, but it makes sense in the context of this
# example!
converted_exprs <- converted_exprs %>%
  dplyr::group_by(ENSEMBL) %>%
  dplyr::summarise_all(mean)

# Save to output file
write.table(converted_exprs, outFilePath, row.names=FALSE, col.names=TRUE, quote=FALSE, sep="\t")
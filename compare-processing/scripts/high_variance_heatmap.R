# ALSF CCDL 2018
# Takes a gene expression matrix (TSV) for GSE39842 and makes a heatmap (PNG) 
# of high variance genes (top 10%). Also outputs a TSV that contains information
# about the genotype and amputation time point for downstream use in 
# differential expression analysis and the list of the high variance genes.
# 
# Command line usage:
#   Rscript scripts/high_variance_heatmap.R \
#     -i <GENE_EXPRESSION_TSV> \
#     -g <HIGH_VARIANCE_GENE_IDS_TSV> \
#     -p <HEATMAP_PNG> \
#     -a <ANNOTATION_DF_TSV>

# magrittr pipe 
`%>%` <- dplyr::`%>%`

#### command line arguments ----------------------------------------------------

library("optparse")

option.list = list(
  make_option(c("-i", "--input"), type = "character", default = "",
              help = "Input gene expression matrix (TSV)", 
              metavar = "character"),
  make_option(c("-p", "--plot"), type = "character", default = "",
              help = "Heatmap output file name, including path information", 
              metavar = "character"),
  make_option(c("-g", "--geneids"), type = "character", default = "",
              help = "Gene identifier output file name, 
                      including path information", 
              metavar = "character"),
  make_option(c("-a", "--annotation"), type = "character", default = "",
              help = "Output file name for annotation data.frame, 
                      including path information", 
              metavar = "character")
)

opt.parser <- OptionParser(option_list = option.list)
opt <- parse_args(opt.parser)

input.file <- opt$input
heatmap.output <- opt$plot
geneids.output <- opt$geneids
annot.output <- opt$annotation

#### read in and prep data -----------------------------------------------------

# read in expression data.frame
exprs.df <- readr::read_tsv(input.file)

# identify high variance genes - top 10%
row.variance <- matrixStats::rowVars(as.matrix(exprs.df[, 2:ncol(exprs.df)]))
high.var.rows <- which(row.variance > quantile(row.variance, 0.9))

# subset the expression data.frame to just the high variance genes
high.var.exprs.df <- exprs.df[high.var.rows, ]

# write the high variance gene identifiers to file
readr::write_tsv(high.var.exprs.df[, 1], geneids.output)

#### heatmap -------------------------------------------------------------------

# matrix, no gene identifiers
high.var.mat <- as.matrix(high.var.exprs.df[, -1])

# make a data.frame for the column annotation of the heatmap
hif1a.vector <- rep("wildtype", ncol(high.var.mat))
hif1a.vector[grep("dnHIF1a", colnames(high.var.mat))] <- "dnHIF1a-expressing"
amp.vector <- rep("post-amputation", ncol(high.var.mat))
amp.vector[grep("Unamputated", colnames(high.var.mat))] <- "unamputated"
annot.df <- data.frame(dnHIF1a = hif1a.vector, amputated = amp.vector)
readr::write_tsv(annot.df %>%
                   dplyr::mutate(sample_name = colnames(high.var.mat)) %>%
                   dplyr::select(sample_name, dplyr::everything()), 
                   annot.output)

# make into heatmap annotation, with the addition of color choices
column.annotation <- ComplexHeatmap::HeatmapAnnotation(
  df = annot.df,
  col = list(dnHIF1a = c("dnHIF1a-expressing" = "#00BFFF", 
                         "wildtype" = "#FFD700"),
             amputated = c("unamputated" = "#FF7F00",
                           "post-amputation" = "#4EEE94"))
)

png(heatmap.output, width = 7, height = 7, units = "in", res = 300)
ComplexHeatmap::Heatmap(high.var.mat, 
                        column_names_gp = grid::gpar(fontsize = 5), 
                        top_annotation = column.annotation,
                        name = "expression")
dev.off()

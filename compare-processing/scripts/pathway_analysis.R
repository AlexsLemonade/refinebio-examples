# ALSF CCDL 2018
# Over representation analysis on differentially expressed genes with 
# WebGestaltR
#
# Command line usage:
#   Rscript scripts/pathway_analysis.R \
#     -d <LIMMA_RESULTS_TABLE_TSV> \
#     -o <PATHWAY_RESULTS_DIRECTORY> \
#     -p <PROJECT_NAME>

`%>%` <- dplyr::`%>%`

#### command line arguments ----------------------------------------------------

library("optparse")

option.list = list(
  make_option(c("-d", "--diffexp"), type = "character", default = "",
              help = "Input differential expression results table (TSV)", 
              metavar = "character"),
  make_option(c("-o", "--outputdir"), type = "character", default = "",
              help = "Output directory for pathway results", 
              metavar = "character"),
  make_option(c("-p", "--project"), type = "character", default = "",
              help = "Project name for WebGestaltR",
              metavar = "character")
)

opt.parser <- OptionParser(option_list = option.list)
opt <- parse_args(opt.parser)

diffexp.file <- opt$diffexp
output.dir <- opt$outputdir
project.name <- opt$project

#### main ----------------------------------------------------------------------

# read in results table from limma
results.table <- read.delim(diffexp.file)
# all genes that were measured are the reference genes
reference.genes <- rownames(results.table)

# genes that respond to amputation in wildtype, don't respond in TG, and are not
# different between genotypes pre-amputation
interest.df <- results.table %>%
  tibble::rownames_to_column("Gene") %>%
  dplyr::filter(PostvsPreinWT != 0,
                PostvsPreinTG == 0,
                TGvsWTPre == 0)
interest.genes <- interest.df$Gene

# if the output directory doesn't exist, create it
if (!dir.exists(output.dir)) {
  dir.create(output.dir, recursive = TRUE)
}

# do the thing!
WebGestaltR::WebGestaltR(enrichMethod = "ORA",
                         organism = "drerio",
                         enrichDatabase = "geneontology_Biological_Process",
                         interestGene = interest.genes,
                         interestGeneType = "ensembl_gene_id",
                         referenceGene = reference.genes,
                         referenceGeneType = "ensembl_gene_id",
                         outputDirectory = output.dir,
                         projectName = project.name)

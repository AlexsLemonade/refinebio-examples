# ALSF CCDL 2018
# Takes a GSE39842 gene expression matrix and the annotation data.frame from 
# high_variance_heatmap.R and identifies
#  * which genes respond to amputation in wildtype
#  * which genes respond to amputation in transgenic (dnHIF1a-expressing)
#  * which genes respond differently in transgenics compared to wildtype
#  * which genes are different between wildtype and transgenics pre-amputation
#
# Command line usage:
#   Rscript scripts/differential_expression.R \
#      -e <GENE_EXPRESSION_TSV> \
#      -a <ANNOTATION_DF_TSV> \
#      -p <VENN_DIAGRAM_PNG> \
#      -r <LIMMA_RESULTS_TABLE_TSV> \
#      -t <LIMMA_TOPTABLE_TSV>

# magrittr pipe
`%>%` <- dplyr::`%>%`

#### command line arguments ----------------------------------------------------

library("optparse")

option.list = list(
  make_option(c("-e", "--expression"), type = "character", default = "",
              help = "Input gene expression matrix (TSV)", 
              metavar = "character"),
  make_option(c("-a", "--annotation"), type = "character", default = "",
              help = "Input annotation (TSV)", metavar = "character"),
  make_option(c("-p", "--plot"), type = "character", default = "",
              help = "Venn diagram output file name, 
              including path information", 
              metavar = "character"),
  make_option(c("-r", "--results"), type = "character", default = "",
              help = "Results table output file name, 
              including path information", 
              metavar = "character"),
  make_option(c("-t", "--toptable"), type = "character", default = "",
              help = "Top table output file name, 
              including path information", 
              metavar = "character")
)

opt.parser <- OptionParser(option_list = option.list)
opt <- parse_args(opt.parser)

exprs.file <- opt$expression
annot.file <- opt$annotation
venn.output <- opt$plot
results.output <- opt$results
toptable.output <- opt$toptable

#### read in data --------------------------------------------------------------

# gene expression matrix
exprs.mat <- as.matrix(read.delim(exprs.file, row.names = 1, header = 1))

# file generated during heatmap plotting
annot.df <- readr::read_tsv(annot.file)
# we'll want to remove the "-" character as it will cause problems downstream
annot.df <- annot.df %>% 
              dplyr::mutate(dnHIF1a = stringr::word(dnHIF1a, 1, sep = "-"), 
                            amputated = stringr::word(amputated, 1, sep = "-"))

#### differential expression analysis ------------------------------------------

# following the 9.5 Interaction Models: 2 × 2 Factorial Designs section of the
# limma user guide

# vector that contains info about the amputation and transgenic status of
# each sample, this is consistent with the limma documentation
amp.tg <- paste(annot.df$dnHIF1a, annot.df$amputated, sep = ".")
amp.tg <- factor(amp.tg, levels = c("wildtype.unamputated",
                                    "wildtype.post",
                                    "dnHIF1a.unamputated",
                                    "dnHIF1a.post"))
# design matrices and initial fit
design <- model.matrix(~ 0 + amp.tg)
colnames(design) <- levels(amp.tg)
fit <- limma::lmFit(exprs.mat, design)

# this contrast matrix is designed to answer the questions:
#  * which genes respond to amputation in wildtype
#  * which genes respond to amputation in transgenic (dnHIF1a-expressing)
#  * which genes respond _differently_ in transgenics compared to wildtype
#  * which genes are different between wildtype and transgenics pre-amputation
cont.matrix <- limma::makeContrasts(
    PostvsPreinWT = wildtype.post-wildtype.unamputated,
    PostvsPreinTG = dnHIF1a.post-dnHIF1a.unamputated,
    Diff = (dnHIF1a.post-dnHIF1a.unamputated)-(wildtype.post-wildtype.unamputated),
    TGvsWTPre = dnHIF1a.unamputated-wildtype.unamputated,
    levels = design
  )

# results of the limma pipeline
fit2 <- limma::contrasts.fit(fit, cont.matrix)
fit2 <- limma::eBayes(fit2)

# make a Venn diagram of differentially expressed genes
results <- limma::decideTests(fit2)
png(venn.output, width = 7, height = 7, units = "in", res = 300)
limma::vennDiagram(results, cex = c(1, 1, 1),
                   circle.col = c("#000000", "#FFC125", "#00BFFF", "#43CD80"))
dev.off()

# write top and results tables to file
limma::topTable(fit2, number = nrow(exprs.mat)) %>%
  tibble::rownames_to_column("Gene") %>% 
  readr::write_tsv(toptable.output)
write.table(results@.Data, results.output, quote = FALSE, sep = "\t")

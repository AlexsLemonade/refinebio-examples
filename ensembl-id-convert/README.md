# <u>refine.bio Examples: Ensemble ID conversion </u>
This directory contains example workflows of how to convert from Ensembl gene IDs,
which is the gene identifier used by refine.bio, to other types of gene identifiers that
may be required for downstream analyses.
IDs downloaded from <a href="refine.bio.org">refine.bio</a>.

### Annotation using Ensembl IDs in R
This <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl-id-convert/ensembl_id_convert.Rmd">
notebook </a> illustrates how to obtain annotation for data based on their Ensembl
IDs using `AnnotationDb` objects from [Bioconductor annotation packages](https://www.bioconductor.org/packages/release/BiocViews.html#___AnnotationData)
The script also explains how it can be changed for use with different species
and/or different types of annotation.

*Input:* GSE111111.tsv  
*Output:* GSE111111wGeneSymbols.tsv  

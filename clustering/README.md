# <u>refine.bio Examples: Clustering </u>
This directory contains example workflows of how to filter, cluster and create
a heatmap from data downloaded from <a href="refine.bio.org"> refine.bio </a>

***
### Clustering data in R
This <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering/clustering_example.Rmd">
notebook </a> uses the Bioconductor R package `ComplexHeatmap` for clustering and
creating a heatmap.
In this example, the gene expression matrix is subset to only include genes with high variance.
The high variances set of genes is then used to create a heatmap.
This script could be easily manipulated to sort by another summary statistic to
create a heatmap.  

*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* HeatmapGSE111111.png  

***
### Clustering data in GenePattern

For a general introduction in how to use the notebooks found on GenePattern,
go <a href="http://genepattern-notebook.org/public-notebooks/">here</a>.
In order to perform cluster analysis on your gene expression data, you must
first convert your data to gct format and can do so using our ready-made <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/create_gct_file.R">
script</a> and the instructions below.

Then you can use one of <b>GenePattern's example clustering notebooks</b>:

  * [Hierarchical Clustering with microarray data](https://notebook.genepattern.org/services/sharing/notebooks/23/preview/)
  * [Hierarchical Clustering with RNA-seq data](https://notebook.genepattern.org/services/sharing/notebooks/24/preview/)
  * [k-Means Clustering Notebook](https://notebook.genepattern.org/services/sharing/notebooks/25/preview/)
  * [Negative Matrix Factorization Clustering Notebook](https://notebook.genepattern.org/services/sharing/notebooks/26/preview/)   

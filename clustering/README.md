# <u>Clustering: Refinebio Examples: </u>
This repository contains example workflows of how to filter, cluster and create
a heatmap from data downloaded from <a href="refine.bio.org"> refine.bio </a>

## Clustering data in R
<a name="cluster"></a>
This <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering_example.html">
script </a> uses the Bioconductor R package `ComplexHeatmap` for clustering and
creating a heatmap.
This example also creates a subsetted dataset based on the variance calculated
for each gene/row.
The high variances set of genes is then used to create a heatmap.
This script could be easily manipulated to sort by another summary statistic to
create a heatmap.  

*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* HeatmapGSE111111.png  

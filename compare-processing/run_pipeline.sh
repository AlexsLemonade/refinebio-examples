#!/bin/bash

# download the identifier refinery mappings and the RMA processed data from GEO
bash 0-data_download.sh

# reformat the GEO series matrix to be more consistent with refine.bio output
Rscript 1-prep_series_matrix.R

# convert from probe ids to ENSDARG
Rscript scripts/gene_convert.R -g data/id_refinery/zebrafish.tsv.gz \
  -i data/GSE39842_RMA.tsv -o data/GSE39842_RMA_converted.tsv

# create directories to hold the results and plots 
mkdir results
mkdir plots

# high variance list of genes and heatmaps
bash 2-high_variance_genes.sh

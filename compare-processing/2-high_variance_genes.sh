#!/bin/bash

# RMA processed data that was obtained from GEO 
Rscript scripts/high_variance_heatmap.R \
  -i data/GSE39842_RMA_converted.tsv \
  -g results/RMA_GSE39842_high_variance_geneids.tsv \
  -p plots/RMA_GSE39842_high_variance_heatmap.png \
  -a results/RMA_GSE39842_annotation_df.tsv

# SCANfast processed data from staging.refine.bio -- this data has not been 
# quantile normalized
Rscript scripts/high_variance_heatmap.R \
  -i data/e3b5d201-449b-4512-8fe4-1c997c12e676/E-GEOD-39842.tsv \
  -g results/SCANfast_GSE39842_high_variance_geneids.tsv \
  -p plots/SCANfast_GSE39842_high_variance_heatmap.png \
  -a results/SCANfast_GSE39842_annotation_df.tsv

# SCAN processed, quantile normalized
Rscript scripts/high_variance_heatmap.R \
  -i  \
  -g results/QN_GSE39842_high_variance_geneids.tsv \
  -p plots/QN_GSE39842_high_variance_heatmap.png \
  -a results/QN_GSE39842_annotation_df.tsv

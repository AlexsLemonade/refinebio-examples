#!/bin/bash

# RMA processed data from GEO
Rscript scripts/differential_expression.R \
 -e data/GSE39842_RMA_converted.tsv \
 -a results/RMA_GSE39842_annotation_df.tsv \
 -p plots/RMA_GSE39842_limma_venn.png \
 -r results/RMA_GSE39842_results_table.tsv \
 -t results/RMA_GSE39842_top_table.tsv

# SCAN processed data from staging
Rscript scripts/differential_expression.R \
 -e data/e3b5d201-449b-4512-8fe4-1c997c12e676/E-GEOD-39842.tsv \
 -a results/SCANfast_GSE39842_annotation_df.tsv \
 -p plots/SCANfast_GSE39842_limma_venn.png \
 -r results/SCANfast_GSE39842_results_table.tsv \
 -t results/SCANfast_GSE39842_top_table.tsv

# SCAN processed, quantile normalized data from dev
# SCAN processed data from staging
Rscript scripts/differential_expression.R \
 -e data/95613466-25bf-4f3d-b2c3-da2d0eb902fa/E-GEOD-39842/E-GEOD-39842.tsv \
 -a results/QN_GSE39842_annotation_df.tsv \
 -p plots/QN_GSE39842_limma_venn.png \
 -r results/QN_GSE39842_results_table.tsv \
 -t results/QN_GSE39842_top_table.tsv

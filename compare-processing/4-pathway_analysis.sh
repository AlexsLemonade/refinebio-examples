#!/bin/bash

# RMA processed data from GEO
Rscript scripts/pathway_analysis.R \
  -d results/RMA_GSE39842_results_table.tsv \
  -o results/pathway_analysis \
  -p RMA

# SCAN processed data, no quantile normalization from staging  
Rscript scripts/pathway_analysis.R \
  -d results/SCANfast_GSE39842_results_table.tsv \
  -o results/pathway_analysis \
  -p SCANfast
  
# SCAN processed data, quantile normalized from dev
# SCAN processed data, no quantile normalization from staging  
Rscript scripts/pathway_analysis.R \
  -d results/QN_GSE39842_results_table.tsv \
  -o results/pathway_analysis \
  -p QN
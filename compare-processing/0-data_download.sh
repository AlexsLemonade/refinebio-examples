#!/bin/bash

# download RMA processed data from GEO
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE39nnn/GSE39842/matrix/GSE39842_series_matrix.txt.gz \
	-P data
gunzip data/GSE39842_series_matrix.txt.gz

# identifier refinery mappings
mkdir data/id_refinery
wget https://zenodo.org/record/1410647/files/all_1536267482.zip \
 -P data/id_refinery
unzip -p data/id_refinery/all_1536267482.zip \
  zebrafish.tsv.gz > data/id_refinery/zebrafish.tsv.gz

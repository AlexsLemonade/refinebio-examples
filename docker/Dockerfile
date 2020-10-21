FROM rocker/tidyverse:4.0.2
LABEL maintainer="ccdl@alexslemonade.org"
WORKDIR /rocker-build/

### Install apt-getable packages to start
#########################################
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils dialog

# Add curl, bzip2 and some dev libs
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    awscli \
    bzip2 \
    curl \
    zlib1g \
    libbz2-dev \
    liblzma-dev \
    libreadline-dev

# libmagick++-dev is needed for coloblindr to install
RUN apt-get -y --no-install-recommends install \
    libgdal-dev \
    libudunits2-dev \
    libmagick++-dev

# Install pip3 and instalation tools
RUN apt-get -y --no-install-recommends install \
    python3-pip  python3-dev

RUN pip3 install \
    "setuptools==49.3.0" \
    "six==1.15.0" \
    "wheel==0.34.2"

#### R packages
###############

# Commonly used R packages
RUN Rscript -e  "install.packages( \
    c('cluster', \
      'GGally', \
      'optparse', \
      'R.utils', \
      'RColorBrewer', \
      'rprojroot', \
      'viridis', \
      'spelling', \
      'styler'))"

# Install bioconductor packages
# org.Mm.eg.db and org.Dr.eg.db are required for gene mapping
RUN R -e "options(warn = 2); BiocManager::install( \
    c('affy', \
      'apeglm', \
      'Biobase', \
      'clusterProfiler', \
      'ComplexHeatmap', \
      'DESeq2', \
      'EnhancedVolcano', \
      'ggupset', \
      'limma', \
      'marray', \
      'msigdbr', \
      'org.Mm.eg.db', \
      'org.Dr.eg.db'), \
     update = FALSE)"

# Installs packages needed for plottings
# treemap, interactive plots, and hex plots
# Rtsne and umap are required for dimension reduction analyses
RUN Rscript -e  "install.packages( \
    c('ggfortify', \
      'ggsignif', \
      'patchwork', \
      'pheatmap', \
      'Rtsne', \
      'umap', \
      'VennDiagram'))"

# Install packages from github
# Need this package to make plots colorblind friendly
RUN Rscript -e "remotes::install_github('clauswilke/colorblindr', ref = '1ac3d4d62dad047b68bb66c06cee927a4517d678', dependencies = TRUE)"

# Install python libraries
##########################

# Install python3 data science tools
RUN pip3 install \
    "cycler==0.10.0" \
    "kiwisolver==1.2.0" \
    "numpy==1.19.1" \
    "pandas==1.1.0" \
    "pyparsing==2.4.7" \
    "python-dateutil==2.8.1" \
    "pytz==2020.1" \
    "snakemake==5.20.1"

# set final workdir for commands
WORKDIR /home/rstudio

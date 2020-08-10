FROM rocker/tidyverse:4.0.2
LABEL maintainer="ccdl@alexslemonade.org"
WORKDIR /rocker-build/

### Install apt-getable packages to start
#########################################
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils dialog

# Add curl, bzip2 and some dev libs
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    curl \
    bzip2 \
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

RUN pip3 install "setuptools==49.3.0" "six==1.15.0" "wheel==0.34.2"


#### R packages
###############

# Commonly used R packages
RUN install2.r --error --deps TRUE \
    cluster \
    GGally \
    optparse \
    R.utils \
    RColorBrewer \
    rprojroot \
    viridis \
    styler

##########################
# Install bioconductor packages
RUN R -e "BiocManager::install(c('affy', 'Biobase', 'ComplexHeatmap', 'DESeq2', 'limma', 'marray'), \
    update = FALSE)"

# Installs packages needed for plottings
# treemap, interactive plots, and hex plots
# Rtsne and umap are required for dimension reduction analyses
RUN install2.r --error --deps TRUE \
    ggfortify \
    ggsignif \
    patchwork \
    pheatmap \
    Rtsne \
    umap  \
    VennDiagram 

##########################
# Install packages from github
# Need this package to make plots colorblind friendly
RUN R -e "remotes::install_github('clauswilke/colorblindr', ref = '1ac3d4d62dad047b68bb66c06cee927a4517d678', dependencies = TRUE)"

# Install python libraries
##########################

# Install python3 data science tools
RUN pip3 install \
    "cycler==0.10.0" "kiwisolver==1.2.0" "pyparsing==2.4.7" "python-dateutil==2.8.1" "pytz==2020.1" \
    "numpy==1.19.1" \
    "pandas==1.1.0" \
    "snakemake==5.20.1"

# set final workdir for commands
WORKDIR /home/rstudio

# adapted from rocker/tidyverse
FROM rocker/rstudio:3.5.1

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  libpq-dev \
  libssh2-1-dev \
  python-dev \
  && R -e "source('https://bioconductor.org/biocLite.R')" \
  && install2.r --error \
    --deps TRUE \
    tidyverse \
    dplyr \
    devtools \
    formatR \
    remotes \
    selectr \
    optparse \
    VennDiagram \
    matrixStats \
    WebGestaltR \
  && R -e "BiocInstaller::biocLite(c('limma', 'ComplexHeatmap', 'preprocessCore'), suppressUpdates = TRUE)"

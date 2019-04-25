# Pathway analysis

## Requirements and usage

This module requires you to install the following software to run examples yourself:

* [**R**](https://cran.r-project.org/)
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**devtools**](https://cran.r-project.org/web/packages/devtools/readme/README.html) will be required for installing some packages from GitHub. We recommend installing from CRAN.

These requirements can be installed by following the instructions at the links above. 
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.

You can open an R Notebook by opening the `.Rmd` file in RStudio.
Note that working with R Notebooks requires certain R packages, but RStudio should prompt you to download them the first time you open one.
This will allow you to modify and run the R code chunks.

TODO: Link to training (https://github.com/AlexsLemonade/training-modules/issues/66)

## What is pathway analysis?

## Choosing gene sets

### Curated gene sets

QuSAGE, GSEA, and other pathway analysis methods allow you to read in gene sets that are in the [GMT format](http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29).

[MSigDB](http://software.broadinstitute.org/gsea/msigdb) offers genesets in GMT format.
[Curated gene sets](http://software.broadinstitute.org/gsea/msigdb/collections.jsp#C2) 
such as [KEGG](https://www.genome.jp/kegg/) are a good starting point for any pathway analysis.

If you're interested in a smaller set of pathways/gene sets that condense down 
some of the overlap between gene sets, you might check out the 
[Hallmark gene set collection](http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp#H).

### Gene Ontology (GO)

## Types of Pathway Analysis

### QuSAGE

In this module, we'll demonstrate how to perform pathway analysis using
Quantitative Set Analysis of Gene Expression (QuSAGE) 
([Yaari et al. _NAR_. 2013.](https://doi.org/10.1093/nar/gkt660)).
QuSAGE, implemented in the [`qusage` bioconductor package](https://bioconductor.org/packages/release/bioc/html/qusage.html),
has some nice features:

* It takes into account inter-gene correlation (a source of type I error).
* It returns more information than just a p-value. 
That's useful for analyses you might want to perform downstream.
* Built-in visualization functionality.

We recommend taking a look at the original publication (Yaari et al.) and 
the R package documentation to learn more.

#### Meta-analysis

### GSEA 

### ssGSEA

### Over-representation analysis with WebGestalt

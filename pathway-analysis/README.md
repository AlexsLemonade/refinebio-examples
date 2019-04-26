# Pathway analysis

**Table of Contents**

## Requirements and usage

This module requires you to install the following software to run examples yourself:

* [**R**](https://cran.r-project.org/)
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**devtools**](https://cran.r-project.org/web/packages/devtools/readme/README.html) will be required for installing some packages from GitHub. We recommend installing `devtools` from CRAN.

These requirements can be installed by following the instructions at the links above. 
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.

#### RStudio

We have prepared [a quick guide to RStudio](https://github.com/AlexsLemonade/training-modules/blob/master/intro_to_R_tidyverse/00-rstudio_guide.md) as part of our training content that you may find helpful if you're getting started with RStudio for the first time.

Note that the first time you open RStudio, you should select a CRAN mirror. 
You can do so by clicking `Tools` > `Global Options` > `Packages` and selecting a
CRAN mirror near you with the `Change` button.

#### Interacting with R Notebooks

You can open an R Notebook by opening the `.Rmd` file in RStudio.
Note that working with R Notebooks requires certain R packages, but RStudio should prompt you to download them the first time you open one.
This will allow you to modify and run the R code chunks.
Chunks that have already been included in an example can be run by clicking the green play button in the top right corner of the chunk or by using **Ctrl + Shift + Enter** (**Cmd + Shift + Enter** on a Mac).
See [this guide using to R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html#using-notebooks) for more information about inserting and executing code chunks.

## What is pathway analysis?

We refer to any technique that uses predetermined sets of genes that are related or coordinated in their expression in some way (e.g., participate in the same molecular process, are regulated by the same transcription factor) to interpret a high-throughput experiment as **pathway analysis**.
In the context of [refine.bio](https://www.refine.bio/), we use these techniques to analyze and interpret genome-wide gene expression experiments.
The rationale for performing pathway analysis is that looking at the pathway-level may be more biologically meaningful than considering individual genes, especially if a large number of genes are differentially expressed between conditions of interest.
In addition, many relatively small changes in the expression values of genes in the same pathway could lead to a phenotypic outcome and these small changes may go undetected in differential gene expression analysis.

This example module is by no means exhaustive.
Rather, it is intended to be a brief introduction to some pathway analysis methods and gene set sources with worked practical examples.
We highly recommend taking a look at [**Ten Years of Pathway Analysis: Current Approaches and Outstanding Challenges**](https://doi.org/10.1371/journal.pcbi.1002375) from Khatri et al. (_PLoS Comp Bio_. 2012.) for a more comprehensive overview and reading the primary publications and documentation of the methods and sources we will introduce below.

## Choosing gene sets

Below, we briefly introduce some commonly used gene set sources.

### Curated gene sets

QuSAGE, GSEA, and other pathway analysis methods allow you to read in gene sets that are in the [GMT format](http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29), a common format for storing gene sets.

The [Molecular Signatures Database (MSigDB)](http://software.broadinstitute.org/gsea/msigdb) offers genesets in GMT format ([Subramanian et al. _PNAS_. 2005.](https://doi.org/10.1073/pnas.0506580102), [Liberzon et al. _Bioinformatics_. 2011.](https://doi.org/10.1093/bioinformatics/btr260)).
[Curated gene sets](http://software.broadinstitute.org/gsea/msigdb/collections.jsp#C2) 
such as [KEGG](https://www.genome.jp/kegg/) ([Kanehisa et al. _NAR_. 2000.](https://doi.org/10.1093/nar/28.1.27), [Kanehisa et al. _NAR_. 2017.](https://doi.org/10.1093/nar/gkw1092), [Kanehisa et al. _NAR_. 2019.](https://doi.org/10.1093/nar/gky962)) are a good starting point for any pathway analysis. 
From the [MSigDB documentation](http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp#C2), curated gene sets are:
> Gene sets curated from various sources such as online pathway databases, the biomedical literature, and contributions from domain experts.

If you're interested in a smaller set of pathways/gene sets that condense down 
some of the overlap between gene sets, you might check out the 
[Hallmark gene set collection](http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp#H) ([Liberzon et al. _Cell Systems_. 2015.](https://doi.org/10.1016/j.cels.2015.12.004)).

Note that the gene sets from MSigDB are for human only.
If you are working with data from another organism, you will either need to perform ortholog mapping or select a different source.
We provide an example [ortholog mapping notebook for KEGG pathways](https://alexslemonade.github.io/refinebio-examples/pathway-analysis/kegg_ortholog_mapping.nb.html).
Be aware that making choices for ortholog mapping (e.g., selecting source knowledgebase(s), dealing with 1:many mappings) is non-trivial and may influence your downstream results.

### Gene Ontology (GO)

The [Gene Ontology (GO)](http://geneontology.org/docs/ontology-documentation/) is an [ontology](https://en.wikipedia.org/wiki/Ontology_(information_science)) that places genes into categories or terms and represents the relationship between terms.
GO formally represents various aspects of biological knowledge:

* **Molecular Function (MF)** - terms that describe _activities_, such as [transferase activity](https://www.ebi.ac.uk/QuickGO/term/GO:0016740)
* **Cellular Component (CC)** - macromolecules or cellular structures, such as [axon cytoplasm](https://www.ebi.ac.uk/QuickGO/term/GO:1904115)
* **Biological Process (BP)** - "larger processes," such as [DNA metabolic process](https://www.ebi.ac.uk/QuickGO/term/GO:0006259)

If you've clicked on the links above, you'll likely have noticed a hierarchy to the GO terms, i.e., narrower terms are types of or parts of broader terms (mitochondrion is an organelle; example from [GO relations documentation](http://geneontology.org/docs/ontology-relations/)).
If you use a method that doesn't explicitly take the relations into account (treats all the gene sets as independent), there will be considerable redundancy.
GO terms are not regarded as _pathways_ in the same way as a KEGG pathway.
GO annotations can be [downloaded for multiple species](http://current.geneontology.org/products/pages/downloads.html).

We use GO biological processes in our over-representation analysis example only (see [below](#over-representation-analysis-with-webgestalt)).

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

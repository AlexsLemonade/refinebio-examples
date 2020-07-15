# refine.bio Examples: Pathway analysis

**Table of Contents**

* [Requirements and usage](#requirements-and-usage)
* [What is pathway analysis?](#what-is-pathway-analysis)
* [Choosing gene sets](#choosing-gene-sets)
  * [Curated gene sets](#curated-gene-sets)
  * [Gene Ontology (GO)](#gene-ontology-go)
* [Types of pathway analysis](#types-of-pathway-analysis)
  * [QuSAGE](#qusage)
  * [GSEA](#gsea)
  * [ssGSEA](#ssgsea)
  * [Over-representation analysis (ORA)](#over-representation-analysis-with-webgestalt)

**Example Workflow R Notebooks**

* [Analyzing a single dataset with `qusage`](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/qusage_single_dataset.nb.html)
* [Performing meta-analysis with `qusage`](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/qusage_meta_analysis.nb.html)
* [Exploratory data analysis with ssGSEA](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/ssgsea_example.nb.html)
* [Over-representation analysis with `WebGestaltR`](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/ora_with_webgestaltr.nb.html)

## Requirements and usage

This module requires you to install the following software to run examples yourself:

* [**R**](https://cran.r-project.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* [**devtools**](https://cran.r-project.org/web/packages/devtools/readme/README.html) will be required for installing some packages from GitHub. We recommend installing `devtools` from CRAN.

These requirements can be installed by following the instructions at the links above.
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.

#### RStudio

We have prepared [a quick guide to RStudio](https://github.com/AlexsLemonade/training-modules/blob/master/intro_to_R_tidyverse/00-rstudio_guide.md) as part of our training content that you may find helpful if you're getting started with RStudio for the first time.

Note that the first time you open RStudio, you should select a CRAN mirror.
You can do so by clicking `Tools` > `Global Options` > `Packages` and selecting a CRAN mirror near you with the `Change` button.

You can install the additional requirements (e.g., tidyverse) through RStudio.

#### Obtaining the R Notebooks

To run the examples yourself, you will need to [clone](https://help.github.com/articles/cloning-a-repository/) or [download](https://stackoverflow.com/a/6466993) this repository: https://github.com/AlexsLemonade/refinebio-examples

#### Interacting with R Notebooks

You can open an R Notebook by opening the `.Rmd` file in RStudio.
Note that working with R Notebooks requires certain R packages, but RStudio should prompt you to download them the first time you open one.
This will allow you to modify and run the R code chunks.
Chunks that have already been included in an example can be run by clicking the green play button in the top right corner of the chunk or by using **Ctrl + Shift + Enter** (**Cmd + Shift + Enter** on a Mac).
See [this guide using to R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html#using-notebooks) for more information about inserting and executing code chunks.

#### Using your own data

For all the examples in this module, the gene expression data and sample metadata are stored in a `data/` directory.
If you'd like to adapt an example to include data you've obtained from [refine.bio](https://www.refine.bio/), we recommend placing the files in the `data/` directory and changing the filenames and paths in the notebooks to match these files.
We'd also recommend maintaining the project structure that is in place by placing any new GMT files in a `gene-sets/` directory.
We suggest saving plots and results to `plots/` and `results/` directories, respectively, as these are automatically created by the notebooks if you move notebooks outside of the GitHub repository structure.
Note that if your GMT files use different identifiers than the GMT files used in the notebooks, you will need to make additional changes to the code.

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

The [Molecular Signatures Database (MSigDB)](http://software.broadinstitute.org/gsea/msigdb) offers gene sets in GMT format ([Subramanian et al. _PNAS_. 2005.](https://doi.org/10.1073/pnas.0506580102), [Liberzon et al. _Bioinformatics_. 2011.](https://doi.org/10.1093/bioinformatics/btr260)).
[Curated gene sets](http://software.broadinstitute.org/gsea/msigdb/collections.jsp#C2)
such as [KEGG](https://www.genome.jp/kegg/) ([Kanehisa et al. _NAR_. 2000.](https://doi.org/10.1093/nar/28.1.27), [Kanehisa et al. _NAR_. 2017.](https://doi.org/10.1093/nar/gkw1092), [Kanehisa et al. _NAR_. 2019.](https://doi.org/10.1093/nar/gky962)) are a good starting point for any pathway analysis.
From the [MSigDB documentation](http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp#C2), curated gene sets are:
> Gene sets curated from various sources such as online pathway databases, the biomedical literature, and contributions from domain experts.

If you're interested in a smaller set of pathways/gene sets that condense down
some of the overlap between gene sets, you might check out the
[Hallmark gene set collection](http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp#H) ([Liberzon et al. _Cell Systems_. 2015.](https://doi.org/10.1016/j.cels.2015.12.004)).

Note that the gene sets from MSigDB are for human only.
If you are working with data from another organism, you will either need to perform ortholog mapping or select a different source.
We provide an example [ortholog mapping notebook for KEGG pathways](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/kegg_ortholog_mapping.nb.html).
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

In this module, we use Quantitative Set Analysis of Gene Expression (QuSAGE) ([Yaari et al. _NAR_. 2013.](https://doi.org/10.1093/nar/gkt660)) extensively.
QuSAGE, implemented in the [`qusage` bioconductor package](https://bioconductor.org/packages/release/bioc/html/qusage.html), has some nice features:

* It takes into account inter-gene correlation (a source of type I error).
* It returns more information than just a p-value.
That's useful for analyses you might want to perform downstream.
* Built-in visualization functionality.

We recommend taking a look at the original publication ([Yaari et al. _NAR_. 2013.](https://doi.org/10.1093/nar/gkt660)) and the R package [vignette](https://bioconductor.org/packages/release/bioc/vignettes/qusage/inst/doc/qusage.pdf) and [manual](https://bioconductor.org/packages/release/bioc/manuals/qusage/man/qusage.pdf) to learn more.

We provide an example workflow for [**analyzing a single dataset with `qusage`**](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/qusage_single_dataset.nb.html) ([Rmd](https://github.com/AlexsLemonade/refinebio-examples/blob/master/02-microarray/pathway-analysis/qusage_single_dataset.Rmd)).
In addition, we've replicated the analysis in the `qusage` package vignette using refine.bio-processed data [[notebook](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/qusage_replicate_vignette.nb.html), [Rmd](https://github.com/AlexsLemonade/refinebio-examples/blob/master/02-microarray/pathway-analysis/qusage_replicate_vignette.Rmd)]; this includes a two-way comparison.

#### Meta-analysis

Another reason for performing pathway analysis was noted in a landmark pathway analysis paper ([Subramanian et al. _PNAS_. 2005.](https://doi.org/10.1073/pnas.0506580102)): analyzing multiple datasets at the biological pathway-level yields much more similarity than analysis at the individual gene-level.

One way to approach the issue of multiple datasets would be to analyze each dataset separately and then look at the overlap in pathway lists using some cutoff (e.g., FDR value).
This approach limits the kinds of comparisons one can perform.
QuSAGE has been extended to include support for meta-analysis and possesses the same advantages as the QuSAGE framework for single dataset analysis ([Meng et al. _PLoS Comp Bio._ 2019.](https://doi.org/10.1371/journal.pcbi.1006899)), such as the ability to perform more complex _post hoc_ analyses.

We have prepared a [**meta-analysis example workflow**](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/qusage_meta_analysis.nb.html) ([Rmd](https://github.com/AlexsLemonade/refinebio-examples/blob/master/02-microarray/pathway-analysis/qusage_meta_analysis.Rmd)) in medulloblastoma.

### GSEA

[Gene Set Enrichment Analysis (GSEA)](http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Main_Page) is a popular method to determine if gene sets show significant differences between two groups ([Subramanian et al. _PNAS_. 2005.](https://doi.org/10.1073/pnas.0506580102)) and any discussion of pathway analysis would be incomplete without it.

We do not provide an example in this repository, as the folks that maintain GSEA provide a number of well-documented ways to run your analysis.
However, you may find that our example workflows will help you prepare data for use with GSEA (e.g., [gene ID conversion](https://alexslemonade.github.io/refinebio-examples/02-microarray/ensembl-id-convert/ensembl_id_convert.nb.html), [KEGG ortholog mapping](https://alexslemonade.github.io/refinebio-examples/pathway-analysis/kegg_ortholog_mapping.nb.html).

**Helpful links** (most require registration)

* [GSEA Documentation](http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Main_Page)
* [GSEA Downloads](http://software.broadinstitute.org/gsea/downloads.jsp) (includes Java GUI and CLI, Rscript)
* [GSEA User Guide](http://software.broadinstitute.org/gsea/doc/GSEAUserGuideFrame.html)

### ssGSEA

Single-sample GSEA (ssGSEA) is a method for calculating enrichment scores for individual samples ([Barbie et al. _Nature_. 2009.](https://dx.doi.org/10.1038/nature08460)).
This can be useful if you are not sure what phenotypic groups you'd like to compare and are interested in exploring what pathways have the highest variance in your data or produce enrichment scores that are correlated with some phenotypic measurement.

We demonstrate how to [**perform exploratory data analysis with ssGSEA using the `GSVA` package**](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/ssgsea_example.nb.html) ([Rmd](https://github.com/AlexsLemonade/refinebio-examples/blob/master/02-microarray/pathway-analysis/ssgsea_example.Rmd)).
Note that there is also an ssGSEA GenePattern module ([docs](https://gsea-msigdb.github.io/ssGSEAProjection-gpmodule/v9/index.html)).

### Over-representation analysis with WebGestalt

Over-representation analysis (ORA) is a method of pathway or gene set analysis where one can ask if a set of genes (e.g., those differentially expressed using some cutoff) shares more or less genes with gene sets/pathways than we would expect at random.
The other methodologies introduced throughout this module such as QuSAGE and GSEA can require more samples than a differential expression analysis.
For instance, the sample label permutation step of GSEA is reported to perform poorly with 7 samples or less in each group ([Yaari et al. _NAR_. 2013.](https://doi.org/10.1093/nar/gkt660)).
It is not uncommon to have n = 3 for each group in a treatment-control transcriptomic study, at which point identifying differentially expressed genes is possible.
If you are performing pathway or gene set analysis on a study of this size, you may be best served by ORA.
There are some limitations to ORA methods to be aware such as ignoring gene-gene correlation.
See [Khatri et al. _PLoS Comp Bio._ 2012.](https://doi.org/10.1371/journal.pcbi.1002375) to learn more about the different types of pathway analysis and their limitations.

We provide an example workflow for [**performing over-representation analysis with `WebGestaltR`**](https://alexslemonade.github.io/refinebio-examples/02-microarray/pathway-analysis/ora_with_webgestaltr.nb.html) ([Rmd](https://github.com/AlexsLemonade/refinebio-examples/blob/master/02-microarray/pathway-analysis/ora_with_webgestaltr.Rmd)).
WebGestalt also has a [web interface](http://www.webgestalt.org/) and is not limited to ORA.

\* In using these data, you agree to our [terms and conditions](https://www.refine.bio/terms)

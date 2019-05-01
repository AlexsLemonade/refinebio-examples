# refine.bio Examples: Validate Differential Expression

These notebooks compare the differential expression results from a [refine.bio](https://www.refine.bio/) dataset to an independent dataset that has a similar experimental design.

## Background and input requirements

If you have differential expression results from your own data or a collaborator’s data, it is good practice to validate your findings in another dataset that measures a similar tissue with a similar experimental design.
You can use refine.bio datasets and the steps in this example to quickly check for agreement with your results.
To use this example workflow with your own results, you will need the following fields in your table:

#### Required fields for differential expression results:
1) A gene or probe identifier
2) The direction of the expression differences (often indicated by fold-change)
3) p-values that are corrected for multiple testing (e.g., FDR)

*At the bare minimum, you will need two gene lists, one for up-regulated and another for down-regulated genes.*

The main notebook for this example is [`gene_DE_validate`](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/gene_DE_validate.nb.html).
This notebook compares the differential expression results of the two datasets:  

1) A refine.bio-processed dataset's differential expression results - which are carried out within [the main notebook](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/gene_DE_validate.nb.html).   

2) An author-processed dataset's [differential expression results](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/author_processed_DE.nb.html) - but for using this workflow with your own dataset's results, any methodology that gives you the [required fields mentioned above](#required-fields-for-differential-expression-results) is fine.
Ideally you'd use the same pipeline for initial results and validation.    

The comparison in this example results in a Venn diagram that illustrates the overlap of the two datasets' differentially-regulated genes.
For this example workflow, the gene expression datasets and sample metadata are stored in a `data/` directory.
For more instructions on how to apply this workflow to your own data, see the [section below](#apply-this-workflow-to-your-own-differential-expression-results).

## General requirements and usage

This module requires you to install the following software to run examples yourself:

* [**R**](https://cran.r-project.org/)
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).

These requirements can be installed by following the instructions at the links above.
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.

#### RStudio

We have prepared [a quick guide to RStudio](https://github.com/AlexsLemonade/training-modules/blob/master/intro_to_R_tidyverse/00-rstudio_guide.md) as part of our training content that you may find helpful if you're getting started with RStudio for the first time.

Note that the first time you open RStudio, you should select a CRAN mirror.
You can do so by clicking `Tools` > `Global Options` > `Packages` and selecting a CRAN mirror near you with the `Change` button.

#### Interacting with R Notebooks

You can open an R Notebook by opening the `.Rmd` file in RStudio.
Note that working with R Notebooks requires certain R packages, but RStudio should prompt you to download them the first time you open one.
This will allow you to modify and run the R code chunks.
Chunks that have already been included in an example can be run by clicking the green play button in the top right corner of the chunk or by using **Ctrl + Shift + Enter** (**Cmd + Shift + Enter** on a Mac).
See [this guide using to R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html#using-notebooks) for more information about inserting and executing code chunks.

#### Obtaining the R Notebooks

To run the example yourself, you will need to [clone](https://help.github.com/articles/cloning-a-repository/) or [download](https://stackoverflow.com/a/6466993) this repository: https://github.com/AlexsLemonade/refinebio-examples

## Apply this workflow to your own differential expression results

If you'd like to adapt an example to include data you've obtained from [refine.bio](https://www.refine.bio/), and your own dataset's differential expression results, we recommend following these steps below.

#### Step 1) Find a refine.bio dataset

Find and download a [refine.bio](https://www.refine.bio/) dataset that has a similar set up and metadata to your own differential expression analysis.
Use the search bar to look for datasets with key terms.
Filters can help you find datasets with similar platforms.

#### Step 2) Set up your data

Place the refine.bio data and metadata TSV files, along with your own differential expression results you'd like to compare them to in the `data/` directory (if you need further instruction on obtaining differential expression results in the first place, we recommend following our [other example workflow](https://github.com/AlexsLemonade/refinebio-examples/differential-expression/)).
Within the R notebook, you will need to change all the `file.path` references to the file names of your new refine.bio datasets and your own results files.
Note that wherever `refine.bio` is specified in the code, it should be changed to correspond to the new refine.bio dataset you identified in `Step 1`.
Furthermore, wherever `author` is specified should correspond to your differential expression results you would like to compare to.
We also suggest changing the names of the output `plots` and `results` to reflect your new comparison analysis.

Note: If your differential expression results do not have Ensembl ID's associated with them, you can try to change the steps here accordingly, but we also recommend referencing the [ID conversion example workflow](https://alexslemonade.github.io/refinebio-examples/ensembl-id-convert/ensembl_id_convert.nb.html) for more information on this step.

#### Step 3) Follow the example steps in [gene_DE_validate](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/gene_DE_validate.nb.html)

There are a number of ways to compare differential expression results, but [this workflow](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/gene_DE_validate.nb.html) takes the simplest approach of looking at overlap of gene lists.
This is partially so that this notebook’s approach can be applied to any differential expression output, provided that the output has the [required fields listed above](#required-fields-for-differential-expression-results).

Depending on the form of your differential expression results, you will need to alter the steps in [`gene_DE_validate`](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/gene_DE_validate.nb.html) to obtain the two aforementioned gene lists.
We advise familiarizing yourself with [`tidyverse`](https://www.tidyverse.org/) functions, particularly the ones used in [this main example](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/gene_DE_validate.nb.html), to help you determine the how to clean your data for use with this analysis.

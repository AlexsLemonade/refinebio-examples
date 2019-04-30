# refine.bio Examples: Validate Differential Expression

These notebooks compare the differential expression results from a refine.bio dataset to an non-refine.bio dataset that both have a similar experimental set up.

You may obtain differential expression results from your own data or a collaborator’s data.
It is good practice to validate your findings in another dataset that measures a similar tissue with a similar experimental design.
You can use refine.bio datasets and the steps in this example to quickly check for agreement with your results.

**Example Workflow R Notebooks**

* [Performing differential expression on a non-refine.bio dataset](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/author_processed_DE.nb.html) - this notebook is showing how we obtained differential expression results for our non-refine.bio dataset
* [Analyzing overlap of differential expression results](https://alexslemonade.github.io/refinebio-examples/validate-differential-expression/gene_DE_validate.nb.html) - this notebook compares the differential expression results of the two datasets

## Requirements and usage

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

#### Using your own data

For all the examples in this module, the gene expression data and sample metadata are stored in a `data/` directory.
If you'd like to adapt an example to include data you've obtained from [refine.bio](https://www.refine.bio/), we recommend placing the files in the `data/` directory and changing the filenames and paths in the notebooks to match these files.
We suggest saving plots and results to `plots/` and `results/` directories, respectively, as these are automatically created by the notebooks if you move notebooks outside of the GitHub repository structure.

There are a number of ways to compare differential expression results, but this notebook’s example takes the simplest approach of looking at overlap of gene lists.
This is partially so that this notebook’s approach can be applied to any differential expression output, provided that the output meets certain criteria listed below. *At the bare minimum, you will need two gene lists, one for up-regulated and another for down-regulated genes.*

*Ideally* you will have table of differential expression results that will have:

1) A gene or probe identifier
2) The direction of the expression differences (often indicated by fold-change)
3) p-values that are corrected for multiple testing (e.g., FDR)

Depending on the form of your differential expression results, you will need to alter the steps in [`gene_DE_validate.Rmd`](./gene_DE_validate.nb.html) to obtain the two aforementioned gene lists.
We advise familiarizing yourself with [`tidyverse`](https://www.tidyverse.org/) functions, particularly the ones used in [this example](./gene_DE_validate.nb.html) in order to help you determine the how to clean your data for use with this analysis.

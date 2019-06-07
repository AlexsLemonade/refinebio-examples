# refine.bio Examples: Quantile normalize your own data  

This directory contains an example workflow of how to quantile normalize your own dataset to make it more comparable to data you obtain from [refine.bio](https://www.refine.bio).

## Requirements and usage

This module requires you to install the following software to run the example yourself:

* [**R**](https://cran.r-project.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* **wget** - [installation instructions for Mac with Homebrew](https://www.maketecheasier.com/install-wget-mac/), [installation instructions for Windows 10](https://builtvisible.com/download-your-website-with-wget/) (under _Install WGET in Windows 10_), [installation instructions for Debian or Ubuntu Linux](https://www.cyberciti.biz/faq/how-to-install-wget-togetrid-of-error-bash-wget-command-not-found/)

These requirements can be installed by following the instructions at the links above.
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.

#### RStudio

We have prepared [a quick guide to RStudio](https://github.com/AlexsLemonade/training-modules/blob/master/intro_to_R_tidyverse/00-rstudio_guide.md) as part of our training content that you may find helpful if you're getting started with RStudio for the first time.

Note that the first time you open RStudio, you should select a CRAN mirror.
You can do so by clicking `Tools` > `Global Options` > `Packages` and selecting a CRAN mirror near you with the `Change` button.

You can install the additional R package requirements (e.g., tidyverse) through RStudio.

#### Obtaining the R Notebooks

To run the examples yourself, you will need to [clone](https://help.github.com/articles/cloning-a-repository/) or [download](https://stackoverflow.com/a/6466993) this repository: https://github.com/AlexsLemonade/refinebio-examples

#### Interacting with R Notebooks

You can open an R Notebook by opening the `.Rmd` file in RStudio.
Note that working with R Notebooks requires certain R packages, but RStudio should prompt you to download them the first time you open one.
This will allow you to modify and run the R code chunks.
Chunks that have already been included in an example can be run by clicking the green play button in the top right corner of the chunk or by using **Ctrl + Shift + Enter** (**Cmd + Shift + Enter** on a Mac).
See [this guide using to R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html#using-notebooks) for more information about inserting and executing code chunks.

## Background

Datasets that are downloaded from the web interface of [refine.bio](http://www.refine.bio) are [quantile normalized](https://en.wikipedia.org/wiki/Quantile_normalization) because we allow users to aggregate multiple platforms (e.g., microarray chips) and even multiple technologies.
Quantile normalization (QN) ensures that the underlying distributions of samples are the same.

If you are interested in comparing your own data to data you have downloaded from the refine.bio website, you may wish to quantile normalize it using the reference distribution we've used in refine.bio.

You can read more about the reference distribution and how it is generated in the [quantile normalization section](http://docs.refine.bio/en/latest/main_text.html#quantile-normalization) of our [documentation](http://docs.refine.bio/en/latest/).

In this [example notebook](https://alexslemonade.github.io/refinebio-examples/normalize-own-data/quantile_normalize_own_data.nb.html), we demonstrate how to obtain the reference distribution from the refine.bio API and apply it to your own data in R.

#### Using your own data

The R package we use for quantile normalization ([`preprocessCore`](https://bioconductor.org/packages/release/bioc/html/preprocessCore.html)) expects a matrix where samples are columns and genes are rows.
Any tabular format that can be read into R and follows this format (or can be easily transposed) is appropriate.
In our example, we use a TSV file where samples are columns and genes are rows.

\* In using these data, you agree to our [terms and conditions](https://www.refine.bio/terms)

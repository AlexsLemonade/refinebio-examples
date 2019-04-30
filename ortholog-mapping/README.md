# refine.bio Examples: Ortholog Mapping

[This notebook](https://alexslemonade.github.io/refinebio-examples/ortholog-mapping/ortholog_mapping_example.nb.html) demonstrates how you can use the [`hcop`](https://github.com/stephenturner/hcop) package to perform ortholog mapping for data obtained from refine.bio. 
HCOP stands for HGNC Comparison of Orthology Predictions.
You can read more about the package [here](https://stephenturner.github.io/hcop).

## Requirements and usage

This module requires you to install the following software to run the example yourself:

* [**R**](https://cran.r-project.org/)
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**devtools**](https://cran.r-project.org/web/packages/devtools/readme/README.html) will be required for installing some packages from GitHub. We recommend installing `devtools` from CRAN.

These requirements can be installed by following the instructions at the links above. 
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.
Note that this notebook does check if `devtools` is installed, but we have encountered some trouble with missing system requirements and recommend installing the package prior to running the notebook.

#### RStudio

We have prepared [a quick guide to RStudio](https://github.com/AlexsLemonade/training-modules/blob/master/intro_to_R_tidyverse/00-rstudio_guide.md) as part of our training content that you may find helpful if you're getting started with RStudio for the first time.

Note that the first time you open RStudio, you should select a CRAN mirror. 
You can do so by clicking `Tools` > `Global Options` > `Packages` and selecting a CRAN mirror near you with the `Change` button.

#### Obtaining the R Notebooks

To run the example yourself, you will need to [clone](https://help.github.com/articles/cloning-a-repository/) or [download](https://stackoverflow.com/a/6466993) this repository: https://github.com/AlexsLemonade/refinebio-examples

#### Interacting with R Notebooks

You can open the R Notebook by opening the `.Rmd` file in RStudio.
Note that working with R Notebooks requires certain R packages, but RStudio should prompt you to download them the first time you open one.
This will allow you to modify and run the R code chunks.
Chunks that have already been included in an example can be run by clicking the green play button in the top right corner of the chunk or by using **Ctrl + Shift + Enter** (**Cmd + Shift + Enter** on a Mac).
See [this guide using to R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html#using-notebooks) for more information about inserting and executing code chunks.

#### Using your own data

For the example in this module, the gene expression data and sample metadata are stored in a `data/` directory.
If you'd like to adapt an example to include data you've obtained from [refine.bio](https://www.refine.bio/), we recommend placing the files in the `data/` directory and changing the filenames and paths in the notebook to match these files.
The output of the notebook is a TSV file that contains annotation with orthologs; this filename should be updated as well.
We suggest saving the output in the `results/` directory, as this is automatically created by the notebook if moved outside of the GitHub repository structure.

# refine.bio Examples Guide
This repository contains example workflows of how to use data downloaded from
[refine.bio](https://www.refine.bio).

## Getting started

### How to use this repository
We recommend [cloning](https://help.github.com/articles/cloning-a-repository/)
this repository and following the example analyses.
You can also use the green button that says "Clone or download" to "Download
ZIP" and then use this repository as you please on your own computer, if you
prefer.

Each directory in this repository is a set of example workflows to follow.
See the list of `Example Workflows` below for list of the analysis topics.

*Each directory is its own set of example workflows and contains:*

- A`README` that introduces you to the concepts and example analyses in that module.
- Example dataset(s) in the `data/` folder
- An R markdown (`Rmd`) file that you can use in RStudio to run the analysis
- An R notebook (`nb.html`) file that is the resulting output of the Rmd file
but in a prettier format.
- A `results` and/or `plots` folder(s) that contains the output of the analyses.

As you get more comfortable with the examples, we encourage you to apply these
example workflows to your own refine.bio data.
After downloading a refine.bio dataset, you can analyze them in these examples
by copying and pasting your data and metadata TSV files from your refine.bio
download file into the respective `data/` folder for that module.
You'll need to change any directory paths in the notebook to have the name of
your own dataset.
You will likely have to alter other steps of the examples, particularly those
having to deal with the metadata.

## General requirements for the example workflows

This module requires you to install the following software to run examples yourself:

* [**R**](https://cran.r-project.org/)
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**devtools**](https://cran.r-project.org/web/packages/devtools/readme/README.html)
will be required for installing some packages from GitHub. We recommend installing `devtools` from CRAN.

These requirements can be installed by following the instructions at the links
above.
The example R Notebooks are designed to check if additional required packages
are installed and will install them if they are not.
Each example workflow directory will include further instructions for how to
follow along with the examples.

## Example workflows in this repository  

1. [Clustering data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering)  

2. [Annotation using Ensembl IDs](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl-id-convert)  

3. [Differential expression analyses](https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression)  

4. [Ortholog mapping](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ortholog-mapping)  

5. [Quantile normalizing your own data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/normalize-own-data)

6. [Validate differential expression](https://github.com/AlexsLemonade/refinebio-examples/blob/master/validate-differential-expression)

7. [Pathway analyses](https://github.com/AlexsLemonade/refinebio-examples/blob/master/pathway-analysis)

This repository contains example workflows of how to use data downloaded from
[refine.bio](https://www.refine.bio).

## Getting started

### How to use this repository
We recommend [cloning](https://help.github.com/articles/cloning-a-repository/)
this repository and following the example analyses.
You can also use the green button that says "Clone or download" to "Download ZIP" and then use this repository as you please on your own computer, if you prefer.

Each directory in this repository is a set of example workflows to follow.
See the list of [**Example Modules**](#example-workflows-in-this-repository)
below for list of the analysis topics.

*Each directory is a module of example workflow(s) and contains:*

- A `README` that introduces you to the concepts, requirements, and workflows for that module.
- Example dataset(s) in the `data` folder
- A `results` and/or `plots` folder(s) that contains the output of the analyses.
- An [R Notebook](https://bookdown.org/yihui/rmarkdown/notebook.html#using-notebooks) which consists of:
  - An R markdown (`Rmd`) file(s) that you can use in RStudio to run the analysis
  - An `nb.html` file that is the resulting output of the Rmd file rendered as an HTML file.

As you get more comfortable with the examples, we encourage you to apply these example workflows to your own refine.bio data.
After downloading a refine.bio dataset, you can analyze them in these examples by placing the gene expression and metadata TSV files from your refine.bio download file into the respective `data/` folder for that module.
You'll need to change any file names in the notebook to correspond to your own dataset.
You will likely have to alter other steps of the examples, particularly those cleaning or filtering based on metadata.

## General requirements for the example workflows

Each module requires you to install the following software to run examples yourself.

* [**R**](https://cran.r-project.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)
* [**devtools**](https://cran.r-project.org/web/packages/devtools/readme/README.html)
will be required for installing some packages from GitHub. We recommend installing `devtools` from CRAN.

These requirements can be installed by following the instructions at the links above.
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.
Each example module directory will include further instructions for how to follow along with the examples.

## Example modules in this repository  

1. [Clustering data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering)  

2. [Differential expression analyses](https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression)  

3. [Validating differential expression results using refine.bio data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/validate-differential-expression)

4. [Pathway analyses](https://github.com/AlexsLemonade/refinebio-examples/blob/master/pathway-analysis)

5. [Dimension reduction](https://github.com/AlexsLemonade/refinebio-examples/blob/master/dimension-reduction)

6. [Converting from Ensembl gene IDs to another identifier](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl-id-convert)  

7. [Ortholog mapping](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ortholog-mapping)  

8. [Quantile normalizing your own data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/normalize-own-data)

## GenePattern modules with refine.bio data

[GenePattern](https://cloud.genepattern.org/gp/pages/login.jsf) has many ready-made analyses you could use with your refine.bio data.
Some example workflows (such as [differential expression](https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression) and [clustering](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering)) also include instructions for prepping your refine.bio data files for use in GenePattern.
For users who are not comfortable with using R Notebooks, the GenePattern modules can be run using a graphics user interface (GUI), so this may be more intuitive for you.

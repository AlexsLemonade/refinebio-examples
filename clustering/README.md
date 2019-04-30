# refine.bio Examples: Clustering

[This notebook](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering/clustering_example.nb.html)
uses the Bioconductor R package `ComplexHeatmap` for clustering and creating a
heatmap from data downloaded from [refine.bio](https://www.refine.bio).

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
We suggest saving plots and results to `plots/` and `results/` directories, respectively, as these are automatically created by the notebooks if you move notebooks outside of the GitHub repository structure.

In this example, the gene expression matrix is subset to only include genes with high variance.
The high variances set of genes is then used to create a heatmap.
[The clustering R Notebook](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering/clustering_example.nb.html) could be manipulated to sort by another summary statistic to create a heatmap, depending on your dataset and your research questions.

***
## Alternative clustering data methods with GenePattern

[GenePattern notebooks](http://genepattern-notebook.org/example-notebooks/)
contain [ready-made analyses](http://genepattern-notebook.org/example-notebooks/).
For users who are more comfortable with Python, or are not comfortable with
using R Notebooks, the GenePattern notebooks are written in Python but can be run using a graphics user interface (GUI).
To use GenePattern, you have to create an account.
For use with GenePattern notebooks, data from refine.bio needs to be converted to GenePattern
[formats](http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guide).
If you would like to do clustering but would prefer using GenePattern, follow the instructions below.

#### Create a gct file

In order to perform cluster analysis on your gene expression data, you must first create a 'gene cluster text' (gct) file from your refine.bio file.
In order to create a gct formatted file from a TSV refine.bio data file, reference the
[`create_gct_file.R` script](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering/scripts/create_gct_file.R), followed by `-f` argument with the name of the file in your current directory that you would like to convert.
Note: This script requires `optparse` library. If `optparse` library is not installed, this script will install it for you.

#### Example of usage in command line:  
 ```bash
 $ Rscript scripts/create_gct_file.R -f GSE111111.tsv -o outputfilename -r
 ```
Options:     
`-f` :name of the file in your current directory that you would like to convert.    
`-r` :file of the same name as the output will be rewritten (*optional*)       
`-o` :name for the output file (*optional*)       

Optionally you can designate the name of the output file by adding an `-o` argument.
The "gct" suffix will be added if you do not add it yourself.
Be sure to either have the script and input file in your current working directory, or put type out the full directory path for the script and/or input file. eg. `/users/Bob/Desktop/clustering/create_gct_file.R`

*Now login into [GenePattern](https://cloud.genepattern.org/gp/pages/login.jsf), select a `Clustering` module, and follow the instructions to upload and analyze your newly created gct file*

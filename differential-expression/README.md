# Refine.bio Example Workflow: Differential expression

[This notebook](https://alexslemonade.github.io/refinebio-examples/differential-expression/gene_DE.nb.html)

takes data and metadata from refine.bio and identifies differentially expressed genes.
This script is very generally applicable to pre-processed RNA-Seq or microarray data.

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
We recommend using the [`limma` user guide](https://www.bioconductor.org/packages/devel/bioc/vignettes/limma/inst/doc/usersguide.pdf)
to help you set up your model in a way that takes into account your experimental
set up and hypotheses.

***
## Alternative differential expression analysis with GenePattern

[GenePattern notebooks](http://genepattern-notebook.org/example-notebooks/)
contain [ready-made analyses](http://genepattern-notebook.org/example-notebooks/).
For users who are more comfortable with Python, or are not comfortable with
using R Notebooks, the GenePattern notebooks are written in Python but can be run using a graphics user interface (GUI).
To use GenePattern, you have to create an account.
For use with GenePattern notebooks, data from refine.bio needs to be converted to GenePattern
[formats](http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guide).
If you would like to do differential expression but would prefer using GenePattern, follow the instructions below.

### Preparing your refine.bio data for GenePattern

In order to complete your differential expression analysis using [GenePattern](https://cloud.genepattern.org/gp/pages/login.jsf), you will need to have:  
 1) a GCT file    
 2) a CLS file  
You can follow the steps below to create these files from your refine.bio data.

#### Create a GCT file

Convert a gene expression tab separated values (TSV) file provided into a 'gene cluster text' (GCT) file for use in GenePattern notebooks.
In order to create a GCT formatted file from a TSV refine.bio data file, reference the
[`create_gct_file.R` script](https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression/scripts/create_gct_file.R), followed by `-f` argument with the name of the file in your current directory that you would like to convert.
Note: This script requires `optparse` library. If `optparse` library is not installed, this script will install it for you.

##### Example of usage in command line:  
 ```bash
 $ Rscript scripts/create_gct_file.R -f GSE111111.tsv -o outputfilename -r
 ```
Options:     
`-f` :name of the file in your current directory that you would like to convert.    
`-r` :file of the same name as the output will be rewritten (*optional*)       
`-o` :name for the output file (*optional*)       

Optionally you can designate the name of the output file by adding an `-o` argument.
The "GCT" suffix will be added if you do not add it yourself.
Be sure to either have the script and input file in your current working directory, or put type out the full directory path for the script and/or input file. eg. `/users/Bob/Desktop/differential-expression/create_gct_file.R`

#### Create a CLS format file

CLS formatted files tell information regarding the groups or phenotype of the different samples and are necessary for doing gene expression differential analysis using GenePattern's notebooks.
If you've already created a GCT format file from your data, you can create a a CLS format using GenePattern's online
[CLSFileCreator](http://software.broadinstitute.org/cancer/software/genepattern/modules/docs/ClsFileCreator/4)

*Now login into [GenePattern](https://cloud.genepattern.org/gp/pages/login.jsf), select a `Differential Expression` module, and follow the instructions to upload and analyze your newly created GCT and CLS files*

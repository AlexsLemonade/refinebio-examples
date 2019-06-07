# refine.bio Examples: Clustering

[This notebook](https://alexslemonade.github.io/refinebio-examples/clustering/clustering_example.nb.html) uses the Bioconductor R package `ComplexHeatmap` for clustering and creating a heatmap.
In this example, the gene expression matrix is subset to only include genes with high variance.
This set of genes is then used to create a heatmap.

## Requirements and usage

This module requires you to install the following software to run examples yourself:

* [**R**](https://cran.r-project.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)

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

For the example in this module, the gene expression data and sample metadata are stored in a `data/` directory.
If you'd like to adapt an example to include data you've obtained from [refine.bio](https://www.refine.bio/), we recommend placing the files in the `data/` directory and changing the filenames and paths in the notebook to match these files.
We suggest saving plots and results to `plots/` and `results/` directories, respectively, as these are automatically created by the notebook if you move notebooks outside of the GitHub repository structure.

[The clustering R Notebook](https://alexslemonade.github.io/refinebio-examples/clustering/clustering_example.nb.html) could be manipulated to sort by another summary statistic to create a heatmap, depending on your dataset and your research questions.

***
## Clustering data in GenePattern

[GenePattern](https://cloud.genepattern.org/gp/pages/login.jsf) contains ready-made analyses.
For users who are not comfortable with using R Notebooks, the GenePattern modules can be run using a graphics user interface (GUI).
To use GenePattern, you have to create an account.
Here is [their guide](http://software.broadinstitute.org/cancer/software/genepattern/quick-start) we recommend you follow to get started.
For use with GenePattern, data from refine.bio needs to be converted to GenePattern
[formats](http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guide).

### Preparing your refine.bio data for GenePattern

In order to perform cluster analysis on your gene expression data, you must
first convert your TSV data file to GCT format and can do so using our ready-made
[script](https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/create_gct_file.R).

#### Create a GCT file

Convert a gene expression tab separated values (TSV) file provided into a 'gene cluster text' (GCT) file for use in GenePattern.
In order to create a GCT formatted file from a TSV refine.bio data file, download the
[`create_gct_file.R` script](https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/create_gct_file.R).
To use this script you will need to open [`Terminal`](https://macpaw.com/how-to/use-terminal-on-mac) (for Mac) or [`Command Prompt`](https://www.lifewire.com/command-prompt-2625840) (for Windows).
You will need to reference the script like the examples below, followed by `--file` argument with the name of the refine.bio dataset TSV file in your current directory that you would like to convert.
Note: This script requires `optparse` library. If `optparse` library is not installed, this script will install it for you.

**Arguments:**     
`--file`: name of the file in your current directory that you would like to convert.      
`--output`: name for the output file, the ".gct" suffix will be added if you do not add it yourself (*optional*).  
`--rewrite`: file of the same name as the output will be rewritten (*optional*).     

#### Examples of usage in command line:

Below is the basic template for usage of this script.
The following examples will give you an idea of how it works.

```
Rscript scripts/create_gct_file.R \
  --file <PATH TO REFINE.BIO EXPRESSION TSV>
```
To get an idea of how this script and its arguments work, you can run the following examples in order.

**Navigate to the correct directory**  
Depending on where you have put the `refinebio-examples` directory on your computer, you will have to change this path in the code chunk below.
Be sure to either have the script and input file in your current working directory, or type out the full directory path for the script and/or input file. eg. `/users/Bob/Desktop/scripts/create_gct_file.R`
For more guidance on how to navigate directories, we recommend [this tutorial](https://swcarpentry.github.io/shell-novice/02-filedir/index.html).

**Example 1**  
Here we will convert the file `GSE12955.tsv`, which was in our `refinebio-examples/clustering/data` directory into a GCT file.
Following the template above, we will replace the `<PATH TO REFINE.BIO EXPRESSION TSV>` with our file name, `clustering/data/GSE12955.tsv`

 ```bash
Rscript scripts/create_gct_file.R \
  --file clustering/data/GSE12955.tsv
 ```

Note that we have not specified an `--output` name so in this case, the script will use the original name of our file, but replace `.tsv` with `.gct`.
What you should find is that in the same folder `clustering/data/`, you now have a file named `GSE12955.gct`

**Example 2**  
After running the code chunk we showed above, let's try running the same thing a second time:

```bash
Rscript scripts/create_gct_file.R \
 --file clustering/data/GSE12955.tsv
```

What you should see is an error message that says this:

```
clustering/data/GSE12955.gct already exists. Use '--rewrite' option if you want this file to be overwritten.
```

This is telling us that `create_gct_file.R` will not write over an already existing file unless we explicitly tell it to.

**Example 3**  
If we want to save over an already existing file, we need to use the `rewrite` option, just like the error message says.  
Let's try that:

```bash
Rscript scripts/create_gct_file.R \
 --file clustering/data/GSE12955.tsv \
 --rewrite
```

This will rewrite over the file we made in *Example 1* but should give you a message to tell you it is doing so: `Overwriting file named clustering/data/GSE12955.gct`
Also note that for bash commands, a `\` indicates that the command continues on the next line.
Since we put `--rewrite` on the next line, we needed to add a `\` so that it knows that the command continues on the next line.

**Example 4**  
Lastly, if we would like to name the file something besides its original name, we can use the `--output` argument.
Here let's save it directly to the `clustering` folder and call it something different.

```bash
Rscript scripts/create_gct_file.R \
 --file clustering/data/GSE12955.tsv \
 --output clustering/GSE12955_special_name.gct
```

Now you should see a file called `clustering/GSE12955_special_name.gct`.

*After you successfully convert your TSV file into a GCT format, you are ready to login into [GenePattern](https://cloud.genepattern.org/gp/pages/login.jsf), select a `Clustering` module, and follow the instructions to upload and analyze your newly created GCT file*

*In using these data, you agree to our [terms and conditions](https://www.refine.bio/terms)*

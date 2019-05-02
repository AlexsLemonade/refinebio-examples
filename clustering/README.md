# refine.bio Examples: Clustering
This directory contains example workflows of how to filter, cluster and create
a heatmap from data downloaded from [refine.bio](https://www.refine.bio).

***
## Clustering data in R
[This notebook](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering/clustering_example.Rmd)
uses the Bioconductor R package `ComplexHeatmap` for clustering and creating a
heatmap.
In this example, the gene expression matrix is subset to only include genes with high variance.
The high variances set of genes is then used to create a heatmap.
This script could be easily manipulated to sort by another summary statistic to
create a heatmap.  

*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* HeatmapGSE111111.png  

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
Here we will convert the file `GSE71270.tsv`, which was in our `refinebio-examples/differential-expression/data` directory into a GCT file.
Following the template above, we will replace the `<PATH TO REFINE.BIO EXPRESSION TSV>` with our file name, `differential-expression/data/GSE71270.tsv`

 ```bash
Rscript scripts/create_gct_file.R \
  --file differential-expression/data/GSE71270.tsv
 ```

Note that we have not specified an `--output` name so in this case, the script will use the original name of our file, but replace `.tsv` with `.gct`.
What you should find is that in the same folder `differential-expression/data/`, you now have a file named `GSE71270.gct`

**Example 2**  
After running the code chunk we showed above, let's try running the same thing a second time:

```bash
Rscript scripts/create_gct_file.R \
 --file differential-expression/data/GSE71270.tsv
```

What you should see is an error message that says this:

```
differential-expression/data/GSE71270.gct already exists. Use '--rewrite' option if you want this file to be overwritten.
```

This is telling us that `create_gct_file.R` will not write over an already existing file unless we explicitly tell it to.

**Example 3**  
If we want to save over an already existing file, we need to use the `rewrite` option, just like the error message says.  
Let's try that:

```bash
Rscript scripts/create_gct_file.R \
 --file differential-expression/data/GSE71270.tsv \
 --rewrite
```

This will rewrite over the file we made in *Example 1* but should give you a message to tell you it is doing so: `Overwriting file named differential-expression/data/GSE71270.gct`
Also note that for bash commands, a `\` indicates that the command continues on the next line.
Since we put `--rewrite` on the next line, we needed to add a `\` so that it knows that the command continues on the next line.

**Example 4**  
Lastly, if we would like to name the file something besides its original name, we can use the `--output` argument.
Here let's save it directly to the `differential-expression` folder and call it something different.

```bash
Rscript scripts/create_gct_file.R \
 --file differential-expression/data/GSE71270.tsv \
 --output differential-expression/GSE71270_special_name.gct
```

Now you should see a file called `differential-expression/GSE71270_special_name.gct`.

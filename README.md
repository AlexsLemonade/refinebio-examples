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

Each directory in this repository is a training module with example analyses to
follow. See the [list of training modules](#Training modules in this repository)
below for list of the analysis topics.

*Each training module/directory has the following:*

- A`README` that introduces you to the concepts and example analyses in that module.
- Example dataset(s) in the `data/` folder
- An R markdown (`Rmd`) file that you can use in RStudio to run the analysis
- An R notebook (`nb.html`) file that is the resulting output of the Rmd file
but in a prettier format.
- A `results` and/or `plots` folder(s) that contains the output of the analyses.

As you are more comfortable with the examples, we encourage you to apply these
example workflows to your own refine.bio data.
After downloading a refine.bio dataset, you can analyze them in these examples
by copying and pasting your data and metadata TSV files from your refine.bio
download file into the respective `data/` folder for that module.
You'll need to change any directory paths in the notebook to have the name of
your own dataset.
You will likely have to alter other steps of the examples, particularly those
having to deal with the metadata.

### Requirements for using these workflows:

#### RStudio
In order to use the R notebooks, you will need to have [RStudio](https://www.rstudio.com/products/RStudio/)
set up on your computer.
If you are new to RStudio, we recommend going through
[this quick tutorial to RStudio](https://github.com/AlexsLemonade/training-modules/blob/master/intro_to_R_tidyverse/00-rstudio_guide.md)
before getting started.
After you have RStudio set up, you will be able to open the R markdowns (`Rmd`)
and run the analyses.

#### Tidyverse R Packages
The [Tidyverse packages](https://www.tidyverse.org/) are used in every notebook,
so you will need to install this group of packages beforehand (if you haven't
installed them previously.)
To install these packages, enter this command in the R console:
```
install.packages("tidyverse")
```
Any other R packages you need for the example analyses will be installed within
the example as a step.

## Training modules in this repository  

1. [Clustering data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering)  

2. [Annotation using Ensembl IDs](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl-id-convert)  

3. [Differential expression analyses](https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression)  

4. [Ortholog mapping](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ortholog-mapping)  

5. [Quantile normalizing your own data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/normalize-own-data)

6. [Validate differential expression](https://github.com/AlexsLemonade/refinebio-examples/blob/master/validate-differential-expression)

7. [Pathway analyses](https://github.com/AlexsLemonade/refinebio-examples/blob/master/pathway-analysis)


## Examples outside this repository: GenePattern notebooks
Lastly, for users who are more comfortable with Python, or are not comfortable
with using scripts, the [GenePattern notebooks](https://cloud.genepattern.org/)
are written in Python but can be run using a graphics user interface (GUI).
Workflows using GenePattern notebooks contain
[ready-made analyses](http://genepattern-notebook.org/example-notebooks/).
You will need to create a GenePattern login to use these.
For use with GenePattern notebooks, data from refine.bio needs to be converted
to GenePattern
[formats](http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guide).
This repository includes
[scripts](https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/)
for easy conversion of refine.bio data into these formats from command line to
get you started.

#### Converting files to GenePattern compatible formats
Example [GenePattern notebooks](http://genepattern-notebook.org/example-notebooks/)
have numerous ready-made analyses but generally require
[special formats](http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guide).

#### gct format conversion
Convert a gene expression tab separated values (tsv) file provided
into a gene cluster text (gct) file for use in GenePattern notebooks.
In order to create a gct formatted file from a tsv refine.bio data file,
reference the
[`create_gct_file.R` script](https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/create_gct_file.R), followed by `-f` argument with the name
of the file in your current directory that you would like to convert.
Note: This script requires `optparse` library. If `optparse` library is not
installed, this script will install it for you.

##### Example of usage in command line:  
 ```bash
 $ Rscript scripts/create_gct_file.R -f GSE111111.tsv -o outputfilename -r
 ```
 Options:   
`-f` :name of the file in your current directory that you would like to convert.    
`-r` :file of the same name as the output will be rewritten (*optional*)       
`-o` :name for the output file (*optional*)       

Optionally you can designate the name of the output file by adding an `-o`
argument.
The "gct" suffix will be added if you do not add it yourself.
Be sure to either have the script and input file in your current working
directory, or put type out the full directory path for the script and/or input
file. eg `/users/Bob/Desktop/create_gct_file.R`

#### CLS format file creation
CLS formatted files tell information regarding the groups or phenotype of the
different samples and are necessary for doing gene expression differential
analysis using GenePattern's notebooks. If you've already created a gct format
file from your data, you can create a a CLS format using GenePattern's online
[CLSFileCreator](http://software.broadinstitute.org/cancer/software/genepattern/modules/docs/ClsFileCreator/4)

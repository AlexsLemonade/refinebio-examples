# refine.bio Examples Guide
This repository contains example workflows of how to use data downloaded from
[refine.bio](https://www.refine.bio).

## How to use:

If you are comfortable with GitHub, we recommend [cloning](https://help.github.com/articles/cloning-a-repository/)
this repository and following the examples.
You can also use the green button that says "Clone or download" to "Download
ZIP" and then use these notebooks as you please on your own computer, if you
prefer.

In each directory, there is a `README` that explains how to complete the
analyses with the R or GenePattern notebooks.
If you are following the instructions for completing the analyses in R, open the
R markdown (`Rmd`) and follow the instructions.
You will also see the example output files which are generally TSV or PNG files.
All the data used in these examples are deposited into the `data/`
directory and are referenced as such in the R Notebooks.

*For most of the example workflows, two general methods of completing the analyses are discussed:*  

### [R markdown](https://rmarkdown.rstudio.com/articles_intro.html)  
Workflows using R markdown have example analyses that could be applied to other
refine.bio formatted data.
The advantage of using these examples is that they were specifically for use
with refine.bio formatted data and associated metadata.

### [GenePattern notebooks](http://genepattern-notebook.org/example-notebooks/)
Workflows using GenePattern notebooks contain
[ready-made analyses](http://genepattern-notebook.org/example-notebooks/).
For users who are more comfortable with Python, or are not comfortable with
using scripts, the GenePattern notebooks are written in Python but can be
run using a graphics user interface (GUI).
For use with GenePattern notebooks, data from refine.bio needs to be converted
to GenePattern
[formats](http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guide).
This repository includes
[scripts](https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/)
for easy conversion of refine.bio data into these formats from command line.

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
Note: This script requires optparse library. If optparse library is not
installed, this script will install it for you.

##### Example of usage in command line:  
 ```bash
 $ Rscript create_gct_file.R -f GSE111111.tsv -o outputfilename -r
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

# Table of Contents  

1. [Clustering data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering)  

2. [Annotation using Ensembl IDs](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl-id-convert)  

3. [Differential expression analyses](https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression)  

4. [Ortholog mapping](https://github.com/AlexsLemonade/refinebio-examples/blob/master/ortholog-mapping)  

5. [Quantile normalizing your own data](https://github.com/AlexsLemonade/refinebio-examples/blob/master/normalize-own-data)

6. [Validate differential expression](https://github.com/AlexsLemonade/refinebio-examples/blob/master/validate-differential-expression)

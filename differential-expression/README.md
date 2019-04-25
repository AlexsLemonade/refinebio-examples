# refine.bio Examples: Differential Expression  
This directory contains example workflows of how to use identify differentially
expressed genes in data from [refine.bio](https://www.refine.bio).

***
### Differential Expression Analyses in R

[This notebook](https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression/gene_DE.Rmd)
illustrates how to identify genes that are differentially expressed in a dataset
using the `limma` package.
It also creates a volcano plot and Q-Q plot in order to assess the performance
of the linear model.    

*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* Q-Q plot, volcano plot, GSE111111limmaResults.tsv  

***
### Differential Expression Analyses in GenePattern

If you would like to complete your differential expression analysis using
GenePattern, you will need to have a gct and CLS file, so follow these
instructions below if you haven't created those files from your data yet.  

#### Creating Files for Differential Expression in GenePattern

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

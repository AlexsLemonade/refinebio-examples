# refinebio-examples

### This repository contains example workflows of how to use data downloaded from <a href="refine.bio.org"> refine.bio </a>

# Table of Contents

Example workflows using GenePattern 
    Converting files to GenePattern compatible formats

Example workflows in R 
    Clustering data 
    
# Example workflows using GenePattern 
## Converting files to GenePattern compatible formats
<a href="http://genepattern-notebook.org/example-notebooks/"> GenePattern notebooks </a> have numerous ready-made analyses. 

### Converting files to gct format
In order to create a gct formatted file from a tsv refin.bio data file, reference the create_gct_file.R script, followed by the name of the file in your current directory that you would like to convert.  

'$ Rscript create_gct_file.R GSE111111.tsv'

Optionally you can designate the name of the output file by adding an argument following the name of the input file. The "gct" suffix will be added if you do not add it yourself.  Be sure to either have the script and input file in your current working directory, or put type out the full directory path for the script and/or input file. eg "users/Bob/Desktop/create_gct_file.R"

'$ Rscript create_gct_file.R GSE111111.tsv outputname'


# Example workflows in R
Clustering data 




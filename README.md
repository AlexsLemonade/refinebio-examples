# <u>Refinebio Examples Guide: </u> 
This repository contains example workflows of how to use data downloaded 
from <a href="refine.bio.org"> refine.bio </a>

# Table of Contents

### A) Example workflows using GenePattern 
  <a href="#convertfiles"> 1. Converting files to GenePattern compatible formats</a>  
  
### B) Example workflows in R 
  <a href="#cluster">1. Clustering data</a>  
  <a href="#diffexp">2. Expression Differential Analyses</a>  
  <a href="#ensemblannot">3. Annotation using Ensembl IDs</a>  

---
## A) Example workflows using GenePattern 
### 1. Converting files to GenePattern compatible formats 
 <a name="convertfiles"></a> 
<a href="http://genepattern-notebook.org/example-notebooks/"> GenePattern 
notebooks </a> have numerous ready-made analyses. 

### gct format conversion
Convert a gene expression tab separated values (tsv) file provided 
into a gene cluster text (gct) file for use in GenePattern notebooks. 
In order to create a gct formatted file from a tsv refine.bio data file, 
reference the `create_gct_file.R` script, followed by `-f` argument with the name 
of the file in your current directory that you would like to convert. 
Note: This script requires optparse library. If optparse library is not 
installed, this script will install it for you. 

<b>Example of usage in command line:</b>  
 ```bash
 $ Rscript create_gct_file.R -f GSE111111.tsv -o outputfilename -r
 ```

Options:<br></br>
`-f` :name of the file in your current directory that you would like to convert.  
`-r` :file of the same name as the output will be rewritten  
`-o` :name for the output file (optional)  

Optionally you can designate the name of the output file by adding an `-o`
argument. 
The "gct" suffix will be added if you do not add it yourself. 
Be sure to either have the script and input file in your current working 
directory, or put type out the full directory path for the script and/or input
file. eg `/users/Bob/Desktop/create_gct_file.R`

***
## B) Example workflows in R

### 1. Clustering data 
<a name="cluster"></a> 
This script uses the bioconductor R package ComplexHeatmap for clustering and 
creating a heatmap. 
This example also creates a subsetted dataset based on the variance calculated
for each gene/row.
This high variances set of genes is then used to create a heatmap. 

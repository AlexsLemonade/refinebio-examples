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

### CLS format file creation
CLS formatted files tell information regarding the groups or phenotype of the 
different samples and are necessary for doing gene expression differential 
analysis using GenePattern's notebooks. If you've already created a gct format 
file from your data, you can create a a CLS format by either using R or 
GenePattern's online 
<a href="http://genepattern.broadinstitute.org/gp/pages/index.jsf?lsid=urn:lsid:broad.mit.edu:cancer.software.genepattern.module.visualizer:00261:3">CLsFileCreator</a>. 
Both methods require you to have a already created gct file.
To create a CLS file in R: 

```r
ClsFileCreator.result <- run.analysis(gp, "urn:lsid:broad.mit.edu:cancer.software.genepattern.module.visualizer:00261:3", input.file="GSE11111.gct")
```
---
### 2. Clustering data in GenePattern
 <a name="gpcluster"></a> 
In order to perform cluster analysis on your gene expression data, you must 
first convert your data to <a href="#convertfiles">gct format</a>. Then you can 
use one of GenePattern's example notebooks

<b> Hierarchical Clustering Notebooks: </b>  
\t    a) <a href="https://notebook.genepattern.org/services/sharing/notebooks/23/preview/">
with microarray data</a>  
\t    b) <a href="https://notebook.genepattern.org/services/sharing/notebooks/24/preview/">
with RNA-Seq Data</a>  
      
k-Means Clustering Notebook</a>  
<a href="https://notebook.genepattern.org/services/sharing/notebooks/25/preview/">
  
Negative Matrix Factorization Clustering Notebook</a>  

<a href="https://notebook.genepattern.org/services/sharing/notebooks/26/preview/">
### 3. Expression Differential Analyses in GenePattern
 <a name="gpdiffexp"></a> 
 <a href="#convertfiles">previous section</a> if you haven't created those files
 For this notebook you will need to have a gct and CLS file, so see the 
 from your data yet. 
 <a href="https://notebook.genepattern.org/services/sharing/notebooks/22/preview/">
 Differential Gene Expression Notebook </a>
 
***
## B) Example workflows in R
### 1. Clustering data in R

<a name="cluster"></a> 
This <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering_example.html">
script </a> uses the bioconductor R package `ComplexHeatmap` for clustering and 
creating a heatmap. 
This high variances set of genes is then used to create a heatmap. 
This example also creates a subsetted dataset based on the variance calculated
for each gene/row.
in a dataset using the `limma` package.
script </a> illustrates how to identify genes that are differentially expressed 
This  <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/gene_DE.html"> 
<a name="diffexp"></a> 
### 2. Expression Differential Analyses in R

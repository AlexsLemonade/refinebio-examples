# <u>Refinebio Examples Guide: </u>
This repository contains example workflows of how to use data downloaded
from <a href="refine.bio.org"> refine.bio </a>

# Table of Contents

### A) Example workflows using GenePattern
  1. <a href="#convertfiles">Converting files to GenePattern compatible formats</a>  
  2. <a href="#gpcluster">Clustering data in GenePattern</a>  
  3. <a href="#gpdiffexp">Expression Differential Analyses in GenePattern

### B) Example workflows in R  
  1. <a href="#cluster">Clustering data in R</a>  
  2. <a href="#ensembl">Annotation using Ensembl IDs in R</a>  
  3. <a href="#diffexp">Expression Differential Analyses in R</a>   
---
## A) Example workflows using GenePattern

For a general introduction in how to use the notebooks found on GenePattern,
go <a href="http://genepattern-notebook.org/public-notebooks/">here</a>.

### 1. Converting files to GenePattern compatible formats
 <a name="convertfiles"></a>
Example <a href="http://genepattern-notebook.org/example-notebooks/"> GenePattern
notebooks </a> have numerous ready-made analyses but generally require special
<a href="http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guideformats">
formats</a>.

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

### CLS format file creation
CLS formatted files tell information regarding the groups or phenotype of the
different samples and are necessary for doing gene expression differential
analysis using GenePattern's notebooks. If you've already created a gct format
file from your data, you can create a a CLS format using GenePattern's online
<a href="http://genepattern.broadinstitute.org/gp/pages/index.jsf?lsid=urn:lsid:broad.mit.edu:cancer.software.genepattern.module.visualizer:00261:3">CLsFileCreator</a>.

---
### 2. Clustering data in GenePattern
 <a name="gpcluster"></a>
In order to perform cluster analysis on your gene expression data, you must
first convert your data to <a href="#convertfiles">gct format</a>. Then you can
use one of GenePattern's example notebooks

<b> Hierarchical Clustering Notebooks: </b>  
    a) <a href="https://notebook.genepattern.org/services/sharing/notebooks/23/preview/">
with microarray data</a>  
    b) <a href="https://notebook.genepattern.org/services/sharing/notebooks/24/preview/">
with RNA-Seq Data</a>    

<a href="https://notebook.genepattern.org/services/sharing/notebooks/25/preview/">
k-Means Clustering Notebook </a>      


<a href="https://notebook.genepattern.org/services/sharing/notebooks/26/preview/">
Negative Matrix Factorization Clustering Notebook</a>      

---    

### 3. Expression Differential Analyses in GenePattern
 <a name="gpdiffexp"></a>
 For this Gene Pattern notebook you will need to have a gct and CLS file, so see the
 <a href="#convertfiles">previous section</a> if you haven't created those files
 from your data yet.  
 <a href="https://notebook.genepattern.org/services/sharing/notebooks/22/preview/">
 Differential Gene Expression Notebook </a>

***
## B) Example workflows in R
### 1. Clustering data in R
<a name="cluster"></a>
This <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering_example.html">
script </a> uses the Bioconductor R package `ComplexHeatmap` for clustering and
creating a heatmap.
This example also creates a subsetted dataset based on the variance calculated
for each gene/row.
The high variances set of genes is then used to create a heatmap.
This script could be easily manipulated to sort by another summary statistic to
create a heatmap.  
*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* HeatmapGSE111111.png  

### 2. Annotation using Ensembl IDs in R
<a name="ensembl"></a>
This  <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl_id_convert.html">
script </a> illustrates how to obtain annotation for data based on their Ensembl
IDs using `AnnotationDb` packages from Bioconductor.
The script also explains how it can be changed for use with different species
and/or different types of annotation.
*Input:* GSE111111.tsv  
*Output:* GSE111111wGeneSymbols.tsv  

### 3. Expression Differential Analyses in R
<a name="diffexp"></a>
This  <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/gene_DE.html">
script </a> illustrates how to identify genes that are differentially expressed
in a dataset using the `limma` package.
It also creates a volcano plot and Q-Q plot in order to assess the performance
of the linear model.    
*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* Q-Q plot, volcano plot, GSE111111limmaResults.tsv  

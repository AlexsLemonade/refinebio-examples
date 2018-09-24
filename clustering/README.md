# <u>Refinebio Examples: Clustering </u>
This directory contains example workflows of how to filter, cluster and create
a heatmap from data downloaded from <a href="refine.bio.org"> refine.bio </a>

***
### Clustering data in R
This <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering_example.html">
notebook </a> uses the Bioconductor R package `ComplexHeatmap` for clustering and
creating a heatmap.
This example also creates a subsetted dataset based on the variance calculated
for each gene/row.
The high variances set of genes is then used to create a heatmap.
This script could be easily manipulated to sort by another summary statistic to
create a heatmap.  

*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* HeatmapGSE111111.png  

***
### Clustering data in GenePattern

For a general introduction in how to use the notebooks found on GenePattern,
go <a href="http://genepattern-notebook.org/public-notebooks/">here</a>.
In order to perform cluster analysis on your gene expression data, you must
first convert your data to gct format and can do so using our ready-made <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/create_gct_file.R">
script</a> and the instructions below. 

Then you can use one of <b>GenePattern's example clustering notebooks</b>:

<a href="https://notebook.genepattern.org/services/sharing/notebooks/23/preview/">
Hierarchical Clustering with microarray data</a>

<a href="https://notebook.genepattern.org/services/sharing/notebooks/24/preview/">
Hierarchical Clustering with RNA-Seq Data</a>    

<a href="https://notebook.genepattern.org/services/sharing/notebooks/25/preview/">
k-Means Clustering Notebook </a>      

<a href="https://notebook.genepattern.org/services/sharing/notebooks/26/preview/">
Negative Matrix Factorization Clustering Notebook</a>   

#### Converting data to gct format conversion
Convert a gene expression tab separated values (tsv) file provided
into a gene cluster text (gct) file for use in GenePattern notebooks.
In order to create a gct formatted file from a tsv refine.bio data file,
reference the <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/create_gct_file.R">
`create_gct_file.R` script </a>, followed by `-f` argument with the name
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
file. eg `/users/Bob/Desktop/create_gct_file.R` or if you are using this script 
from its GitHub repository `~/refinebio-examples/scripts/create_gct.file`.

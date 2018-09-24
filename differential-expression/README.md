# <u>Refinebio Examples: Differential Expression </u>
This directory contains example workflows of how to use identify differentially
expressed genes in data from <a href="refine.bio.org"> refine.bio </a>

***
### Differential Expression Analyses in R

This  <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression/gene_DE.html">
notebook </a> illustrates how to identify genes that are differentially expressed
in a dataset using the `limma` package.
It also creates a volcano plot and Q-Q plot in order to assess the performance
of the linear model.    

*Input:* GSE111111.tsv, GSE111111_metadata.tsv    
*Output:* Q-Q plot, volcano plot, GSE111111limmaResults.tsv  

***
### Differential Expression Analyses in GenePattern

For a general introduction in how to use the notebooks found on GenePattern,
go <a href="http://genepattern-notebook.org/public-notebooks/">here</a>. 
For this <a href="https://notebook.genepattern.org/services/sharing/notebooks/22/preview/">
Gene Pattern notebook </a> you will need to have a gct and CLS file, so follow 
these instructions if you haven't created those files from your data yet.  
 
#### Converting files to GenePattern compatible formats
Example <a href="http://genepattern-notebook.org/example-notebooks/"> GenePattern
notebooks </a> have numerous ready-made analyses but generally require special
<a href="http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guideformats">
formats</a>.

#### gct format conversion
Convert a gene expression tab separated values (tsv) file provided
into a gene cluster text (gct) file for use in GenePattern notebooks.
In order to create a gct formatted file from a tsv refine.bio data file,
reference the <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/create_gct_file.R">
`create_gct_file.R` script</a>, followed by `-f` argument with the name
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

#### CLS format file creation
CLS formatted files tell information regarding the groups or phenotype of the
different samples and are necessary for doing gene expression differential
analysis using GenePattern's notebooks. If you've already created a gct format
file from your data, you can create a a CLS format using GenePattern's online
<a href="http://genepattern.broadinstitute.org/gp/pages/index.jsf?lsid=urn:lsid:broad.mit.edu:cancer.software.genepattern.module.visualizer:00261:3">CLsFileCreator</a>.

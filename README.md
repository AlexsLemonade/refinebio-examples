# <u>Refinebio Examples Guide: </u>
This repository contains example workflows of how to use data downloaded from 
<a href="refine.bio.org"> refine.bio </a>

*For most of the example workflows, two general methods of completing the analyses are discussed:*  

##### Workflows using <a href="https://rmarkdown.rstudio.com/articles_intro.html">R notebooks</a>  
...have the advantage of being written specificially for use with refine.bio data 
formatted data and metadata. 

##### Workflows using<a href="http://genepattern-notebook.org/example-notebooks/"> GenePattern notebooks</a>  
...contain <a href="http://genepattern-notebook.org/example-notebooks/"> 
ready-made analyses</a>.
For users who are more comfortable with Python, or are not comfortable with 
using scripts, the GenePattern notebooks are written in Python but can be 
ran using a graphics user interface (gui).
In order to use GenePattern notebooks, data from refinebio needs to be converted 
to GenePattern <a href="http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guideformats">
formats </a>. 
This repository includes <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts">
scripts </a> for easy conversion of refine.bio data into these formats from 
command line.

In each directory, there is a README that explains how to complete the analyses
with the R or GenePattern notebooks. You will also see the example output files
which are generally tsv or png files.
All the data used in these examples are deposited into the `refinebio-examples/data` 
directory and are referenced as such in the R Notebooks.

# Table of Contents

  1. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering">
  Clustering data </a>  
  
  2. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl-id-convert"> 
  Annotation using Ensembl IDs </a>  
  
  3. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression">
  Expression Differential Analyses </a> 
  
  4. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression">
  Ortholog Mapping </a>  
  
  5. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts">
  Other scripts </a>  

# <u>refine.bio Examples Guide: </u>
This repository contains example workflows of how to use data downloaded from 
<a href="refine.bio.org"> refine.bio</a>.

*For most of the example workflows, two general methods of completing the analyses are discussed:*  

### <a href="https://rmarkdown.rstudio.com/articles_intro.html">R notebooks</a>  
Workflows using R notebooks have example analyses that could be applied to other refine.bio formatted data. The advantage of using 
these notebooks is that they were specificially for use with refine.bio formatted data and associated metadata. 

### <a href="http://genepattern-notebook.org/example-notebooks/">GenePattern notebooks</a>  
Workflows using GenePattern notebooks contain <a href="http://genepattern-notebook.org/example-notebooks/"> 
ready-made analyses</a>.
For users who are more comfortable with Python, or are not comfortable with 
using scripts, the GenePattern notebooks are written in Python but can be 
run using a graphics user interface (GUI).
In order to use GenePattern notebooks, data from refine.bio needs to be converted 
to GenePattern <a href="http://software.broadinstitute.org/cancer/software/genepattern/file-formats-guide">
formats</a>. 
This repository includes <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts/">
scripts </a> for easy conversion of refine.bio data into these formats from 
command line.

#### How to use: 

If you are comfortable with GitHub, we recommend [cloning](https://help.github.com/articles/cloning-a-repository/)
this repository and following the examples. 
However, if you are less comfortable with GitHub, you can also use the green button that says 
"Clone or download" to "Download ZIP" and then use these notebooks as you please 
on your own computer. Make sure you are on the master branch. Which is indicated toward the top 
of the page, in a gray button that says "Button:".

In each directory, there is a `README` that explains how to complete the analyses
with the R or GenePattern notebooks. If you are following the instructions for completing 
the analyses in R, open the R markdown (`Rmd`) and follow the instructions. 
You will also see the example output files which are generally tsv or png files.
All the data used in these examples are deposited into the `data/` 
directory and are referenced as such in the R Notebooks.

# Table of Contents

1. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/clustering">Clustering data </a>  
  
2. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/ensembl-id-convert"> Annotation using Ensembl IDs </a>  
  
3. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression">Expression Differential Analyses </a> 
  
4. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/differential-expression">Ortholog Mapping </a>  
  
5. <a href="https://github.com/AlexsLemonade/refinebio-examples/blob/master/scripts">Other scripts </a>  


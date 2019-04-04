# __refine.bio Examples: Differential Expression__
This directory contains example workflows of how to use identify differentially
expressed genes in data from [refine.bio](refine.bio.org).

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

For a general introduction in how to use the notebooks found on GenePattern,
go [here](http://genepattern-notebook.org/public-notebooks/).
For this [Gene Pattern notebook](https://notebook.genepattern.org/services/sharing/notebooks/22/preview/)
you will need to have a gct and CLS file, so follow
[these instructions](https://github.com/AlexsLemonade/refinebio-examples/blob/master) if you haven't created those files from your data yet.  

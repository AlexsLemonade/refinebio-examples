# Pathway analysis

## QuSAGE

In this module, we'll demonstrate how to perform pathway analysis using
Quantitative Set Analysis of Gene Expression (QuSAGE) 
([Yaari et al. _NAR_. 2013.](https://doi.org/10.1093/nar/gkt660)).
QuSAGE, implemented in the [`qusage` bioconductor package](https://bioconductor.org/packages/release/bioc/html/qusage.html),
has some nice features:

* It takes into account inter-gene correlation (a source of type I error).
* It returns more information than just a p-value. 
That's useful for analyses you might want to perform downstream.
* Built-in visualization functionality.

We recommend taking a look at the original publication (Yaari et al.) and 
the R package documentation to learn more.

## Gene sets

`qusage` allows you to read in gene sets that are in the [GMT format](http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29).

[MSigDB](http://software.broadinstitute.org/gsea/msigdb) offers genesets in this format.
[Curated gene sets](http://software.broadinstitute.org/gsea/msigdb/collections.jsp#C2) 
such as [KEGG](https://www.genome.jp/kegg/) are a good starting point for any pathway analysis.

If you're interested in a smaller set of pathways/gene sets that condense down 
some of the overlap between gene sets, you might check out the 
[Hallmark gene set collection](http://software.broadinstitute.org/gsea/msigdb/collection_details.jsp#H).

You can download gene sets from the MSigDB web interface. 
Note that you must register with MSigDB to do so.
We do not include the GMT files in our GitHub repository. 
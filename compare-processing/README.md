**Jaclyn Taroni for ALSF CCDL 2018**

## Background and objective

The [refine.bio project](https://github.com/AlexsLemonade/refinebio) is a continuously growing compendium of genome-scale gene expression data from multiple species. 
Because it is comprised of many different individual studies and new samples are added to our source repositories all the time, we've selected approaches for data processing/normalization that can be applied to individual samples, rather than whole experiments, where possible.
We'll perform additional downstream processing steps (e.g., quantile normalization; more on that below) to make samples from different experiments more comparable.

In refine.bio, we prefer to process the _raw data_ using our selected pipelines.
This is not always possible; sometimes the raw data is unavailable at a source repository or the raw data is in a format that we can not process. 
In these cases, we use submitter-supplied _processed data_ from the source repositories, but we often need to convert the gene identifiers to the Ensembl gene ids that we use in the rest of our system.

In this small project, we'll explore the same data set ([`GSE39842`](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE39842)) processed three ways:

* **Submitter-processed data** (in this case, RMA) that is then put through our gene identifier conversion pipeline.
* **SCANfast-processed data from refine.bio**. We use the `SCANfast` function from the [SCAN.UPC](https://bioconductor.org/packages/release/bioc/html/SCAN.UPC.html) to process Affymetrix array data from raw because it allows us to process individual samples.
* **Quantile normalized SCANfast-processed data from refine.bio**. We generate a target/reference distribution for each organism using the Affymetrix platform with the largest number of samples for that organism (using the [`preprocessCore`](https://bioconductor.org/packages/release/bioc/html/preprocessCore.html) package) and use that as the target distribution for each sample when delivering the samples a user selects for download.

Ideally, all three processing methods would show similar overall data structures and trends. 
We'll specifically evaluate the following:

* Overall data structure -- what does hierarchical clustering look like?
* Differential expression analysis
* Pathway analysis--overrepresentation analysis--using the genes identified as "interesting" with differential expression analysis

## Data

This dataset contains two genotypes (wildtype vs. transgenic/dnHIF1a-expressing) and two time points (unamputated vs. 7 days post-amputation).

* The RMA normalized data that has been through our conversion pipeline can be found at [`data/GSE39842_RMA_converted.tsv`](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/data/GSE39842_RMA_converted.tsv)
* The SCANfast processed data is available at [`data/e3b5d201-449b-4512-8fe4-1c997c12e676/E-GEOD-39842.tsv`](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/data/e3b5d201-449b-4512-8fe4-1c997c12e676/E-GEOD-39842.tsv)
* The quantile normalized data is [`data/95613466-25bf-4f3d-b2c3-da2d0eb902fa/E-GEOD-39842/E-GEOD-39842.tsv`](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/data/95613466-25bf-4f3d-b2c3-da2d0eb902fa/E-GEOD-39842/E-GEOD-39842.tsv)

Citation for `GSE39842`:
> Jopling C, Suñé G, Faucherre A, Fabregat C et al. Hypoxia induces myocardial regeneration in zebrafish. Circulation 2012 Dec 18;126(25):3017-27. PMID: [23151342](https://www.ncbi.nlm.nih.gov/pubmed/23151342)

## Requirements and pipeline

We provide a Docker container that has all the requirements for these analyses, which can be obtained like so:

```
docker pull jtaroni/refinebio-examples:compare-processing
```

For more information, see the [`Dockerfile`](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/docker/Dockerfile).

You can run the entire pipeline, with the exception of generating the Venn diagrams in `5-summarize_results`, like so:

```bash
bash run_pipeline.sh
```

## Results

### High variance genes

To take a high level look at _data structure_, we calculate variance for each gene and then only retain genes in the top 10%. This matrix is then plotted with [`ComplexHeatmap`](http://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html) which performs hierarchical clustering by default.

#### RMA heatmap

![rma-heatmap](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/plots/RMA_GSE39842_high_variance_heatmap.png)

#### SCANfast heatmap

![scan-heatmap](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/plots/SCANfast_GSE39842_high_variance_heatmap.png)

#### QN heatmap

![qn-heatmap](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/plots/QN_GSE39842_high_variance_heatmap.png)

We can see that the overall structure looks very similar, with samples grouping first by genotype and then by timepoint in each case.

This, however, does not guarantee that the same genes will be in the clustered matrix in each case. 
To explore this, we plotted the overlap between the different processing methods' high variance genes.

![variance-venn](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/plots/high_variance_genes_venn.png)

We can see that the majority of high variance genes are shared between all three methods. 
The QN list seems to be "more similar" to both the SCANfast and RMA lists than they are to each other.

### Differential expression analysis

We used [`limma`](http://bioconductor.org/packages/release/bioc/html/limma.html) to do differential expression analysis and designed the contrast matrix to address the following:

* which genes respond to amputation in wildtype
* which genes respond to amputation in transgenic (dnHIF1a-expressing)
* which genes respond _differently_ in transgenics compared to wildtype
* which genes are different between wildtype and transgenics pre-amputation

In keeping with our interpretation of the analyses conducted by the authors of the original publication (Jopling, et al.), we considered genes that responded to amputation in wildtype, did not respond in transgenic animals, and are not different between genotypes pre-amputation.
These are the lists used to make the following Venn diagram:

![diff-venn](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/plots/diff_exp_genes_venn.png)

Again, the majority of differentially expressed genes pass the significance threshold in all three methods.
A number of the genes identified in the original publication (e.g., _jak2a_, _thbs4b_) are significant in all three cases.

### WebGestalt analysis

We used the differentially expressed genes described above as an "interesting" gene list input into [`WebGestaltR`](https://cran.r-project.org/package=WebGestaltR).
Enriched gene sets were used to generate the Venn diagram below:

![pathway-venn](https://github.com/AlexsLemonade/refinebio-examples/blob/master/compare-processing/plots/significant_genesets_venn.png)

The majority of pathways identified are related to RNA processing.
To our knowledge, the authors of the original publication did not perform a formal pathway analysis, so we can not compare our results to theirs.
There are many more pathways identified as significant in the SCANfast-processed data.

## Summary

Based on these analyses, our prior experience with these methods, and the [publication that introduced the SCAN methodology](http://doi.org/10.1016/j.ygeno.2012.08.003), SCANfast likely has increased sensitivity over RMA. 
Because the quantile normalized data is first processed with SCANfast, we would expect these two to show similar patterns and that quantile normalization would "dampen" the biological signal somewhat.
(In using quantile normalization, we assume that the only differences between samples are of a technical nature and that is certainly not always the case!)
These analyses are consistent with our expectations.

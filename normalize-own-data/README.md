# refine.bio Examples: Quantile normalize your own data  

This directory contains an example workflow of how to quantile normalize your own dataset to make it more comparable to data you obtain from [refine.bio](https://www.refine.bio).

## Background

Datasets that are downloaded from the web interface of [refine.bio](http://www.refine.bio) are [quantile normalized](https://en.wikipedia.org/wiki/Quantile_normalization) because we allow users to aggregate multiple platforms (e.g., microarray chips) and even multiple technologies.
Quantile normalization (QN) ensures that the underlying distributions of samples are the same.

If you are interested in comparing your own data to data you have downloaded from the refine.bio website, you may wish to quantile normalize it using the reference distribution we've used in refine.bio.

You can read more about the reference distribution and how it is generated in the [quantile normalization section](http://docs.refine.bio/en/latest/main_text.html#quantile-normalization) of our [documentation](http://docs.refine.bio/en/latest/).

In this [example notebook](https://alexslemonade.github.io/refinebio-examples/normalize-own-data/quantile_normalize_own_data.nb.html), we demonstrate how to obtain the reference distribution from the refine.bio API and apply it to your own data in R.
The R package we use for quantile normalization ([`preprocessCore`](https://bioconductor.org/packages/release/bioc/html/preprocessCore.html)) expects a matrix where samples are columns and genes are rows.
Any tabular format that can be read into R and follows this format (or can be easily transposed) is appropriate.
In our example, we use a TSV file where samples are columns and genes are rows.

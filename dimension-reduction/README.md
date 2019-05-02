# refine.bio Examples: Dimension Reduction

In this module, we'll demonstrate how to use dimension reduction techniques with
gene expression data obtained from [refine.bio](https://www.refine.bio/).

Dimension reduction is useful for examining overall patterns in your data.
Reducing your data to two dimensions allows you to more easily plot your samples
so you can observe how they relate as a whole or which samples may group
together.

**Example Workflow R Notebooks**

* [Dimension Reduction with PCA](https://alexslemonade.github.io/refinebio-examples/dimension-reduction/pca_example.nb.html)
* [Dimension Reduction with UMAP](https://alexslemonade.github.io/refinebio-examples/dimension-reduction/umap_example.nb.html)

## Requirements and usage

This module requires you to install the following software to run examples yourself:

* [**R**](https://cran.r-project.org/)
* [**RStudio**](https://www.rstudio.com/products/RStudio/) for working with [R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html).
* [**Bioconductor**](https://bioconductor.org/install/)
* [**tidyverse**](https://www.tidyverse.org/)

These requirements can be installed by following the instructions at the links above.
The example R Notebooks are designed to check if additional required packages are installed and will install them if they are not.

#### RStudio

We have prepared [a quick guide to RStudio](https://github.com/AlexsLemonade/training-modules/blob/master/intro_to_R_tidyverse/00-rstudio_guide.md) as part of our training content that you may find helpful if you're getting started with RStudio for the first time.

Note that the first time you open RStudio, you should select a CRAN mirror.
You can do so by clicking `Tools` > `Global Options` > `Packages` and selecting a CRAN mirror near you with the `Change` button.

You can install the additional requirements (e.g., tidyverse) through RStudio.

#### Obtaining the R Notebooks

To run the examples yourself, you will need to [clone](https://help.github.com/articles/cloning-a-repository/) or [download](https://stackoverflow.com/a/6466993) this repository: https://github.com/AlexsLemonade/refinebio-examples

#### Interacting with R Notebooks

You can open an R Notebook by opening the `.Rmd` file in RStudio.
Note that working with R Notebooks requires certain R packages, but RStudio should prompt you to download them the first time you open one.
This will allow you to modify and run the R code chunks.
Chunks that have already been included in an example can be run by clicking the green play button in the top right corner of the chunk or by using **Ctrl + Shift + Enter** (**Cmd + Shift + Enter** on a Mac).
See [this guide using to R Notebooks](https://bookdown.org/yihui/rmarkdown/notebook.html#using-notebooks) for more information about inserting and executing code chunks.

#### Using your own data

For all the examples in this module, the gene expression data and sample metadata are stored in a `data/` directory.
If you'd like to adapt an example to include data you've obtained from [refine.bio](https://www.refine.bio/), we recommend placing the files in the `data/` directory and changing the filenames and paths in the notebooks to match these files.
We suggest saving plots and results to `plots/` and `results/` directories, respectively, as these are automatically created by the notebooks if you move notebooks outside of the GitHub repository structure.

## About Principal Components Analysis (PCA)

[This PCA example notebook](./pca_example.nb.html) illustrates how to perform PCA and plot the scores using ggplot2.
PCA is a commonly used dimension reduction technique that uses orthogonal
transformation.  

Recommended articles on PCA:   
- [Overall explanation by Matt Brems](https://towardsdatascience.com/a-one-stop-shop-for-principal-component-analysis-5582fb7e0a9c)  
- [A visual explanation of PCA](http://setosa.io/ev/principal-component-analysis/)  

## About Uniform Manifold Approximation and Projection (UMAP)

[This UMAP example notebook](./umap_example.nb.html) illustrates how to perform Uniform Manifold Approximation and
Projection and plot the coordinates using ggplot2.
UMAP does require more dimensions than PCA, though, so if you have a smaller
dataset (less than 20) and you obtain errors, you may not be able to run UMAP
for your dataset.

Recommended articles on UMAP:   
- [How UMAP works with visuals](https://umap-learn.readthedocs.io/en/latest/how_umap_works.html)  
- [Original paper on UMAP](https://arxiv.org/abs/1802.03426) by McGinnes, Healy & Melville.  

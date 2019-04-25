# Dimension Reduction

In this module, we'll demonstrate how to use dimension reduction techniques with
gene expression data obtained from [refine.bio](https://www.refine.bio/).
Dimension reduction is useful for examining overall patterns of your data.
Reducing your data to two dimensions allows you to more easily plot your samples
so you can observe global and local patterns in your dataset.

## Principal Components Analysis (PCA)

This notebook illustrates how to perform PCA and plot the scores using ggplot2.
PCA is a commonly used, more straight-forward dimension reduction technique that
uses orthogonal transformation.  

Recommended articles on PCA:   
- [Overall Explanation by Matt Brems](https://towardsdatascience.com/a-one-stop-shop-for-principal-component-analysis-5582fb7e0a9c)  
- [A visual explanation of PCA](http://setosa.io/ev/principal-component-analysis/)  

## Uniform Manifold Approximation and Projection (UMAP)

This notebook illustrates how to perform Uniform Manifold Approximation and
Projection and plot the coordinates using ggplot2.
UMAP does require more dimensions than PCA, though, so if you have a smaller
dataset (less than 20) and you obtain errors, you may not be able to run UMAP
for your dataset.

Recommended articles on UMAP:   
- [How UMAP works with visuals](https://umap-learn.readthedocs.io/en/latest/how_umap_works.html)  
- [Original paper on UMAP](https://arxiv.org/abs/1802.03426) by McGinnes, Healy & Melville.  

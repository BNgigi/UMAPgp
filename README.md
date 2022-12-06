# UMAPgp

## Introduction

UMAP preserves local structure by grouping neighboring data points together which provides an informative visualization of heterogeneity in a dataset. However, if one wants to understand the relationship between clusters of data points, this can be troublesome since UMAP does not warrant that inter-cluster distances are preserved correctly. To address the shortcomings, we have created a function, UMAPgp, and developed its equivalent package which when applied preserves the global structure of manifold learning algorithms for small datasets. It also preservs the global structure of manifold learning algorithms without losing the finer details.The package that will be developed is suited to process small data with approximately 1,000 data points.

## Installation of the package UMAPgp

```{r}
library(devtools)
install_github("BNgigi/UMAPgp")
library(UMAPgp)
```

## Link to the pkgdown site

## Link to the package vignette

## Example Code Block
```{r}
# Loading the dataset and performing umapgp
library(readr)
birds <- read.csv("/Users/eva/Downloads/birds.csv") 
umapgp(var="type", data=birds)
```


Session 2: Data Manipulation & Visualization -- Solutions
================
Written by Amy Campbell, -, -, and - in direct reference to exercises developed by Shweta Ramdas, Binglan Li, and Matt Paul for PennPrep 2019

Loading Installed Packages
--------------------------

``` r
library("dplyr")
library("ggplot2")
library("plyr")
```

Loading the Parkinsons' Disease gene expression data (Courtesy of Shweta Ramdas )
---------------------------------------------------------------------------------

Let's first have a look at our data.

``` r
# Load in Parkinsons Disease dataset 
# Note: sep='\t' specifies tab-delimited file, and stringsAsFactors tells 
# R to encode categorical variables as 'factors' -- more on that later. 
expression = read.table("expressionpd.txt", sep = '\t', stringsAsFactors=TRUE)
# How big is it? 
print(dim(expression))
```

    ## [1]    10 19101

``` r
# dimensions: [10  19101] -- 10 rows and 19101 columns
```

With 19101 variables, we should start by taking a look at the first few column names rather than hitting 'View()'.

``` r
print(head(colnames(expression)))
```

    ## [1] "sex"          "samples"      "EEF1A1"       "ILMN_1651221"
    ## [5] "RPS28"        "IPO13"

Let's take a look at the two categorical variables built into the dataset:

``` r
# Encodes whether a sample is from a person with/without Parkinsons' Disease
print(head(expression$samples))
```

    ## [1] pd   pd   pd   pd   pd   ctrl
    ## Levels: ctrl pd

``` r
# Encodes whether a sample is from a male/female individual 
print(head(expression$sex))
```

    ## [1] f f f f f f
    ## Levels: f m

``` r
# How many observations do we have of each variable? 
print(plyr::count(expression, vars=c("sex", "samples")))
```

    ##   sex samples freq
    ## 1   f    ctrl    1
    ## 2   f      pd    5
    ## 3   m    ctrl    4

Basic Visualization
-------------------

Let's use PARK7 as an example of a gene with known associations with Parkinsons' disease. Let's compare this gene's expression level in control subjects vs. subjects with Parkinsons':

``` r
ggplot2::ggplot(expression, aes(x= samples, y=PARK7, fill=samples)) + geom_boxplot() + labs(title="PARK7 Gene Expression in Parkinsons Disease Samples vs. Controls")
```

![](Practicum_code_files/figure-markdown_github/unnamed-chunk-5-1.png)

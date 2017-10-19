---
title: "Readme.md"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## GitHub Documents

This is an readme file for DataScience Cleaning Data Week4 programming assignment.

# File contents
run_analysis.R: contains the script to download the wearable dataset from
course website and combine the subject, label to the original dataset and provide
the summary information for the std and mean of the measurements.

Cookbook.md: contains the markdown file for the label's descriptive meaning for the dataset


## Including Code

You can include R code in the document as follows:

```{r run_analysis.R}
summary(tidy_ds)
```



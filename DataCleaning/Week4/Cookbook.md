---
title: "Cookbook for the programming assignment week 4"
author: "Jane"
date: "October 18, 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Wearable dataset label convention

The wearable dataset orginal dataset contains training and testing dataset. The programming assignment
contains both dataset together and provide the summary information on the measurement of mean() and std().

## Column descriptions: 

1. SubjectID: The subject (person) who perform the wearable measurement, from 1:30
2. Activity_Label: The activities the person performs during the measurement. Including walking, walking upstairs, walking downstairs, sitting, standing, and laying
3. All other columns are the average of the original measurements.

## Data after running the function
 The scripts return a list consisting of two dataset.
 The first dataset is called ds_wearable. It is the data after performing the step 1 to 4 
 The 2nd dataset is called tidy_ds. It is the data after summarise the data for each subject and label.
 Here are the dimension of dataset after running the function run_analysis:
  
 # dim(tidy_ds)
 [1] 180  67
 
 # dim(ds_wearable)
 [1] 10299    68
 
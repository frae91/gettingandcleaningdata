# Code Book

This document describes the code "run_analysis.R".

## Variables

### fileUrl
The given url where the data set will come from.

### Trainings Tables
Tables read from the UCI HAR data set known as "train" and prefixes include: "X", "y", and "subject."

Examples:
* xTrain
* yTrain
* trainingSubjects

### Tests Tables
Tables read from the UCI HAR data set known as "test" and prefixes include: "X", "y", and "subject".

Examples:
* xTest
* yTest
* testSubjects

## Downloading and loading data

* Downloads the UCI HAR data set zip file if it doesn't exist
* Reads the activity labels to `activityLabels`
* Reads the column names of data  (features) to `features`
* Merges the test `data.frame` to `mergeTest`
* Merges the training `data.frame` to `mergeTest`

## Manipulating data

* Merges test data and training data to `setAll`
* Indentifies the mean and sd columns (plus Activity and Subject) to `mean_and_sd`
* Extracts a new `data.frame` called `setMeanAndSd`)with only those columns from `mean_and_sd`.
* Name the activities in the data set using `activityLabels`
* Summarizes `setMeanAndSd` calculating the average for each column for each activity/subject pair to `tidySet`.

## Writing final data
Creates the output `tidySet` data frame to the output file named `tidyset.txt`
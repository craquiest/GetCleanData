# GetCleanData
This repo is the result of the "Getting and Cleaning Data" course project,
applied to UCI Human Activity Recognition Data Set.
The goal of this project is to provide a tidy summarized dataset as an output,
using a R script which uses the orignial UCI dataset as input.

This repo contains the following elements:
- run_analysis.R : this is the R script which loads the data in R, performs various
operations to put the data together, summarizes it, and produces the output text file.
We will explaing in details the steps performed in the script in this document.

- README.md : this doucment, where we explain in detail the analysis perfomend in
run_analysis.R, and present the different pieces of this repository.

- SummaryData_Samsung.txt : a copy of the output produced by run_analysis, which
contains a summary of the measurements calculated in UCI dataset, processed and
presented in a form ready to perform further analysis. A detailed descroiption
on this files content is provided in CodeBook.md

- CodeBook.md :  a detailed description of the output file SummaryData_Samsung.txt


## What run_analysis.R does

The orignial dataset that forms the basis of this project is the "Human Activity
 Recognition Using Smartphones Data Set". This database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
 Further information on this experiment on wearable computing, one of the most exciting areas in all of data science, can be found at the following link:

 <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The original dataset can be downloaded [here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The run_analysis.R script (the script from hereon) assumes that the data
from he link above is downloaded, and unzipped the the form of a folder, and present
in your R working directory before the script is run. The expected name of the unzipped
folder is "UCI HAR Dataset"; it contains:
- 4 text files directly under it
  * activity_labels.txt, contains the code and label of 6 recorded activities ( eg 1 WALKING)
  * features.txt, contains the list of 561 variable names calculated in each of the test and training data
  * features_info.txt
  * README.txt

- and 2 folders "train" and "test" containing further data on the training dataset and test dataset   respectively (below "xxx" stands for either "train" or "test")
  * subject_xxx.txt, contains the list of subject whose activity was recorded on each observation
  * y_xxx.txt, contains the activity recorded on each observation, as encoded in activity_labels.txt
  * X_xxx.txt, the main data i.e. the values of the 561 variables recorded/computed for each observation.

### Step 1: Importing each data piece into R

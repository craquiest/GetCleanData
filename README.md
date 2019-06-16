# Getting and Cleaning Data Project: UCI Human Activity Recognition Data Set
This repo is the result of the "Getting and Cleaning Data" course project,
applied to UCI Human Activity Recognition Data Set.
The goal of this project is to provide a tidy summarized dataset as an output,
using a R script which uses the orignial UCI dataset as input.

This repo contains the following elements:
- run_analysis.R : this is the R script which loads the data in R, performs various
operations to put the data together, summarizes it, and produces the output text file.
We will explaining in details the steps performed in the script in this document. The
script itself is commented in detail at each performed step.

- README.md : this doucment, where we explain in detail the analysis perfomend in
run_analysis.R, and present the different pieces of this repository.

- SummaryData_Samsung.txt : a copy of the output produced by run_analysis, which
contains a summary of the measurements calculated in UCI dataset, processed and
presented in a form ready to perform further analysis. A detailed descroiption
on this files content is provided in CodeBook.md

- CodeBook.md :  a detailed description of the output file SummaryData_Samsung.txt


# What run_analysis.R does

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

## Step 1: Merging traning and test to create one data set.
### a. Loading libraries
The script loads the tidyverse suite (dplyr, readr, tidyr) as it uses functions from those libraries.
The stringr library is also loaded to perform regular expression string operations when giving variables
 in the tidy datasets descriptive names.

### b. Importing each data piece into R
We set a variable 'data_folder' for the name of "root" folder as we'll use in multiple time to read each file.
We also use the same 'path' var to set the path of file about to be imported each time, in order to avoid having
too many single-use variable lying around in the environment.
For each piece of raw data, we:
1. set the file path in platform independent way using the file.path function
2. read in file with read.table
3. convert data frame into a tibble (tidyverse package) with the as_tibble function, and store as variable
4. assign names to the columns of each data frame, for clarity and later use.

As the main measurement data for each of the training/test dataset is only lines of raw numbers without headers or info
to identify each observation (line), we will form/label each dataset separately before merging them. If merger first, we wont be able to identify the subject and activity of each observation.

The 'code' and 'label' of recorded activities  from activity_labels.txt are saved in the 'activities' variable.
The code and name of all the computed features are imported from features.txt into the 'features' variable.
We set stringsAsFactors = FALSE so that we can modify character string later on.

For each of the test and training datasets in their respective folders:
1. the subject data, is imported from corresponding 'subject_xxx.txt' into a single columnn dataframe 'xxx_subject'
with a column name 'subject' containing integers.
2. the activity data, is imported from corresponding 'y_xxx.txt' into a single columnn dataframe 'xxx_activity'
with a column name 'activity' containing integers.
3. the measurements/calculated metrics data is s imported from corresponding 'X_xxx.txt' into a 561-columnn dataframe 'xxx_dataset' of decimal values. We set their column names using the 'features$label' variable created earlier.
4. We then bind the the columns 'xxx_subject' and 'xxx_activity' from 1 and 2, to the left of the new
 'xxx_dataset' dataframe to identify the observations, using dplyr function "bind_cols()".

 For the training test which is larger, we take extra care, by importing first 100 lines, to guess the colummn classes,
 then pass colClasses to read.table. This cuts loading time in half.

### c. Merging the two datasets
 As we have done all the prep work individually this step is straightforward with one line calling the "bind_rows()"
function to create the **'merged_dataset'** data frame.
We do a little house-cleaning by removing the train and test dataset and their ingredients from the workspace, and RAM.
We keep the labeling variables 'features' and 'activities' for later use.

## Step 2: Extract only the measurements on the mean and standard deviation
For this step, we first store the names of our 'merged_dataset' in a variable called 'nms'. We will perform many operations on this variable and using it, to choose the columns we keep, and later on to give our variables descriptive plain English names, as part of the process of making our dataset tidy.

We use a variable **'cols_to_keep'**, as logical vector that will help us subsetting the colummns from 'merged_dataset'. We use **"grepl()" function** on 'nms', along with regular expressions to find the columns with "mean()" (not just the word mean) and "std()" in them, to narrow down the columns where a mean or standard deviation is explicetly calculated from raw measurements.

We also do not forget to add the 'subject' and 'activity' columms. We use successive OR statements on equal-length vectors to build 'cols_to_keep', and this process keeps the columns in the same order (as opposed to merging positions vetors with grep).
Finally we subset our columns using 'cols_to_keep' and oveeride our merged_dataset whith now has 'only' 68 columns (2+33+33).

## Step 3: Uses descriptive activity names in the data set
To achieve this we **join** the 'merged_dataset' with the activity labeling dataframe
'activities' created at the top of script. We use the **dplyr "left_join()" function**, so that we keep the columns of the 'merged_dataset' while effectively only add the 'label' column from activites at the right of our dataset.

We use columns 'activity' from the 'merged_dataset' and 'code' from 'activities' table for the match. Using the dplyr 'mutate()' funstion we override the activity coulmn, before discarding the recently joined 'label'.

 Now we have 68 columns again, and activity for each observation is labeled in plain English.


## Step 4: Appropriately label data set with descriptive variable names
Here we first store our columns names vector again in 'nms'. We perform a series of string substitutions, using the **dplyr 'str_replace_all()' function with regular expressions**, to  gradually convert the variables names, based on the data codebook. Perfomed operations include:
- changing abbreviations like t for Time, f for Frequency
- addding spaces between words and capitalizing
- changing '-X' to 'X axis' while adding spaces
- changing 'mean()' and 'std()' to "Mean" "Standard Deviation"
- expanding 'Mag' and "Acc" and 'Gyro' ("angular velocity") abbreviations,
The new names 'nms' are then re-assigned to the dataset columns.

## Step 5: Create a second independent tidy data set with averages
To create this new **'summarized_dataset'** we use dplyr functions "group_by()" and "summarize_all()". We group by 'subject' and 'activity' columns.

The "summarize_all()" function enables us to apply the 'mean' summary function to all the columns ( except the 2 grouping ones, subject ad activity), without having to specify them all, or giving a range with the long descriptive names.

Now we have a tidy dataset, with :
* each row corresponding to one observation of subject-activity combination
* each column the value of the corresponding summarized statitic,
* each column with descriptive plain English header, each activity descriptively labeled.


After a last bit of house-cleaning, we write our tidy dataset to disk, in the working directory, as "SummaryData_Samsung.txt" text file.

**To import tidy dataset "SummaryData_Samsung.txt" into R, please use:**
**read.table("SummaryData_Samsung.txt", header = TRUE)**

The script also leaves both datasets 'merged_dataset' and
 CodeBook.md describes the variables of the tidy dataset in detail.

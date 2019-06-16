library(tidyverse)  # load packages for dplyr, readr, tidyr and others
library(stringr)    # load for regular expressions  


# Set a veariable for the name of "root" folder 
# that is the result of file unzip
data_folder <- "UCI HAR Dataset"

# For each piece of raw data:
# 1. set the file path in platform independent way
# 2. read in file with read.table
# 3. convert into tibble (tidyverse package), and store as variable

# Information about how recorded activities are coded is 
# present in activity_labels.txt in the root folder
path <- file.path(".",data_folder,"activity_labels.txt")
activities <- as_tibble(read.table(path)) 
names(activities) <- c("code","label")

# The name of all calculated features in the main data is 
# present in the root folder
path <- file.path(".",data_folder,"features.txt")
features <- as_tibble(read.table(path,stringsAsFactors = FALSE))
names(features) <- c("code","label")


# Test dataset 
path <- file.path(".", data_folder, "test", "subject_test.txt")
test_subject <- as_tibble(read.table(path,stringsAsFactors = FALSE)) 
names(test_subject) <- "subject"

path <- file.path(".", data_folder, "test", "y_test.txt")
test_activity <- as_tibble(read.table(path,stringsAsFactors = FALSE)) 
names(test_activity) <- "activity"

path <- file.path(".", data_folder, "test", "X_test.txt")
test_dataset <- as_tibble(read.table(path,stringsAsFactors = FALSE)) 
names(test_dataset) <- features$label

# Attach subject column and activity column to the left
test_dataset <- bind_cols(test_subject,test_activity,test_dataset)


# Training dataset 
path <- file.path(".", data_folder, "train", "subject_train.txt")
train_subject <- as_tibble(read.table(path,stringsAsFactors = FALSE)) 
names(train_subject) <- "subject"

path <- file.path(".", data_folder, "train", "y_train.txt")
train_activity <- as_tibble(read.table(path,stringsAsFactors = FALSE)) 
names(train_activity) <- "activity"

# We take a little more care reading training dataset as it is bigger
# we load a sample to guess column classes, before reading 
# the whole file using those guesses
path <- file.path(".", data_folder, "train", "X_train.txt")
train_dataset <- read.table(path, stringsAsFactors = FALSE,nrows = 100)
colClasses  <- sapply(train_dataset, class)

train_dataset <- as_tibble(
      read.table(path,stringsAsFactors = FALSE,colClasses = colClasses))
names(train_dataset) <- features$label

# Attach subject field and activity fieald
train_dataset <- bind_cols(train_subject,train_activity,train_dataset)


# Now merge both datasets
merged_dataset <- bind_rows(train_dataset, test_dataset)

# Free memory by removing initial datasets
rm(train_dataset, train_activity,train_subject, colClasses)
rm(test_dataset, test_activity,test_subject)



# we are keeping columns "subject", "activity" 
# and columns whose names have "mean()" or "std()" in them
# We find them using regular expressions
# We use the escape \ to make sure to catch ()
nms <- names(merged_dataset)

cols_to_keep <- grepl("mean\\(\\)",nms) | grepl("std\\(\\)",nms)
cols_to_keep <- cols_to_keep | grepl("subject",nms)
cols_to_keep <- cols_to_keep | grepl("activity",nms)

merged_dataset <- merged_dataset[,cols_to_keep]


# Join the activity labels by matching "code" in activities table with 
# "activity" column of merged dataset
# as a result, dataset will have extra column "label" 
# containing activity label
merged_dataset <- left_join(merged_dataset,activities,by=c("activity"="code"))

# Replace activity code with activity label and discard extra column      
merged_dataset <- 
      merged_dataset %>%
      mutate(activity=label)%>%
      select(-label) 


# Make variable names more descriptive
# First get names of all kept variables in merged dataset
# Names will be changed but order will be preserved 
nms <- names(merged_dataset)

# Make more descriptive names by changing to plain english
# Expand abbreviations, add spaces, and eliminate symbols 
nms <- str_replace_all(nms, c("tB" = "Time B", "tG" = "Time G"))
nms <- str_replace_all(nms, c("fB" = "Frequency B", "fG" = "Frequency G"))
nms <- str_replace_all(nms, c("-X" = " X axis","-Y" = " Y axis","-Z" = " Z axis"))
nms <- str_replace_all(nms, c("-mean\\(\\)" = " Mean"))
nms <- str_replace_all(nms, c("-std\\(\\)" = " Standard Deviation"))
nms <- str_replace_all(nms, c("BodyBody" = "Body"))
nms <- str_replace_all(nms, c("Mag" = " Magnitude","Jerk" = " Jerk"))
nms <- str_replace_all(nms, c("BodyAcc" = "Body Acceleration"))
nms <- str_replace_all(nms, c("GravityAcc" = "Gravity Acceleration"))
nms <- str_replace_all(nms, c("BodyGyro" = "Body Angular Velocity"))

# Rename our dataset's column names using resulting vector of names  
names(merged_dataset) <- nms


# To obtain 2nd independent tidy data set 
# we group by subject and by activity, and we take the average 
# for all other variables 
summarized_dataset <- 
      merged_dataset %>% group_by(subject, activity) %>%
      summarize_all(mean)


# Remove all variables from RAM, except for 2 tidy datasets
rm(features, nms, cols_to_keep, activities, path, data_folder)

# Create the output
# we write the summarized dtaset to a text file in working directory
write.table(summarized_dataset, file = "SummaryData_Samsung.txt", row.names = FALSE)

# to read in this output file in R you will need to run:
# read.table("SummaryData_Samsung.txt", header = TRUE)

# We leave both merged_dataset and summarized_dataset in memory
# for the user to work with if they opt to.


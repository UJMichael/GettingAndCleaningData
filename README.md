# Instructions for using run_analysis.R

- Raw data input is the unzipped (preserving directory structure and naming) contents of 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
- dataset contains two sets of data, 'train' and 'test', see README in dataset

- Working directory is required to be in '/UCI HAR Dataset'
- dplyr is required

1. Names for variables are stored in dataset ('features.txt'), these are loaded (unchanged) into R as a vector ('colNames')
2. Data is read from 'X_train.txt' using the function read.table, this creates a data frame ('table') with variables named using 'colNames'.
3. The function, cbind, is used to join data from 'table' to the subject and activity ids found in 'subject\_train.txt' and 'y\_train.txt' (variables are named 'subject' and 'activity' during this operation) this results in a new dataframe named 'table1'
4. These operations are repeated for the 'test' data ('X\_test.txt', 'y\_test.txt', 'subject_test.txt')
5. The 'test'-data data frame and the 'train'-data data frame are joined together using the function r\_
bind that adds (row by row) the 'test' data to the bottom of the 'train' data.
6. Only variables that contain mean and standard deviation are required, these are subsetted into a new data frame using the grepl function, pattern matching on 'subject' or 'activity' or '\.\*mean\.\*' or '\.\*std\.\*' - selecting all variables which are either 'subject', 'activity' or contain the word 'mean' or 'std'
7. The 'activity' variable is an integer (1-6), this is transformed to a label. To do this the 'activity' variable is changed to the class 'factor' with the levels corresponding to appropiate label using the key in 'activity_labels.txt'
8. Variable names are tidyed using the make.names function, which makes the variable names syntactically correct (i.e., using '\.' instead of invalid characters (anything not a letter, number, '\_' or '\.')), excess '\.'s are removed using the function, gsub, with the pattern '\\.\\.' ('\.'s require escaping)
9. The data is then grouped according to 'subject' variable and then 'activity' variable (using dplyr groupby), and a summary table (*named 'summary'*) of means of each measured variable(including mean or std in variable name) for each combination of subject and activity is produced using the dplyr function, summarise.

Also see comments in script for walkthrough, and codebook.md

## Task requirements:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for         each activity and each subject.

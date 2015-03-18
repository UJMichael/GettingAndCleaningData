# Instructions for using run_analysis.R

Raw data input is the unzipped (while preserving directory structure and naming) contents of 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

Working directory is required to be in '/UCI HAR Dataset'
#ddplyr is required installation

1. Names for variables are stored in features.txt, these are loaded (unchanged) into R as a vector (colNames)
2. Data is read from X_train.txt using read.table, creating data frame (table), with variables named using colNames
3. cbind is used to join data from table1 to the subject and activity ids found in subject_train.txt and y_train.txt (variables are named subject and activity during this operation) this results in a new dataframe named table1
4. These operations are repeated for the 'test' data (X_test.txt, y_test.txt, subject_test.txt)
5. The test data data frame and the train data data frame are joined together using the function r_
bind - adding the test data to the bottom of the train data row wise
Only variables that contain are measurements on the mean and standard deviation are required, these are subsetted into a new datframe using grepl pattern matching on subject or activity or .*mean.* or .*std.* - selecting all variables which are either subject, activity or contain the word mean or std
activity is currently as an integer 1-6, this is transformed to a label using the key in ----, to do this the activity variable is changed to the class factor with the levels corresponding to appropiate label using the key
Variable names are tidyed up using make.nams function, which makes the col names syntactically correct (using period instead of invalid characters (anything not a letter number _ or period/dot)), excess dots are removed using gsub with the pattern '\\.\\.' (dots require escaping)
THe data is the grouped according to subject then activity (using dplyr groupby), and summary table is produced using ddplyr summarise (using mean of each measured variable for ech subject activity combination)

Also see comments in script for walkthrough

 
 Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 

    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

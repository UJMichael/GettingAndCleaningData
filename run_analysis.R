##run_analysis.R
#load dplyr
library(dplyr)

#replace **** with path to dataset unzipped  
setwd('****/UCI HAR Dataset')

#grab the variable names from the features.txt file, make them a vector
colNames <- scan('features.txt', what = list(NULL, col=character()))
colNames <- colNames[sapply(colNames, length)>0]

#get the train data into a table, with variable names from colNames
table <- read.table('train/X_train.txt', col.names = colNames$col)

#add on the subject and activity ids for train data
table1 <-cbind(read.table('train//subject_train.txt', col.names = 'subject'),
               read.table('train//y_train.txt', col.names = 'activity'), table)

#get the test data into a table, with variable names from colNames
tabletest <- read.table('test/X_test.txt', col.names = colNames$col)

#add on the subject and activity ids for train data
table2 <-cbind(read.table('test//subject_test.txt', col.names = 'subject'),
               read.table('test//y_test.txt', col.names = 'activity'),
               tabletest)

#add the test and train data together in one table
fulltable <- rbind(table1,table2)

#get only the variables we are interested in
extractd <- fulltable[,grepl('subject|activity|.*mean.*|std.*',
                             colnames(fulltable))]

#label activity with description
extractd$activity <- factor(extractd$activity, levels = c(1,2,3,4,5,6),
                            labels = c('walking', 'walkingUpstairs', 
                                       'walkingDownstairs', 'sitting', 
                                       'standing', 'laying'))

#tidy up the variable names
names(extractd) <- make.names(names(extractd))
names(extractd) <- gsub('\\.\\.', '', names(extractd))

#produce the final summary table
means <- group_by(extractd, subject, activity)
summary <- summarise_each(means, funs(mean))
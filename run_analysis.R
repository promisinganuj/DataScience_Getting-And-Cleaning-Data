#######################################################################################################
## Getting and Cleaning Data:: Getting and Cleaning Data Course Project
## Anuj Parashar
##
## Project Data Source::
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## This script will perform the following steps on the above mentioned UCI HAR Dataset:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.
########################################################################################################

## Set working directory to UCI data folder
setwd("/Users/promisinganuj/Data/Technical/R Language/UCI HAR Dataset")

# Read all the relevant files in dataframes
xTest        <- read.table("./test/X_test.txt")
yTest        <- read.table("./test/Y_test.txt")
xTrain       <- read.table("./train/X_train.txt")
yTrain       <- read.table("./train/Y_train.txt")
features     <- read.table("./features.txt")
activity     <- read.table("./activity_labels.txt")
subjectTest  <- read.table("./test/subject_test.txt")
subjectTrain <- read.table("./train/subject_train.txt")

###################################################################
## 1. Merges the training and the test sets to create one data set.
###################################################################

## Add column names to "activity" dataframe
colnames(activity) <- c('activityId','activityType')

## Merge the testing and training data
main.data <- rbind (xTest, xTrain)
## Now, add column names using "features" dataframe
colnames(main.data) <- features[,2]

## Similarly, merge the testing and trainging data
activity.data <- rbind(yTest, yTrain)
## Add column name to the dataframe
colnames(activity.data) <- "activityId"

## Same for subject data
subject.data <- rbind(subjectTest, subjectTrain)
## Add column name to the dataframe
colnames(subject.data) <- "subjectId"

## Now, column bind all the 3 dataframes
final.data <- cbind(activity.data, subject.data, main.data)

#############################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#############################################################################################

## The complete dataset is available, now pick only the mean() and stddev() related measurements
## Get the column list as vector
column.list <- colnames(final.data)

## Get all the column positions which are to be kept
col.to.keep <- grep("activityId|subjectId|mean\\(\\)|std\\(\\)", column.list)

## Discard other columns from the "final.data" and keep the above
final.data <- final.data[,col.to.keep]

#############################################################################
## 3. Uses descriptive activity names to name the activities in the data set. 
#############################################################################

# Merge the "final.data" with "acitivity" to include descriptive activity names
final.data <- merge(activity,final.data,by='activityId',all.x=TRUE)

########################################################################
## 4. Appropriately labels the data set with descriptive variable names.
########################################################################

# Get the column list again with the additional activityType column
column.list <- colnames(final.data)

## Make the names more descriptive, self explainatory
for (i in 1:length(column.list))
{
    column.list[i] <- gsub("\\(\\)","",column.list[i])  # Remove "()"
    column.list[i] <- gsub("-","",column.list[i])       # Remove "-" 
    column.list[i] <- gsub("std","StdDev",column.list[i])
    column.list[i] <- gsub("mean","Mean",column.list[i])
    column.list[i] <- gsub("^(t)","time",column.list[i])
    column.list[i] <- gsub("^(f)","freq",column.list[i])
}

## Apply the new column names to "final.data"
colnames(final.data) <- column.list;

#######################################################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.
#######################################################################################################

## Creating the final summarised dataframe. Note here that the activityType descriptive column has been
## omitted from the final result as it's redundant for a tidy data set.
final.summarised.df <- aggregate(final.data[4:69], by <- list(activityId = final.data$activityId, subjectId = final.data$subjectId), mean)

# Export the final summarised dataset
write.table(final.summarised.df, 'final_summarised_dataset.txt',row.names=FALSE)

## Tasks Involved
There are five primary steps involved for tidying up this particular given dataset:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Original Data Set:
The original data is already available at the following location: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For a detailed understanding of how the data is captured and organized, please go through the "README.txt" available with the data (above zip file).

## Script(s):
* The is a single R script "run_analysis.R" which is called to perform the task.

## Steps Involved:
* Set the working directory to UCI data folder.
* Read all the relevant files in different dataframes
* Add column names to "activity" dataframe.
* Merge the testing and training data and add column names using "features" dataframe
* Similarly, merge the testing and trainging data and add column name to the dataframe
* Do the same for subject data and dd column name to the dataframe
* Column bind all the 3 dataframes
* The complete dataset is available, now pick only the mean() and stddev() related measurements
* Uses descriptive activity names to name the activities in the data set. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Create the final summarised dataframe. Note here that the activityType descriptive column has been omitted from the final result as it's redundant for a tidy data set.
* Export the final summarised dataset

# Getting-Cleaning-Data
This script has to be run within within the directory "UCI HAR Dataset" created
when the downloaded ZIP file is extracted. It assumes that the training dataset 
under a subdirectory "test" and the training data set is under another subdirecotry
"train."

This script produces a new tidy data set "new_data.txt" with the average of each variable for each activity and each subject.

This script works generally as follows:
1 Remember the current working directory

2 Reading the train data

3 Retain those mean() and std() measures

4 Combine the train data into a single data set

5 Return to the working directory

6 Reading the test data

7 Retain those mean() and std() measures

8 Combine the test data into a single data set

9 Return to the working directory

10 Combine train data and test data

11 Assign meanful names to columns

12 Generate new tidy data set

13 Assign meanful names to the columns of the new data set

14 Export the new tidy data to "new_data.txt"

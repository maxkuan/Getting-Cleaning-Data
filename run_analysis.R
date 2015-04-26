run_analysis<-function(){
##
## This script has to be run within within the directory "UCI HAR Dataset" created
## when the downloaded ZIP file is extracted. It assumes that the training dataset 
## under a subdirectory "test" and the training data set is under another subdirecotry
## "train."
## This script a new tidy data set "new_data.txt" with the average of each variable for each activity and each subject.
##
	library(dplyr)
	
	# remember the current working directory
	wd<-getwd()

	## Reading the train data
	setwd("train")
	train_subject<-read.table("subject_train.txt") # List of subjects generating each record of traing data
	train_activity<-read.table("y_train.txt") # List of activitities performing by the subjects
	train_data<-read.table("X_train.txt") # All records of training data set

	# Retain those mean() and std() measures
    train_data<- train_data[,c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]

	## Combine the data into a single data set
	train_data<-cbind(train_subject, train_activity, train_data)

	## Return to the working directory
	setwd(wd)

	## Reading the test data
	setwd("test")
	
	test_subject<-read.table("subject_test.txt") # List of subjects generating each record of test data
	test_activity<-read.table("y_test.txt") # List of activitities performing by the subjects
	test_data<-read.table("X_test.txt") # All records of training data set
	
	# Retain those mean() and std() measures
	test_data<- test_data[,c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]

	## Combine the data into a single data set
	test_data<-cbind(test_subject, test_activity, test_data)

	## Return to the working directory
	setwd(wd)

	## Combine train data and test data
	data<-rbind(train_data, test_data)
	
	## Assign meanful names to columns
	cnames<-c("Subject", "Activity", "tBodyAcc-mean-X", "tBodyAcc-mean-Y", "tBodyAcc-mean-Z", "tBodyAcc-std-X", "tBodyAcc-std-Y", "tBodyAcc-std-Z", "tGravityAcc-mean-X", "tGravityAcc-mean-Y")
	cnames<-c(cnames, "tGravityAcc-mean-Z", "tGravityAcc-std-X", "tGravityAcc-std-Y", "tGravityAcc-std-Z", "tBodyAccJerk-mean-X", "tBodyAccJerk-mean-Y", "tBodyAccJerk-mean-Z", "tBodyAccJerk-std-X", "tBodyAccJerk-std-Y", "tBodyAccJerk-std-Z")
	cnames<-c(cnames, "tBodyGyro-mean-X", "tBodyGyro-mean-Y", "tBodyGyro-mean-Z", "tBodyGyro-std-X", "tBodyGyro-std-Y", "tBodyGyro-std-Z", "tBodyGyroJerk-mean-X", "tBodyGyroJerk-mean-Y", "tBodyGyroJerk-mean-Z", "tBodyGyroJerk-std-X") 
	cnames<-c(cnames, "tBodyGyroJerk-std-Y", "tBodyGyroJerk-std-Z", "tBodyAccMag-mean", "tBodyAccMag-std", "tGravityAccMag-mean", "tGravityAccMag-std", "tBodyAccJerkMag-mean", "tBodyAccJerkMag-std", "tBodyGyroMag-mean", "tBodyGyroMag-std")
	cnames<-c(cnames, "tBodyGyroJerkMag-mean", "tBodyGyroJerkMag-std", "fBodyAcc-mean-X", "fBodyAcc-mean-Y", "fBodyAcc-mean-Z", "fBodyAcc-std-X", "fBodyAcc-std-Y", "fBodyAcc-std-Z", "fBodyAccJerk-mean-X", "fBodyAccJerk-mean-Y")
	cnames<-c(cnames, "fBodyAccJerk-mean-Z", "fBodyAccJerk-std-X", "fBodyAccJerk-std-Y", "fBodyAccJerk-std-Z", "fBodyGyro-mean-X", "fBodyGyro-mean-Y", "fBodyGyro-mean-Z", "fBodyGyro-std-X", "fBodyGyro-std-Y", "fBodyGyro-std-Z")
	cnames<-c(cnames, "fBodyAccMag-mean", "fBodyAccMag-std", "fBodyBodyAccJerkMag-mean", "fBodyBodyAccJerkMag-std", "fBodyBodyGyroMag-mean", "fBodyBodyGyroMag-std", "fBodyBodyGyroJerkMag-mean", "fBodyBodyGyroJerkMag-std")
	colnames(data)<-cnames
	
	## Generate new tidy data set
	new_data<-data.frame()
	for(i in 1:30){ # for each subject
		for (j in 1:6) { # for each activity
			t_data<-filter(data, Subject==i&Activity==j) # Extract the measurement vector
			t_vec<-apply(t_data, 2,  mean) # apply mean to each column
			new_data<-rbind(new_data, t_vec) 
		}
	}
	## Assign meanful names to the columns
	colnames(new_data)<-cnames 
	
	## Export the new tidy data
	write.table(new_data, "new_data.txt", row.names=FALSE)
}
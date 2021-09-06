## This is a script to fulfill the requirements of Getting and Cleaning Data module's Week 4's assignment. ##

## setting working directory

setwd("/Users/sharik")

## loading the dplyr package ##

library(dplyr)

## downloading and unzipping the dataset on the desktop ##

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="~/desktop/x1")
unzip("~/desktop/x1")

## Before beginning with individual steps, I have read the tables from the dataset on my RStudio using the following commands: ##

features <- read.table("~/desktop/UCI HAR Dataset/features.txt", col.names=c("serialnum", "function"))
activities <- read.table("~/desktop/UCI HAR Dataset/activity_labels.txt", col.names = c("activitycode", "activity"))
subject_test <- read.table("~/desktop/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("~/desktop/UCI HAR Dataset/test/X_test.txt", col.names=features$function.)
y_test <- read.table("~/desktop/UCI HAR Dataset/test/y_test.txt", col.names = "activitycode")
subject_train <- read.table("~/desktop/UCI HAR Dataset/train/subject_train.txt", col.names = "subjectnum")
x_train <- read.table("~/desktop/UCI HAR Dataset/train/X_train.txt", col.names = features$function.)
y_train <- read.table("~/desktop/UCI HAR Dataset/train/y_train.txt", col.names = "activitycode")

## 1. Merges the training and the test sets to create one data set. ##

DataX <- rbind(x_test, x_train)
DataY <- rbind(y_test, y_train)
DataSubject <- rbind(subject_test, subject_train)
DataMerge <- cbind(DataSubject, DataY, DataX)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. ##

DataExtract <- DataMerge %>%
  select(subjectnum, activitycode, contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set. ##

DataExtract$activitycode <- activities[DataExtract$activitycode, 2]

## 4. Appropriately labels the data set with descriptive variable names. ##

names(DataExtract) [2] <- "activityname"
names(DataExtract)<-gsub("Gyro", "Gyroscope", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("BodyBody", "Body", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("Mag", "Magnitude", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("^t", "Time", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("^f", "Frequency", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("tBody", "TimeBody", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("-mean()", "Mean", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("-std()", "STD", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("-freq()", "Frequency", names(DataExtract), ignore.case=)
names(DataExtract)<-gsub("angle", "Angle", names(DataExtract), ignore.case=T)
names(DataExtract)<-gsub("gravity", "Gravity", names(DataExtract), ignore.case=T)

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##

DataClean <- DataExtract %>%
  group_by(subjectnum, activityname) %>%
  summarize_all(funs(mean))

## Write the final table from DataClean ## 
write.table(DataClean, file="~/desktop/DataClean.txt", row.names=F)

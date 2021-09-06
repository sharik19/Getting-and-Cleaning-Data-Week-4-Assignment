---
title: "codebook.md"
author: "Sharik"
date: "06/09/2021"
output: html_document
---
The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Download and unzip the dataset<br>
<p> Dataset downloaded and unzipped under the folder called UCI HAR Dataset </p>

2. Assign each data to variables<br>
<p> features <- features.txt : 561 rows, 2 columns <br>
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. <br>
activities <- activity_labels.txt : 6 rows, 2 columns<br>
List of activities performed when the corresponding measurements were taken and its codes (labels)<br>
subject_test <- subject_test.txt : 2947 rows, 1 column<br>
contains test data of 9/30 volunteer test subjects being observed<br>
x_test <- X_test.txt : 2947 rows, 561 columns<br>
contains recorded features test data<br>
y_test <- test/y_test.txt : 2947 rows, 1 columns<br>
contains test data of activities’code labels<br>
subject_train <- test/subject_train.txt : 7352 rows, 1 column<br>
contains train data of 21/30 volunteer subjects being observed<br>
x_train <- test/X_train.txt : 7352 rows, 561 columns<br>
contains recorded features train data<br>
y_train <- test/y_train.txt : 7352 rows, 1 columns <br>
contains train data of activities’code labels </p>

3. Merges the training and the test sets to create one data set<br>
<p> DataX (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function <br>
DataY (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function<br>
DataSubject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function <br>
DataMerge (10299 rows, 563 column) is created by merging DataSubject, DataY and DataX using cbind() function<br> </p>

4. Extracts only the measurements on the mean and standard deviation for each measurement<br>
<p> DataExtract (10299 rows, 88 columns) is created by subsetting DataMerge, selecting only columns: subjectnum, activitycode and the measurements on the mean and standard deviation (std) for each measurement </p>

5. Uses descriptive activity names to name the activities in the data set<br>
<p> Entire numbers in code column of the DataExtract replaced with corresponding activity taken from second column of the activities variable </p>

6. Appropriately labels the data set with descriptive variable names<br>
<p> code column in DataExtract renamed into activities<br>
All Acc in column’s name replaced by Accelerometer<br>
All Gyro in column’s name replaced by Gyroscope<br>
All BodyBody in column’s name replaced by Body<br>
All Mag in column’s name replaced by Magnitude<br>
All start with character f in column’s name replaced by Frequency<br>
All start with character t in column’s name replaced by Time </p>

7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject<br>
<p> DataClean (180 rows, 88 columns) is created by sumarizing DataExtract taking the means of each variable for each activity and each subject, after groupped by subjectnum and activitycode. </p>

8. Export DataClean into DataClean.txt file.

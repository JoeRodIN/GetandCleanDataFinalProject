---
title: "Getting and Cleaning Data Final Project"
author: Joe Rodriguez
date: 3/27/2016
output: github_document
---

## Project Description
This project was to grab the raw data from a real-world project (explained below) and transform it into a tidy data set.  In addition, a new simple data set was generated from it, calculating the average of the mean and standard deviation values after grouping the data set by the subject and activity performed.


##Study design and data processing
The data was taken used in the following paper [1].

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

###Collection of the raw data
Exerpt from the README.txt file provided with the raw data:

Human Activity Recognition Using Smartphones Dataset

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity.

##Creating the tidy datafile

###Guide to create the tidy data file
0. Download the getdata_projectfiles_UCI HAR Dataset.zip file containing the data needed.
0. Extract all the files to a location accessible by the R environment. (NOTE: file paths below are given starting from the top level folder created when extracted.)
1. Load the necessary libraries: dplyr.
2. Read in the labels (variable names) for the initial calculations performed of the actual data - features.txt.
3. Remove the 1st column since the method of loading introduces an MA column.
4. Read in character activity labels - activity_labels.txt.
5. Read in the TEST subjects (participants) - test/subject_test.txt.
6. Add a column heading (variable name) for the subject column.
7. Read in the TEST activites - test/y_test.txt. 
8. Add a column heading (variable name) for the subject column.
9. Merge the character activity labels with the TEST activities.
10. Append the character activity lables from step 9 with the TEST subject column.
11. Read in TEST data from performing activities - test/X_test.txt.
12. Remove the 1st column because its all NAs due to method of reading in.
13. Add the column headings to be lables read in in Step 2.
14. Using grep, extract all columns whose heading contains mean( - mean or std( - standard deviation.
15. Concatenate the result of Step 14 to result of Step 10.
16. Repeat Steps 5 - 15 for the TRAINing data - replacing the directory in the paths to the files from test to train.
17. Concatenate the results for TEST and TRAINing, TEST data above TRAINing data.
18. Use the result from Step 17, to compute the average for each activity performed by each participant (subject).
19. Write out the result of Step 18 to a file using write.table with row.name-FALSE.

###Cleaning of the data
First, read in the features and activity lables data to be used as variable names (column headings) and to replace the numbering scheme for the activities with descriptive names. 

Then for both the TEST and TRAIN data, read in the subject listing and add a descriptive variable name; then read in the activity list and replace the numbering scheme with the associated descriptive name; then concatenate the subject column with the descriptive name activity column.  Then read in the performance data, add the approviate variable names to them, extract all the values that refer to the mean or standard deviation, and then concatenate the extract to the subject/descriptive name activity result.

Next, combine the TEST and TRAIN data sets into 1 data set, TEST data on top, TRAIN below.  Then compute averages for each subject's activities.

Lastly, write out the results using write.table with row.name=FALSE.

##Description of the variables in the summaryTidyData.txt file
 - Dimensions of the dataset: 180 x 67
 - Summary of the data:
    For each subject (participant) and activity, the average of each variable is provided.

###Variables

ParticipantNumber   character   1:30
Activity            character   WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,                                 SITTING, STANDING, LAYING
The following variables (2 per row) all follow the following format:
    all are numberic 
    t/f - temporal or frequency
    Body/Gravity - component taken from
    Acc/Gyro - Accelerometer or Gyroscope
    mean/std - mean or standard deviation

tBodyAcc.mean...Y           tBodyAcc.mean...Z          
tBodyAcc.std...X            tBodyAcc.std...Y           
tBodyAcc.std...Z            tGravityAcc.mean...X       
tGravityAcc.mean...Y        tGravityAcc.mean...Z       
tGravityAcc.std...X         tGravityAcc.std...Y        
tGravityAcc.std...Z         tBodyAccJerk.mean...X      
tBodyAccJerk.mean...Y       tBodyAccJerk.mean...Z      
tBodyAccJerk.std...X        tBodyAccJerk.std...Y       
tBodyAccJerk.std...Z        tBodyGyro.mean...X         
tBodyGyro.mean...Y          tBodyGyro.mean...Z         
tBodyGyro.std...X           tBodyGyro.std...Y          
tBodyGyro.std...Z           tBodyGyroJerk.mean...X     
tBodyGyroJerk.mean...Y      tBodyGyroJerk.mean...Z     
tBodyGyroJerk.std...X       tBodyGyroJerk.std...Y      
tBodyGyroJerk.std...Z       tBodyAccMag.mean..         
tBodyAccMag.std..           tGravityAccMag.mean..      
tGravityAccMag.std..        tBodyAccJerkMag.mean..     
tBodyAccJerkMag.std..       tBodyGyroMag.mean..        
tBodyGyroMag.std..          tBodyGyroJerkMag.mean..    
tBodyGyroJerkMag.std..      fBodyAcc.mean...X          
fBodyAcc.mean...Y           fBodyAcc.mean...Z          
fBodyAcc.std...X            fBodyAcc.std...Y           
fBodyAcc.std...Z            fBodyAccJerk.mean...X      
fBodyAccJerk.mean...Y       fBodyAccJerk.mean...Z      
fBodyAccJerk.std...X        fBodyAccJerk.std...Y       
fBodyAccJerk.std...Z        fBodyGyro.mean...X         
fBodyGyro.mean...Y          fBodyGyro.mean...Z         
fBodyGyro.std...X           fBodyGyro.std...Y          
fBodyGyro.std...Z           fBodyAccMag.mean..         
fBodyAccMag.std..           fBodyBodyAccJerkMag.mean.. 
fBodyBodyAccJerkMag.std..   fBodyBodyGyroMag.mean..    
fBodyBodyGyroMag.std..      fBodyBodyGyroJerkMag.mean..
fBodyBodyGyroJerkMag.std.. 

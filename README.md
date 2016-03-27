# GetandCleanDataFinalProject
Final Project for the Data Science class Getting and Cleaning Data

This repo consists of the following files:

1. run_analysis.R - the script that processes the data and produces the tidy data set.
2. CodeBook.md - the code book that describes the process and the data
3. README.md - this document that explains what is in this repo. 

There is 1 script that does all the processing.  I kept in the script the path on my machine to access the files needed.  The user of this will need to change them to the proper location where the files are located.  In addition, the final result is written out to a file named summaryTidyData.txt and is put into the current working directory.  If you wish to write out the file to another location, the last line in the script, the write.table, needs to have its second parameter changed to the location you desire.

The CodeBook file describes what the process used as well as contains a reference to the study performed to generate the data as well as the paper written with the results of the study.  It also contains a step-by-step description of how the code works and well as a brief description of the variables/columns of the final tidy data set.

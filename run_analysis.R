# run_analysis.R
# author: Joe Rodriguez
# desc: This script will load 

# include the packages needed
library(dplyr)

# READ IN COLUMN NAMES AND NAMES OF ACTIVITIES
# used by both TEST and TRAINing data

# read in what will be header rows
labelRaw <- read.csv("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/features.txt", sep=" ", stringsAsFactors = FALSE)

# extract values wanted from column 2
#   data files starts w/ a space which is used as separator so removing the extra column
#   it creates
labels <- labelRaw[ , 2]

# read in the activities
activityNames <- read.table("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/activity_labels.txt")

# READ IN AND TIDY TEST DATA

# read in the subject data and put appropriate variable name
subjects <- read.table("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/test/subject_test.txt")
names(subjects) <- c("ParticipantNumber")

# read in activity labels
activityLabels <- read.table("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/test/y_test.txt")
names(activityLabels) <- c("Activities")

# merge them to associate numeric activity number with the actual name of the activity
actNames <- merge(activityLabels, activityNames)

# combine the participants with their activities
tidyTestData <- cbind(subjects, actNames[, 2])
names(tidyTestData) <- c("ParticipantNumber", "Activity")

# read in the average data
actData <- read.table("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/test/X_test.txt", sep=" ")
actData <- actData[ , 2:ncol(actData)]
names(actData) <- labels

# extract only those columns dealing w/ the mean or standard deviation (std)
extractData <- actData[ ,grep("mean\\(|std\\(", labels)]

tidyTestData <- cbind(tidyTestData, extractData)


# READ IN AND TIDY TRAINING DATA

# read in the subject data and put appropriate variable name
subjects <- read.table("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/train/subject_train.txt")
names(subjects) <- c("ParticipantNumber")

# read in activity labels
activityLabels <- read.table("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/train/y_train.txt")
names(activityLabels) <- c("Activities")

# merge them to associate numeric activity number with the actual name of the activity
actNames <- merge(activityLabels, activityNames)

# combine the participants with their activities
tidyTrainData <- cbind(subjects, actNames[, 2])
names(tidyTrainData) <- c("ParticipantNumber", "Activity")

# read in the average data
#   once again, need to remove 1st column due to separator used
actData <- read.table("Desktop/Data Science Courses/Get and Clean Data/week 4 project/UCI HAR Dataset/train/X_train.txt", sep=" ")
actData <- actData[ , 2:ncol(actData)]
names(actData) <- labels

# extract only those columns dealing w/ the mean or standard deviation (std)
extractData <- actData[ ,grep("mean\\(|std\\(", labels)]

tidyTrainData <- cbind(tidyTrainData, extractData)


#CONSTRUCT THE FINAL DATA SETS

# combine both tidy data sets into one final answer
fullTidyData <- rbind(tidyTrainData, tidyTestData)

# now to summarize the data
summaryTidyData <- fullTidyData %>% 
                    group_by(ParticipantNumber, Activity) %>% 
                    summarize_each(., funs(mean(., rm.na=TRUE)))

write.table(summaryTidyData, "summaryTidyData.txt", row.name = FALSE)

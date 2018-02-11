# Create a directory named "data"
if (!file.exists("./data")) {
  dir.create("./data")
}

# Download and unzip dataset to "data" directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/dataset.zip", method="curl")
unzip("./data/dataset.zip")

# Reading trainings tables
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Reading testings tables
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Reading features vector
features <- read.table("UCI HAR Dataset/features.txt")

# Reading activity labels
activityLabels = read.table("UCI HAR Dataset/activity_labels.txt")

# Assigning column names
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"
colnames(trainingSubjects) <- "subjectId"

colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"
colnames(testSubjects) <- "subjectId"

colnames(activityLabels) <- c("activityId", "activityType")

# Merging all data in one set
mergeTrain <- cbind(yTrain, trainingSubjects, xTrain)
mergeTest <- cbind(yTest, testSubjects, xTest)
setAll <- rbind(mergeTrain, mergeTest)

# Extracting only the measurements on the mean and sd for each measurement
colNames <- colnames(setAll)

mean_and_sd <- (grepl("activityId", colNames) | 
                grepl("subjectId", colNames) |
                grepl("mean..", colNames) |
                grepl("sd..", colNames))

setMeanAndSd <-setAll[ , mean_and_sd == TRUE]

# Name the activities in the data set
setWithActivityNames <- merge(setMeanAndSd, activityLabels, by="activityId",
                              all.x=TRUE)

# Create a second, independent tidy data set w/ average of each
# variable for each activity and each subject
tidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
tidySet <- tidySet[order(tidySet$subjectId, tidySet$activityId),]

write.table(tidySet, "tidyset.txt", row.names=FALSE)
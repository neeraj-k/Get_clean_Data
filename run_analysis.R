######run_analysis.R

library(reshape2)
setwd("C:/Neeraj/Online Courses/Online Courses/Data Sciences/GettingAndCleaningData")

## form train cases
subject <- read.table("train/subject_train.txt")
X <- read.table("train/X_train.txt")
y <- read.table("train/y_train.txt")
trainSet <- cbind(subject, X, y)

## form test cases
subject <- read.table("test/subject_test.txt")
X <- read.table("test/X_test.txt")
y <- read.table("test/y_test.txt")
testSet <- cbind(subject, X, y)

## merge test and train cases
data <- rbind(trainSet, testSet)
rm(subject, X, y, trainSet, testSet)

## set column names
features <- read.table("features.txt")
names(data) <- c('subject', as.character(features$V2), 'activityNumber')

## add activity names
activities <- read.table("activity_labels.txt")
names(activities) <- c('activityNumber', 'activity')
data <- merge(activities, data, all = TRUE)
data <- data[order(data$activityNumber, data$subject),]

## extract mean & standard deviation columns
meansDevs <- data[, c(2, 3, grep("-mean\\(\\)|-std\\(\\)", names(data)))]

## clean up column names
cols <- names(meansDevs)[-(1:2)]
cols <- gsub('-|\\(\\)', '', cols)
cols <- gsub('^t', 'timeDomain', cols)
cols <- gsub('^f', 'frequencyDomain', cols)
cols <- gsub('Acc', 'Acceleration', cols)
cols <- gsub('Gyro', 'Gyration', cols)
cols <- gsub('Mag', 'Magnitude', cols)
cols <- gsub('mean', 'Mean', cols)
cols <- gsub('std', 'StdDev', cols)
names(meansDevs)[-(1:2)] <- cols
rm(cols, activities, features)

## form tidy data set with averages
dataSummary <- melt(meansDevs, id = c('activity', 'subject'))
dataSummary <- dcast(dataSummary, activity + subject ~ variable, mean)
write.table(dataSummary, "data_summary.txt")
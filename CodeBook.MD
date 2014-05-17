## Code Book
Explanation of features in features_info.txt in the zip folder that was downloaded


### Variables

data - Data frame, 10299 observations, 564 variables
activityNumber - The outcome (y). It is a numeric representation of the activity being performed in each observation.
activity - Labels naming the activity, as described in the given data.
subject - ID number of the subject.
The remaining 561 columns are numeric values of the features (X), named as described in the given data.
meansDevs - Data frame, 10299 observations, 68 variables
activity - Labels naming the activity.
subject - ID number of the subject.
The remaining 66 columns correspond to the numeric values of features containing -mean() or -std() in their names. Their names have been cleaned up to be self-explanatory.
dataSummary - Data frame, 180 observations, 68 variables
activity - Labels naming the activity.
subject - ID number of the subject.
The remaining 66 columns correspond to the means of their counterparts in meansDevs, for each subject, grouped by activity.


###Analysis Process

The training case subjects, features, and outcomes are read, then aggregated with cbind into trainSet. The same is done for test cases, aggregated into testSet.
testSet and trainset are aggregated with rbind to form data.
Feature names are read from features.txt into features and used to set column names for data.
Activity labels are read from activity_labels.txt into activities and this data frame is merged with data on the basis of activityNumber. This adds an activity column providing a description of activities instead of a numeric representation.
activity, subject, and all columns with names containing -mean() or -std() are extracted from data. This is done using grep on a regexp. The resulting data frame is stored as meansDevs.
Column names in meansDevs are cleaned to be more readable and meaningful, using gsub on regexps to replace parts of column names with descriptive equivalents.
meansDevs is melted with activity and subject as IDs. It is then dcasted to give means of each feature. The result is stored in dataSummary.
dataSummary is written to data_summary.txt in the UCI HAR Dataset folder.

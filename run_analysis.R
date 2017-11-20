#install required packages
install.packages("stringi")
library(stringi)
install.packages("reshape2")
library(reshape2)


#Step 1: Merge training and test sets
#Step1a: Get labels
feature_labels <- read.table("features.txt")
feature_labels_touse <- as.character(feature_labels[,2])
activity_labels <- read.table("activity_labels.txt")

#Step1a: Create training set dataframe
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
combined_train <- cbind(subject_train,X_train,y_train,rep("train",nrow(y_train)))
colnames(combined_train)<-c("SubjectID",feature_labels_touse,"result","TrainOrTest")

#Step1b: Create test set dataframe
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
combined_test <- cbind(subject_test,X_test,y_test,rep("test",nrow(y_test)))
colnames(combined_test)<-c("SubjectID",feature_labels_touse,"result","TrainOrTest")

#Step1c: Merge 1a and 1b.
completedataframe <- rbind(combined_train,combined_test)


#Step2: Extract on the mean and standard deviation for each measurement
#Step2a: identify which features have mean or std
meanorstd <- c(grep("mean()",feature_labels_touse),grep("std()",feature_labels_touse))
meanorstdnames <- c(grep("mean()",feature_labels_touse,value=TRUE),grep("std()",feature_labels_touse,value=TRUE))
#Step2b: extract only mean and std
meanstddataframe <- completedataframe[,c(1,meanorstd+1,563,564)]

#Step3: Use descriptive activity names to name the activities in the data set
activitydataframe <-merge(meanstddataframe,activity_labels,by.x="result",by.y="V1")
colnames(activitydataframe)[ncol(activitydataframe)] <- "ActivityName"

#Step4: Appropriately labesl the data set with descriptive variable names
#completed this step with Step#1b above

#Step5: Create second, independent tidy data set with the average of each variable for each activity and each subject
activitymelt <- melt(activitydataframe,id=c("SubjectID","ActivityName"),measure.vars=meanorstdnames)
activitymelt <- dcast(activitymelt,SubjectID + ActivityName ~ variable,mean)


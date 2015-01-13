

# Instructions:
# Here are the data for the project: 
# wget "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# unzip -t getdata%2Fprojectfiles%2FUCI\ HAR\ Dataset.zip
list.files("UCI HAR Dataset/")

# You should create one R script called run_analysis.R that does the following. 
# 1- Merges the training and the test sets to create one data set.
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt"))
X_all <- rbind(X_train, X_test)

# 2- Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("UCI HAR Dataset//features.txt")
feature_names = features[,2]
names(X_all) <- feature_names


# 3- Uses descriptive activity names to name the activities in the data set
# 4- Appropriately labels the data set with descriptive variable names. 
# 5- From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.


# six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
# for each record it is provided:
#   ======================================
#   
# - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
# - Triaxial Angular velocity from the gyroscope. 
# - A 561-feature vector with time and frequency domain variables. 
# - Its activity label. 
# - An identifier of the subject who carried out the experiment.

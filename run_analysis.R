

# Instructions:
# Here are the data for the project: 
# wget "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# unzip -t getdata%2Fprojectfiles%2FUCI\ HAR\ Dataset.zip
list.files("UCI HAR Dataset/")


# activites
Activity_names = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# You should create one R script called run_analysis.R that does the following. 
# 1- Merges the training and the test sets to create one data set.
# training data and activities
X_train <-  read.table("UCI HAR Dataset/train/X_train.txt") # training data
y_train <- (read.table("UCI HAR Dataset/train/y_train.txt"))[,1] # training activities
y_train <- Activity_names[y_train] # translate to activity names
X_train$Activities <- y_train
# test data and activities
X_test <-  read.table("UCI HAR Dataset/test/X_test.txt") # testing data
y_test <- (read.table("UCI HAR Dataset/test/y_test.txt"))[,1] # testing activities
y_test <- Activity_names[y_test] # translate to activity names
# X_all <- rbind(X_train, X_test)
X_all <- merge(X_train, X_test, all = T)

# 2- Extracts only the measurements on the mean and standard deviation for each measurement.
# read feature names from file and add 'Activities' since we added above in the data frames
features <- read.table("UCI HAR Dataset/features.txt", colClasses = "character")
feature_names <- c(features[,2],'Activities')
names(X_all) <- feature_names
selected_indices <- grep("-mean\\(\\)|-std\\(\\)|Activities", feature_names)
selected_features <- feature_names[selected_indices]
X_selected <- X_all[selected_features]

# 3- Uses descriptive activity names to name the activities in the data set

# 4- Appropriately labels the data set with descriptive variable names. 
# see above, feature names

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

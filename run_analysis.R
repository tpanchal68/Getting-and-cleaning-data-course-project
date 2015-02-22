# Coursera Getting and cleaning data class
# Filename: run_analysis.R
# Author: Tejash Panchal
#
# You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 
# 5.From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.
#

library(plyr)

# Assign test and train dataset directory paths
data_dir <- "UCI\ HAR\ Dataset" # add \ (slash) for space to be included

# mean and standard deviation resides in feature.txt file
feature_file <- paste(data_dir, "/features.txt", sep = "")

# Assign activity label file path
activity_labels_file <- paste(data_dir, "/activity_labels.txt", sep = "")

# Assign all training files paths
x_train_file <- paste(data_dir, "/train/X_train.txt", sep = "")
y_train_file <- paste(data_dir, "/train/y_train.txt", sep = "")
subject_train_file <- paste(data_dir, "/train/subject_train.txt", sep = "")

# Assign all test files paths
x_test_file  <- paste(data_dir, "/test/X_test.txt", sep = "")
y_test_file  <- paste(data_dir, "/test/y_test.txt", sep = "")
subject_test_file <- paste(data_dir, "/test/subject_test.txt", sep = "")

# Let's load all train data
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)

# Let's load all test data
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

# Let's load features and labels
features <- read.table(feature_file, colClasses = c("character"))
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))

##################################################################
# Part 1.Merges the training and the test sets to create one data set.
##################################################################

#Bind train data
trainData <- cbind(cbind(x_train, subject_train), y_train)

#Bind test data
testData <- cbind(cbind(x_test, subject_test), y_test)

#Combine train and test data
Data <- rbind(trainData, testData)

#Assign labels to each column
colLabels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(Data) <- colLabels

# Generate .csv file and output
write.csv(Data, file = "tidydata.csv", row.names=TRUE)

############################################################################################
# Part 2. Extracts only the measurements on the mean and standard deviation for each measurement.
############################################################################################

# Extract mean, std from data frame.  We also need Subject and ActivityId columns.
Data <- Data[,grepl("mean|std|Subject|ActivityId", names(Data))]

###########################################################################
# Part 3. Uses descriptive activity names to name the activities in the data set
###########################################################################

Data <- join(Data, activity_labels, by = "ActivityId", match = "first")
Data <- Data[,-1]

##############################################################
# Part 4. Appropriately labels the data set with descriptive names.
##############################################################

# Remove parentheses
names(Data) <- gsub('\\(|\\)',"",names(Data), perl = TRUE)
names(Data) <- make.names(names(Data))

names(Data) <- gsub('^t',"Time",names(Data))
names(Data) <- gsub('^f',"Frequency",names(Data))
names(Data) <- gsub('Acc',"Accelerometer",names(Data))
names(Data) <- gsub('GyroJerk',"AngularAcceleration",names(Data))
names(Data) <- gsub('Gyro',"AngularSpeed",names(Data))
names(Data) <- gsub('Mag',"Magnitude",names(Data))
names(Data) <- gsub('\\.mean',".Mean",names(Data))
names(Data) <- gsub('\\.std',".StandardDeviation",names(Data))
names(Data) <- gsub('Freq\\.',"Frequency.",names(Data))
names(Data) <- gsub('Freq$',"Frequency",names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))

######################################################################################################################
# Part 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
######################################################################################################################

Data_avg_var_sub = ddply(Data, c("Subject","Activity"), numcolwise(mean))

# Generate .txt file and output
# write.csv(Data_avg_var_sub, file = "Data_avg_var_sub.csv", row.names=TRUE)
write.table(Data_avg_var_sub, file = "Data_avg_var_sub.txt", row.name=FALSE)

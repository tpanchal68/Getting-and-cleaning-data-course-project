# Getting and cleaning data course project
## Overview
This file describes the variables, the data, and any transformations or work performed to clean up the data.  There are total 30 people (subjects) have participated.  There are total 6 activities.

### Variables used in this program:
#### File path variables:
* data_dir -> Local directory where the data is stored.
* feature_file -> Features files path
* activity_labels_file -> Activity labels file path
* x_train_file -> x-train file path
* y_train_file -> y-train file path
* subject_train_file -> subject train file path
* x_test_file -> x-test file path
* y_test_file -> y-test file path
* subject_test_file -> subject test file path

#### Data variables:
* x_train -> train features are loaded under this variable
* y_train -> train activities are loaded under this variable
* subject_train -> train subject number is loaded under this variable
* x_test -> test features are loaded under this variable
* y_test -> test activities are loaded under this variable
* subject_test -> test subject number is loaded under this variable
* features -> Different sensor signal features are loaded under this variable
* activity_labels -> Different activity labels are loaded under this variable
* trainData -> combined train data
* testData -> combined test data
* Data -> data frame created from all the data and then cleaned and stored again in same variable
* tidydata.csv -> tidy data output file
* Data_avg_var_sub.txt -> final data with average is stored at text file

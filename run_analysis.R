#You should create one R script called run_analysis.R that does the following. 

#Preparation of environment
setwd("~/Downloads/UCI HAR Dataset") #setting the working directory
library(dplyr)
library(reshape2)

#Filenames for metedata
activities_filename <- "./activity_labels.txt"
features_datavector_filename <- "./features.txt"

#Filenames for the test set
test_subject_filename <- "./test/subject_test.txt"
test_datavector_filename <- "./test/X_test.txt"
test_activities_filename <- "./test/y_test.txt"

#Filenames for the training set
train_subject_filename <- "./train/subject_train.txt"
train_datavector_filename <- "./train/X_train.txt"
train_activities_filename <- "./train/y_train.txt"

#Filenames for the tidy data result
tidy_data_result_filename <- "./HAR_tidy_data.txt"

#Checking existence of data files - metadata
if (file.exists(activities_filename)) {
  message(paste("File",activities_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",activities_filename, "does not exist. Check your data before going forward.", sep = " "))

if (file.exists(features_datavector_filename)) {
  message(paste("File",features_datavector_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",features_datavector_filename, "does not exist. Check your data before going forward.", sep = " "))

#Checking existence of data files - test set
if (file.exists(test_subject_filename)) {
  message(paste("File",test_subject_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",test_subject_filename, "does not exist. Check your data before going forward.", sep = " "))

if (file.exists(test_datavector_filename)) {
  message(paste("File",test_datavector_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",test_datavector_filename, "does not exist. Check your data before going forward.", sep = " "))

if (file.exists(test_activities_filename)) {
  message(paste("File",test_activities_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",test_activities_filename, "does not exist. Check your data before going forward.", sep = " "))

#Checking existence of data files - train set
if (file.exists(train_subject_filename)) {
  message(paste("File",train_subject_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",train_subject_filename, "does not exist. Check your data before going forward.", sep = " "))

if (file.exists(train_datavector_filename)) {
  message(paste("File",train_datavector_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",train_datavector_filename, "does not exist. Check your data before going forward.", sep = " "))

if (file.exists(train_activities_filename)) {
  message(paste("File",train_activities_filename, "exists. Can continue.", sep = " "))
} else warning(paste("File",train_activities_filename, "does not exist. Check your data before going forward.", sep = " "))

#Loading the files - metadata
activities <- read.table(activities_filename)
  names(activities)[1] <- "activity_id"; names(activities)[2] <- "activity_lbl"
  
features_datavector <- read.table(features_datavector_filename)
  names(features_datavector)[1] <- "feature_id"; names(features_datavector)[2] <- "feature_name"
  features_datavector$feature_name_ok <- make.names(features_datavector$feature_name,unique = TRUE) #creating acceptable names for R
  #ok_to_import indicates which features will be imported from data (mean and std dev values)
  ok_to_import <- c(grep("mean",features_datavector$feature_name_ok,ignore.case = TRUE),grep("std",features_datavector$feature_name_ok,ignore.case = TRUE))
  ok_to_import <- sort(ok_to_import)
  features_datavector <- mutate(features_datavector,mean_std_oktoimport = (feature_id %in% ok_to_import))
  
#Loading the files - test set
test_subject <- read.table(test_subject_filename) 
  names(test_subject)[1] <- "subject_id"
  test_subject <- mutate(test_subject,row_id = 0)
  test_subject$row_id <- 1:length(test_subject$row_id)
  
test_datavector <- read.table(test_datavector_filename)
  names(test_datavector) <- features_datavector$feature_name_ok
  test_datavector <- mutate(test_datavector,row_id = 0)
  test_datavector$row_id <- 1:length(test_datavector$row_id)
  
test_activities <- read.table(test_activities_filename)
  names(test_activities)[1] <- "activity_id"
  test_activities <- mutate(test_activities,row_id = 0)
  test_activities$row_id <- 1:length(test_activities$row_id)

#Loading the files - training set
train_subject <- read.table(train_subject_filename)
  names(train_subject)[1] <- "subject_id"
  train_subject <- mutate(train_subject,row_id = 0)
  train_subject$row_id <- 1:length(train_subject$row_id)
  
train_datavector <- read.table(train_datavector_filename)
  names(train_datavector) <- features_datavector$feature_name_ok
  train_datavector <- mutate(train_datavector,row_id = 0)
  train_datavector$row_id <- 1:length(train_datavector$row_id)
  
train_activities <- read.table(train_activities_filename)
  names(train_activities)[1] <- "activity_id"
  train_activities <- mutate(train_activities,row_id = 0)
  train_activities$row_id <- 1:length(train_activities$row_id)

#Putting together data sets
  #test set
    test_merged <- inner_join(test_subject,test_activities)
    test_merged <- inner_join(test_merged,test_datavector)
    test_merged <- mutate(test_merged,set=1) #Flag to indicate record source dataset. When 1, coming from test. 

  #train set
    train_merged <- inner_join(train_subject,train_activities)
    train_merged <- inner_join(train_merged,train_datavector)
    train_merged <- mutate(train_merged,set=2) #Flag to indicate record source dataset. When 2, coming from train.

  #binding test and train rows
   merged_data <- bind_rows(test_merged,train_merged)
   
   #shifting ok_to_import to fit column numbers in merged file. This vector includes which columns of the merged data correspond to
   #the mean() and std() values to be selected
    ok_to_import_with_mergedata_shift <- ok_to_import + 3
    
   #making final data selection
    merged_tidy_data <- select(merged_data, subject_id, activity_id, set, ok_to_import_with_mergedata_shift)
  
   #setting factor labels for activity and set source indicator
    merged_tidy_data$activity_id <- factor(merged_tidy_data$activity_id, labels = activities$activity_lbl)
    merged_tidy_data$set <- factor(merged_tidy_data$set, labels = c("TEST", "TRAINING")) #this is the result for step 4
    
   #melting the tidy dataset and reshaping by the same ids and calculating means for each variable
    merged_tidy_data_Melt <- melt(select(merged_tidy_data, -(set)), id=c("subject_id", "activity_id"))
    merged_tidy_data_avg <- dcast(merged_tidy_data_Melt, subject_id + activity_id ~ variable, mean)
  
  #writing the tidy data: output required on step 5.
    write.table(merged_tidy_data_avg, tidy_data_result_filename, row.names = FALSE)
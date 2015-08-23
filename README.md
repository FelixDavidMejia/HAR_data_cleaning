# Course Project for Getting and Cleaning Data

## Synopsis

### Objectives
The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare a tidy data set that can be used for later analysis.

In this case, we are dealing with Human Activity Recognition (HAR) data gathered from 30 subjects with ages in between 19 and 48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the team captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  So, for both datasets, the subject id and the activity id is provided along with a 561-feature vector, with kinetic information from the smartphone sensors.

### Brief Description of Data
As previously explained, data has been randomly partitioned into two different datasets, test and training. Different files were provided for each one of the datasets:

**Test Dataset**
* **./test/subject_test.txt :** Each row identifies the subject measured for the sample collected in that window.
* **./test/X_test.txt :** Each row contains the 561-feature measure vector for that sample.
* **./test/y_test.txt :** Each row contains and indicator of the performed activity during that window.

**Training Dataset**
* **./train/subject_test.txt :** Each row identifies the subject measured for the sample collected in that window.
* **./train/X_train.txt :** Each row contains the 561-feature measure vector for that sample.
* **./train/y_train.txt :** Each row contains and indicator of the performed activity during that window.

**Common Files**
* **./features.txt :** Contains the name of each of the measurements of the 561-feature vector.
* **./activity_labels.txt** Contains the descriptive label for each activity.

Original data can be accessed from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

### Activities Performed on Data
An R script, named [run_analysis.R](https://github.com/FelixDavidMejia/HAR_data_cleaning/blob/master/run_analysis.R) is provided. This script performs the following activities:

1. **Prepares the environment,** loading the required libraries (dplyr & reshape2), at the same time that sets the working directory.
..* Variables holding both test & train dataset filenames are created and file existence is verified.
1. **Loading of files for each dataset,** using the read.table() function. At this time, data from each file is stored in a separate data frame.
  * Appropriate column names are provided for all data frames.
  * This includes a name for each feature of the 561-feature vector on each record. These names come from the features.txt file, which are previously made syntactically valid.
1. **Merging of each data set's individual data frames into a single data frame** (for each data set).
  * This is performed using **_dplyr's inner_join()_** function, joining records by a **_row_id_** variable, previously created.
1. **Merging of the test and tra


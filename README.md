# Course Project for Getting and Cleaning Data

## Synopsis

### Objectives
The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare a tidy data set that can be used for later analysis.

In this case, we are dealing with Human Activity Recognition (HAR) data gathered from 30 subjects with ages in between 19 and 48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the team captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  So, for both datasets, the subject id and the activity id is provided along with a 561-feature vector, with kinetic information from the smartphone sensors.

### Brief Description of Data
As previously explained, data has been randomly partitioned into two different datasets, test and training. Different files were provided for each one of the datasets:

**Test Dataset**
* **./test/subject_test.txt :** Each row identifies the subject measured for the sample collected in that window.
* **./X_test.txt :** Each row contains the 561-feature measure vector for that sample.
* **./y_test.txt :** Each row contains and indicator of the performed activity during that window.

**Training Dataset**
* **./train/subject_test.txt :** Each row identifies the subject measured for the sample collected in that window.
* **./X_train.txt :** Each row contains the 561-feature measure vector for that sample.
* **./y_train.txt :** Each row contains and indicator of the performed activity during that window.

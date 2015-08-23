# Human Activity Recognition Using Smartphones Dataset CodeBook

## Source of Data
Data provided is Human Activity Recognition (HAR) data gathered from 30 subjects with ages in between 19 and 48 years using an smartphone (Samsung Galaxy S II) attached to the waist. Each person performed six different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
Original data can be accessed from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

## Original Format
Data is provided in text format, and has been randomly partitioned into two different datasets, test and training. The test dataset has 30% of the data (9 subjects, out of 30, and 2,947 records). The training dataset comprises the remaining 70% of the data (21 subjects, out of 30, and 7,352 records). Different files were provided for each one of the datasets:

**Test Dataset**
* **./test/subject_test.txt :** Each row identifies the subject measured for the sample collected in that window. The identifier used for the loaded data column is **subject_id**.
* **./test/X_test.txt :** Each row contains the 561-feature measure vector for that sample. The structure of this vector will be detailed later in this document.
* **./test/y_test.txt :** Each row contains an indicator of the performed activity during that window. The identifier used for the loaded data column is **activity_id**.

**Training Dataset**
* **./train/subject_test.txt :** Each row identifies the subject measured for the sample collected in that window. The identifier used for the loaded data column is **subject_id**.
* **./train/X_train.txt :** Each row contains the 561-feature measure vector for that sample. The structure of this vector will be detailed later in this document.
* **./train/y_train.txt :** Each row contains an indicator of the performed activity during that window. The identifier used for the loaded data column is **activity_id**.

**Common Files**
* **./features.txt :** Contains the name of each of the measurements of the 561-feature vector.
* **./activity_labels.txt** Contains the descriptive label for each activity.

## Normalised Data
Data corresponding to the name of the different activities performed by the subjects during the measurements, and to the 561 different feature measurements present in the data vector.

###Activities
| Activity ID   | Activity Label     |
| ------------- | ------------------ |
| 1             | WALKING            |
| 2             | WALKING_UPSTAIRS   |
| 3             | WALKING_DOWNSTAIRS |
| 4             | SITTING            |
| 5             | STANDING           |
| 6             | LAYING             |

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare a tidy data set that can be used for later analysis.

In this case, we are dealing with Human Activity Recognition (HAR) data gathered from 30 subjects with ages in between 19 and 48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the team captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  So, for both datasets, the subject id and the activity id is provided along with a 561-feature vector, with kinetic information from the smartphone sensors.





## Activities Performed on Data
An R script, named [run_analysis.R](https://github.com/FelixDavidMejia/HAR_data_cleaning/blob/master/run_analysis.R) is provided. This script performs the following activities:

1. **Prepares the environment,** loading the required libraries (dplyr & reshape2), at the same time that sets the working directory.
..* Variables holding both test & train dataset filenames are created and file existence is verified.
1. **Loading of files for each dataset,** using the read.table() function. At this time, data from each file is stored in a separate data frame.
  * Appropriate column names are provided for all data frames.
  * This includes a name for each feature of the 561-feature vector on each record. These names come from the features.txt file, which are previously made syntactically valid.
1. **Merging of each data set's individual data frames into a single data frame** (for each data set).
  * This is performed using **_dplyr's inner_join()_** function, joining records by a **row_id** variable, previously created. This gives origin to **test_merged** and **train_merged** data frames.
1. **Merging rows from test and training data frames,** giving origin to a single **merged_data** data frame.
  * This action was performed using **dplyr's bind_rows()** function.
1. **A Tidy Dataset is created**
  * This is performed with the **dplyr's select()**, excluding non-relevant information.
  * The *activity_id* column is encoded as a factor, using the labels provided in file **./activity_labels.txt**.
  * Another factor variable, **set**, is created, indicating if the record corresponds to the test or training dataset.
  * This is the output required in **step 4**.
1. **Creation of a second, independent tidy data set, summarizing the data.** This is done calculating the average of each variable for each activity and subject.
  * First, the tidy data set obtained in step 4 is expanded with the **melt()** function from **reshape2** package.
  * Then data is summarized as required, by activity and subject, and the average for each variable is computed. To achieve this, the **dcast()** function from the **reshape2** package was used.
1. Finally, the data is written to disk, as required. The resulting file name is **./HAR_tidy_data.txt**.

## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
*Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.*
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
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

###Features
This is the data contained in the **./test/X_test.txt** and **./train/X_train.txt** files. For each record there are 561 different measurements or features.

The sensors in the smartphone provides measurement of the following signals:

| Signals            |
| ------------------ |
| tBodyAcc-XYZ       |
| tGravityAcc-XYZ    |
| tBodyAccJerk-XYZ   |
| tBodyGyro-XYZ      |
| tBodyGyroJerk-XYZ  |
| tBodyAccMag        |
| tGravityAccMag     |
| tBodyAccJerkMag    |
| tBodyGyroMag       |
| tBodyGyroJerkMag   |
| fBodyAcc-XYZ       |
| fBodyAccJerk-XYZ   |
| fBodyGyro-XYZ      |
| fBodyAccMag        |
| fBodyAccJerkMag    |
| fBodyGyroMag       |
| fBodyGyroJerkMag   |

The suffix '-XYZ' at the end, is used to denote 3-axial signals in the X, Y and Z directions. A set of variables that were estimated from these signals was obtained applying the following functions:

* `mean():` Mean value.
* `std():` Standard deviation.
* `mad():` Median absolute deviation.
* `max():` Largest value in array.
* `min():` Smallest value in array.
* `sma():` Signal magnitude area.
* `energy():` Energy measure. Sum of the squares divided by the number of values.
* `iqr():` Interquartile range.
* `entropy():` Signal entropy.
* `arCoeff():` Autorregresion coefficients with Burg order equal to 4.
* `correlation():` correlation coefficient between two signals.
* `maxInds():` index of the frequency component with largest magnitude.
* `meanFreq():` Weighted average of the frequency components to obtain a mean frequency.
* `skewness():` skewness of the frequency domain signal.
* `kurtosis():` kurtosis of the frequency domain signal.
* `bandsEnergy():` Energy of a frequency interval within the 64 bins of the FFT of each window.
* `angle():` Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'. From all these 561 values, only the values related to the mean and the standard deviation were selected.

### Processing
The three files for each dataset are loaded into separate data frames, and then merged into a single data frame for each dataset. Then rows from both datasets are aggregated into an unique data set. The produced dataset has the following structure:

**Tidy Data Set**

| Variable Name      | Type of Data                                                                                 | Description                   |
| ------------------ | -------------------------------------------------------------------------------------------- | ----------------------------- |
| subject_id         | integer                                                                                      | ID of the test subject        |
| activity_id        | Factor w/ 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING | Activity description          |
| set                | Factor w/ 2 levels: TEST,TRAINING                                                            | Source Dataset (Test/Training |
| several names (86) | numeric                                                                                      | Only the mean and standard deviation measurements (86 out of 561) |

Finally this already tidy data was melt (expanded) into long format, using **subject_id** and **activity_id** as id variables. This melt data frame was then recast into a summarized form, with the average of each variable for each **activity_id** and each **subject_id**.


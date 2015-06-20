##Coursera-Getting-and-Cleaning-Data-Course-Project

* ==================================================================
* Partial Summary of Human Activity Measurements from Samsung Galaxy S II. 
* Original data from source listed at the bottom of this file.
* ==================================================================

The data summarization takes measurement, matches them up with the subject (person) wearing the S II
and the activity they were performing. It then takes averages of the average and standard deviation
data supplied separately for each subject and separately for each activity.

###The dataset includes the following files:

* 'README.txt' :                     This file
* 'CodeBook.md':                     A file containing a list of the variables and descriptions, input and output files and methods of data manipulation
* 'run_analysis.R':                  R Script for making the tidy data
* 'ActivityMeasurementDataMean.txt': Output data - means of mean and stardard deviation data by activity
* 'SubjectMeasurementDataMean.txt' : Output data - means of mean and stardard deviation data by subject

### Original Data Source
https://d396qusza40orc.cloudfront.net/getdata/projectfiles/FUCI%20HAR%20Dataset.zip
  * ==================================================================
  * Human Activity Recognition Using Smartphones Dataset
  * Version 1.0
  * ==================================================================
  * Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
  * Smartlab - Non Linear Complex Systems Laboratory
  * DITEN - Università degli Studi di Genova.
  * Via Opera Pia 11A, I-16145, Genoa, Italy.
  * activityrecognition@smartlab.ws
  * www.smartlab.ws
  * ==================================================================

### Original Data Source Licence
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

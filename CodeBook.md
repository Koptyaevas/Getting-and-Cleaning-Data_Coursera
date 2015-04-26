Description of UCI HAR Dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

R script (run_analysis.R) has the following steps to clean up the data:
1. Merges the training and test sets to create one data set (X_train.txt was merged with X_test.txt), the result of which is same as in original description ("Number of Instances: 10299" & "Number of Attributes: 561"); subject_train.txt was merged with subject_test.txt, the result of which is a data frame with subject IDs; y_train.txt was merged with y_test.txt, the result of which is also a data frame with activity IDs.

2. Extracts only the measurements on the mean and standard deviation for each measurement (features.txt). The result is a data frame, with only 66 out of 561 attributes (because they are measurements on the mean and standard deviation). 

3. Uses descriptive activity names to name the activities in the data set (activity_labels.txt). 

4. Appropriately labels the data set with descriptive variable names: all feature names (attributes) and activity names are converted to lower case (by using tolower), also underscores and brackets were removed. After that I merge the data frame with features and data frames with activity labels and subject IDs. The result was saved as merge_clean_data.txt (it can be found in UCI HAR folder). Subject IDs class is int (integers) and is between 1 and 30. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (data_with_the_averages.txt in UCI HAR folder). The first column contains subject IDs, the second contains activity names; the averages for each of the 66 attributes are in columns 3:68 (30 subjects and 6 activities). 
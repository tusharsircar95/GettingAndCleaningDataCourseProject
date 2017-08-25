# run_analysis.R Overview

### Question 1:
- Loads the training dataset into X_Train, y_Train and Subject_Train variables using read.table()
- Loads the test dataset into X_Test, y_Test and Subject_Test variables using read.table()
- Loads the activity_labels and feature_labels values using read.table()
- Combines both the training and test sets using rbind() and then combines the activity, subject and features using cbind()
- Assign column names to the combined dataset using the feature_labels. 

### Question 2: 
- Columns that have values for the mean and standard deviation have 'mean' or 'std' in their column name (case sensitive).
- Indices of these columns are extracted using the grep function ie. grep("mean|std")
- This data is written to 'MeanAndStdData.csv' using write.csv()

### Question 3:
- The activity attribute in the combined dataset is an integer and the activity name corresponding to each integer is mentioned in the activity_labels data frame.
- These values are substituted in the combined dataset in place of the integers

### Question 4:
- Column names of the dataset are labelled using gsub() function.
- For example, "tBodyAcc" is replaced by "Body.Acceleration.In.Time.Domain and similarly for other measurements

### Question 5:
- Subject and Activity attributes are made factors in the dataset.
- melt() is used to reshape the dataset with id = c("Activity","Subject")
- dcast() is then applied to the reshaped dataset to obtain the means of each of these measurements
- Finally, the data frame is written to tidyData.txt using write.table()
main <- function()
{
    # Load train data
    X_Train = read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE);
    y_Train = read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE);
    Subject_Train = read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
    
    # Load test data
    X_Test = read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE);
    y_Test = read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE);
    Subject_Test = read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
    
    # Load activity labels and feature labels
    activity_labels = read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE)
    feature_labels = read.table("UCI HAR Dataset/features.txt",header=FALSE)
    
    # (Q1) Combine training and test data into one dataset
    X_Combined = rbind(X_Train,X_Test)
    y_Combined = rbind(y_Train,y_Test)
    Subject_Combined = rbind(Subject_Train,Subject_Test)
    
    # Combine the subject, activity and other features together
    Dataset = cbind(Subject_Combined,X_Combined,y_Combined)
   
    # Label attributes using feature_info.txt
    names(Dataset)[2:562] = make.names(feature_labels$V2)
    names(Dataset)[1] = "Subject"
    names(Dataset)[563] = "Activity"
    Dataset$Subject = as.factor(Dataset$Subject);
    
    # (Q2) Extract using regex the columns that have mean and std values
    MeansAndStdData = cbind(Dataset[,c("Subject","Activity")],Dataset[,grep("mean|std",names(Dataset))])
    
    # (Q3) Label activities using descriptive activity names from activity_labels.txt
    MeansAndStdData$Activity = activity_labels[MeansAndStdData$Activity,2]
    write.csv(MeansAndStdData,file="MeanAndStdData.csv",row.names = FALSE)
    Dataset$Activity = activity_labels[Dataset$Activity,2]
    
    # (Q4) Appropriately labels the data set with descriptive variable names
    names(Dataset) = gsub("mad","Median.Absolute.Deviation",names(Dataset));
    names(Dataset) = gsub("sma","Signal.Magnitude.Area",names(Dataset));
    names(Dataset) = gsub("iqr","Interquartile.Range ",names(Dataset));
    names(Dataset) = gsub("arCoeff","Autorregresion.Coefficients",names(Dataset));
    names(Dataset) = gsub("tBodyAcc","Body.Acceleration.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tGravityAcc","Gravity.Acceleration.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tBodyAccJerk","Body.Accelerometer.Jerk.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tBodyGyro","Body.Gyroscope.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tBodyGyroJerk","Body.Gyroscope.Jerk.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tBodyAccMag","Body.Acceleration.Magnitude.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tGravityAccMag","Gravity.Acceleration.Magnitude.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tBodyAccJerkMag","Body.Acceleration.Jerk.Magnitude.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tBodyGyroMag","Body.Gyroscope.Magnitude.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("tBodyGyroJerkMag","Body.Gyroscope.Jerk.Magnitude.In.Time.Domain",names(Dataset));
    names(Dataset) = gsub("fBodyAcc","Body.Acceleration.In.Frequency.Domain",names(Dataset));
    names(Dataset) = gsub("fBodyAccJerk","Body.Acceleration.Jerk.In.Frequency.Domain",names(Dataset));
    names(Dataset) = gsub("fBodyGyro","Body.Gyroscope.In.Frequency.Domain",names(Dataset));
    names(Dataset) = gsub("fBodyAccMag","Body.Acceleration.Magnitude.In.Frequency.Domain",names(Dataset));
    names(Dataset) = gsub("fBodyAccJerkMag","Body.Acceleration.Jerk.Magnitude.In.Frequency.Domain",names(Dataset));
    names(Dataset) = gsub("fBodyGyroMag","Body.Gyroscope.Magnitude.In.Frequency.Domain",names(Dataset));
    names(Dataset) = gsub("fBodyGyroJerkMag","Body.Gyroscope.Jerk.Magnitude.In.Frequency.Domain",names(Dataset));
    names(Dataset) = gsub("\\.\\.",".",names(Dataset))
    names(Dataset) = gsub("\\.\\.",".",names(Dataset))
    
    # (Q5) Creates an independent tidy data set with the average of each 
    # variable for each activity and each subject.
    meltedData = melt(Dataset,id=c("Activity","Subject"))
    summarizedData = dcast(meltedData,Activity+Subject~variable,mean)
    write.table(summarizedData,file="tidyData.txt",row.names = FALSE)

}
    
    
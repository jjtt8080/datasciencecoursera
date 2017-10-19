# Data Science Track, Cleaning Data week 4 assignment
# Analysis the sports ware's data

# Download the file from course website
require(dplyr)
run_analysis <- function() 
{
    url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, "wearable.zip", method="libcurl")
    unzip("wearable.zip")
    dPath <-"UCI HAR Dataset"
    pwd = getwd()
    destwd = paste(pwd, dPath, sep="/", collapse=NULL)
    setwd(destwd)
    datasetRootDir <- destwd
    # extract the labels from features.txt
    featuresNames <- read.csv("features.txt", col.names = c("FeatureID", "FeatureName"), sep = " ", strip.white=TRUE)
    
    # read the activity labels
    activities <- read.csv("activity_labels.txt", sep="", header=FALSE, col.names=c("id", "label"))
    
    # utility function to read the dataset from a folder
    readDataSet <- function(dPath, fileName, subjectFileName, labelFileName) 
    {
    # cd to the Training data set folder
        pwd = datasetRootDir
        destwd = paste(pwd, dPath, sep="/", collapse=NULL)
        setwd(destwd)
        
        
        # Read the x training dataset and set the measure name
        returnDS <- read.csv(fileName, header=FALSE, sep="", strip.white=TRUE)
        # Give the column measure name to x_train
        # Step 4 : Appropriately labels the data set with descriptive variable names.
        colnames(returnDS) <- array(unlist(featuresNames[,2]))
        subjects <- read.csv(subjectFileName, header=FALSE)
        colnames(subjects) <- "SubjectID"
        lbs <- read.csv(labelFileName, header=FALSE)
        colnames(lbs) <- "Activity_Label"
        returnDS <- cbind(lbs, subjects, returnDS)
        returnDS
    }
    
    # 
    x_train <- readDataSet("train", "X_train.txt", "subject_train.txt", "y_train.txt")
    x_test  <- readDataSet("test", "X_test.txt", "subject_test.txt", "y_test.txt")
    
    # Step 1: Merges the training and the test sets to create one data set.
    all_data <- rbind(x_train, x_test)
    
    # Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
    cName <- colnames(all_data)
    ds_wearable <- all_data[, grep("(std\\(\\)|mean\\(\\)|SubjectID|Label)", colnames(all_data))]
    
    # Step 3: Uses descriptive activity names to name the activities in the data set
    for (i in 1: dim(activities)[1])
    {
        activity_label_id = activities[i, 1];
        activity_label_desc = activities[i, 2];
        ds_wearable$Activity_Label <- mapply(sub, x = ds_wearable$Activity_Label, pattern = activity_label_id, replacement=activity_label_desc)
    }
    # Step 4: Appropriately labels the data set with descriptive variable names.
    colNames <- colnames(ds_wearable)
    desc_colNames <- sub("^t", "Time_of_", colNames) #Substitue the beginning t prefix to time
    desc_colNames <- sub("^f", "FFT_of_", desc_colNames) #Substitue the beginning t prefix to time
    desc_colNames <- sub("Acc", "_acceleration_", desc_colNames)
    desc_colNames <- sub("Gyro-", "_gyroscope_", desc_colNames)
    desc_colNames <- sub("Mag", "_Magnitude", desc_colNames)
    desc_colNames <- sub("-mean\\(\\)", "_average", desc_colNames)
    desc_colNames <- sub("-std\\(\\)", "_standard_deviation", desc_colNames)
    desc_colNames <- sub("-(X|Y|Z)$", "_on_\\1_Axis", desc_colNames)
    colnames(ds_wearable) <- desc_colNames
    
    # Step 5: From the data set in step 4, creates a second, 
    # independent tidy data set with the average of each variable for each activity and each subject.
    tidy_ds <- ds_wearable %>%
        group_by_at(vars(SubjectID, Activity_Label)) %>%
        summarize_all(funs(mean(.,na.rm=TRUE)))
    list(ds_wearable, tidy_ds)
}
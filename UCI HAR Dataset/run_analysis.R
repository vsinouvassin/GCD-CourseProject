run_analysis <- function(){
    ## run_analysis.R code for Coursera's Getting and Cleaning Data Course Project
    
    ## This file should be in the directory where the data downloaded from
    ## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    ## was unzipped. It should have the name : UCI HAR Dataset
    
    ## Loading the plyr library for Step 5
    library(plyr)
    
    ## Step 1: Merges the training and the test sets to create one data set.
    
    # 1.1 Loading the training data set
    # Loading the 3 files of the training data set
    trainData <- read.table("./train/X_train.txt")
    trainSubject <- read.table("./train/subject_train.txt")
    trainActivity <- read.table("./train/y_train.txt")
    
    # 1.2 Loading the test data set
    # Loading the 3 files of the test data set
    testData <- read.table("./test/X_test.txt")
    testSubject <- read.table("./test/subject_test.txt")
    testActivity <- read.table("./test/y_test.txt")
    
    # 1.3 Loading the features file
    features <- read.table("features.txt")
    
    # 1.4 Merging the data sets (train and test)
    xData <- rbind(trainData,testData) #measurement data set
    subjectData <- rbind(trainSubject,testSubject) #subject data set
    activityData <- rbind(trainActivity,testActivity) #activity data set
    
    # 1.5 Naming the columns of each data set
    names(xData) <- features[,2] #measurement data set
    names(subjectData) <- "subject" #subject data set
    names(activityData) <- "activity" #activity data set
    
    # 1.6 Creating the main data set by cbinding the measurement, subject and activity data sets
    mainData <- cbind(xData,subjectData,activityData)
    
    ## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
    # Here, I grep only strings which contain mean(), std(), subject or activity in the names of mainData data set
    # Please look the third point in the CodeBook file for more explanation
    goodColumns <- grep("mean\\(\\)|std\\(\\)|subject|activity",names(mainData))
    
    # Extract from mainData only the columns containing mean and standard deviation
    mainData <- mainData[,goodColumns]
    
    ## Step 3: Uses descriptive activity names to name the activities in the data set
    # 3.1 Loading the Activity labels in activity_labels.txt file
    activityLabels <- read.table("activity_labels.txt")
    
    # 3.2 Making the labels descriptive
    # First, I put all the labels to lower case
    activityLabels[,2] <- tolower(as.character(activityLabels[,2]))
    # Replace the underscore in the two labels containing them
    activityLabels[2,2] <- gsub("_u","U",activityLabels[2,2]) # replace walking_upstairs by walkingUpstairs
    activityLabels[3,2] <- gsub("_d","D",activityLabels[3,2]) # replace walking_downstairs by walkingDownstairs
    # I capitalize the first letter of each label
    # For doing so, I use the function found in toupper help file in the sapply function
    activityLabels[,2] <- sapply(activityLabels[,2],function(w){paste(toupper(substring(w, 1, 1)),substring(w,2),sep = "", collapse = " " )})
    
    # Replacing the numbers in the activity column of mainData data set
    # by the descriptive labels from activityLabels
    mainData[,"activity"] <- activityLabels[mainData[,"activity"],2]

    ## Step 4: Appropriately labels the data set with descriptive variable names
    # 4.1 Removing parentheses and dashes
    names(mainData) <- gsub("-","",names(mainData)) #remove dashes
    names(mainData) <- gsub("\\(\\)","",names(mainData)) #remove parentheses
    
    # 4.2 Changing the abbreviations to descriptive names
    names(mainData) <- gsub("^t","time",names(mainData))
    names(mainData) <- gsub("^f","freq",names(mainData))
    names(mainData) <- gsub("mean","Mean",names(mainData))
    names(mainData) <- gsub("std","StandardDeviation",names(mainData))
    
    ## Step 5: From the data set in step 4, creates a second, independent tidy data set
    ## with the average of each variable for each activity and each subject
    
    # Here, I use the ddply function to use the function in "numcolwise" argument, i.e. mean
    # to all columns, column-wise of the columns "subject" and "activity"
    tidyData <- ddply(mainData,c("subject","activity"),numcolwise(mean))
    # Produce the output table
    write.table(tidyData,"tidyData.txt")
}
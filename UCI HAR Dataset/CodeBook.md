## CodeBook for run_analysis.R

# Experimental design (description taken from the original README.txt)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz have been captured.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

# Raw data
The raw data can be classified as following :

1. X_train.txt and X_test.txt contain all the measurements when considered together:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.

features.txt contains the description for these measurements:
- A 561-feature vector with time and frequency domain variables.

2. subject_train.txt and subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

3. y_train.txt and y_test.txt contain the activities executed by the subject for each observation. It is a numeric value from 1 to .

The definition of these numbers is contained in activity_labels.txt.
This file links the class labels with their activity name:
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

# Processed data
1. For processing the data, I've not considered the "pure raw" data contained inside in the "Inertial signals" folders for both train and test data.
These data have already been pre-processed for obtaining the measurements in X_train.txt and X_test.txt files as described in the original README.txt.

## 1. Merges the training and the test sets to create one data set.
2. Merging of data
Following the description of the raw data above, I've merged the following files together:
- X_train.txt and X_test.txt: Added the rows from X_test.txt to the rows of X_train.txt for getting the whole measurements data (called xData)
- subject_train.txt and subject_test.txt: Added the rows from subject_train.txt to the rows of subject_test.txt for getting the whole subject data (called subjectData)
- y_train.txt and y_test.txt: Added the rows from y_train.txt to the rows of y_test.txt for getting the whole activity data (called activityData)

Then I've named each data :
- I've used the variable names contained in features.txt for the measurements data
- I've named the subject data "subject"
- I've named the activity data "activity"

For finishing, I've merged these 3 data sets together by adding the subject column and the activity column (in this order) to the right of the measurements data.
It produces the mainData data frame.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. For extracting only the measurements on the mean and standard deviation for each measurement, I've checked the presence in the variable names of the "feature" part (coming from the features.txt file) of the following strings:
- "mean()" for the mean value
- "std()" for the standard deviation value
The parentheses are important here or else, for instance, if we search for only "mean", we can find "meanFreq" values which are the weighted average of the frequency components (this gives a mean frequency).

And then I've filtered the mainData on the columns containing the means, the standard deviations, the subject and the activity values.

## 3. Uses descriptive activity names to name the activities in the data set
4. As described previously, the activity names were stored as a Factor of 6 levels in the raw data contained in "activity_labels.txt" file:
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

Then I've made the following changes to these names:
- put all the labels to lower case
- delete the underscore in walking_upstairs and walking_downstairs and capitalized the first letter of the second word for each of these labels
- capitalize the first letter of each label

I get the following labels stored as characters:
Walking, WalkingUpstairs, WalkingDownstairs, Sitting, Standing, Laying

Finally, for this step, I replace the numeric values of the column "activity" of the mainData by their respective labels given in the reshaped activity labels data.

## 4. Appropriately labels the data set with descriptive variable names.
5. The filtered variables names from the step 2 of the course project are the following:
[1] "tBodyAcc-mean()-X"            "tBodyAcc-mean()-Y"          
[3] "tBodyAcc-mean()-Z"            "tBodyAcc-std()-X"           
[5] "tBodyAcc-std()-Y"             "tBodyAcc-std()-Z"           
[7] "tGravityAcc-mean()-X"         "tGravityAcc-mean()-Y"       
[9] "tGravityAcc-mean()-Z"         "tGravityAcc-std()-X"        
[11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
[13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
[15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
[17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
[19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
[21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
[23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
[25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
[27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
[29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
[31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
[33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
[35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
[37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
[39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
[41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
[43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
[45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
[47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
[49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
[51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
[53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
[55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
[57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
[59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
[61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
[63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
[65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"
[67] "subject"                     "activity"

Here, we can see that the raw variable names don't respect the rules given in the last page of the video lecture "Editing Text Variables".
It says that names of variables should be:
- All lower case when possible
- Descriptive (Diagnosis versus Dx)
- Not duplicated
- Not have underscores or dots or white spaces

So I've done the following transformation to the variable names for respecting these rules:
- removed the dashes
- removed the parentheses
- when the first letter of the variable is "t", replaced it by "time"
- when the first letter of the variable is "f", replaced it by "freq" for signifying the freqency
- replaced the string "mean" by "Mean"
- and replaced the string "std" by the more descriptive "StandardDeviation"

I end up with the following variable names:
 [1] "timeBodyAccMeanX"                    "timeBodyAccMeanY"                        
 [3] "timeBodyAccMeanZ"                    "timeBodyAccStandardDeviationX"           
 [5] "timeBodyAccStandardDeviationY"       "timeBodyAccStandardDeviationZ"           
 [7] "timeGravityAccMeanX"                 "timeGravityAccMeanY"                     
 [9] "timeGravityAccMeanZ"                 "timeGravityAccStandardDeviationX"        
[11] "timeGravityAccStandardDeviationY"    "timeGravityAccStandardDeviationZ"        
[13] "timeBodyAccJerkMeanX"                "timeBodyAccJerkMeanY"                    
[15] "timeBodyAccJerkMeanZ"                "timeBodyAccJerkStandardDeviationX"       
[17] "timeBodyAccJerkStandardDeviationY"   "timeBodyAccJerkStandardDeviationZ"       
[19] "timeBodyGyroMeanX"                   "timeBodyGyroMeanY"                       
[21] "timeBodyGyroMeanZ"                   "timeBodyGyroStandardDeviationX"          
[23] "timeBodyGyroStandardDeviationY"      "timeBodyGyroStandardDeviationZ"          
[25] "timeBodyGyroJerkMeanX"               "timeBodyGyroJerkMeanY"                   
[27] "timeBodyGyroJerkMeanZ"               "timeBodyGyroJerkStandardDeviationX"      
[29] "timeBodyGyroJerkStandardDeviationY"  "timeBodyGyroJerkStandardDeviationZ"      
[31] "timeBodyAccMagMean"                  "timeBodyAccMagStandardDeviation"         
[33] "timeGravityAccMagMean"               "timeGravityAccMagStandardDeviation"      
[35] "timeBodyAccJerkMagMean"              "timeBodyAccJerkMagStandardDeviation"     
[37] "timeBodyGyroMagMean"                 "timeBodyGyroMagStandardDeviation"        
[39] "timeBodyGyroJerkMagMean"             "timeBodyGyroJerkMagStandardDeviation"    
[41] "freqBodyAccMeanX"                    "freqBodyAccMeanY"                        
[43] "freqBodyAccMeanZ"                    "freqBodyAccStandardDeviationX"           
[45] "freqBodyAccStandardDeviationY"       "freqBodyAccStandardDeviationZ"           
[47] "freqBodyAccJerkMeanX"                "freqBodyAccJerkMeanY"                    
[49] "freqBodyAccJerkMeanZ"                "freqBodyAccJerkStandardDeviationX"       
[51] "freqBodyAccJerkStandardDeviationY"   "freqBodyAccJerkStandardDeviationZ"       
[53] "freqBodyGyroMeanX"                   "freqBodyGyroMeanY"                       
[55] "freqBodyGyroMeanZ"                   "freqBodyGyroStandardDeviationX"          
[57] "freqBodyGyroStandardDeviationY"      "freqBodyGyroStandardDeviationZ"          
[59] "freqBodyAccMagMean"                  "freqBodyAccMagStandardDeviation"         
[61] "freqBodyBodyAccJerkMagMean"              
[62] "freqBodyBodyAccJerkMagStandardDeviation" 
[63] "freqBodyBodyGyroMagMean"                 
[64] "freqBodyBodyGyroMagStandardDeviation"    
[65] "freqBodyBodyGyroJerkMagMean"             
[66] "freqBodyBodyGyroJerkMagStandardDeviation"
[67] "subject"                                 
[68] "activity"

I've considered these variable names as descriptive enough.
Indeed, if I make them more descritive, I will end up with variable names too long. So that's why I've only done the transformations described above.

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. For each of the variables above, except for "subject" and "activity", I calculate the average (mean) grouping by subject and activity.

And I store the result in the data set called tidyData.
This is a data frame of 180 observations from 68 variables.
And this is the output, I write on a file called "tidyData.txt".


# Data Dictionary: Description of each variable of tidyData data set
1. subject
    ID of the subject who performed the activity
    Integer value: 1:30
    
2. activity
    Name of the activity performed
    Character values: "Walking", "WalkingUpstairs", "WalkingDownstairs",
    "Sitting", "Standing", "Laying"
    
3. timeBodyAccMeanX
    Mean of the Average Time of body linear acceleration on the X direction
    Numerical value
    
4. timeBodyAccMeanY
    Mean of the Average Time of body linear acceleration on the Y direction
    Numerical value
    
5. timeBodyAccMeanZ
    Mean of the Average Time of body linear acceleration on the Z direction
    Numerical value
    
6. timeBodyAccStandardDeviationX
    Mean of the Standard deviation Time of body linear acceleration on the X direction
    Numerical value
    
7. timeBodyAccStandardDeviationY
    Mean of the Standard deviation Time of body linear acceleration on the Y direction
    Numerical value

8. timeBodyAccStandardDeviationZ
    Mean of the Standard deviation Time of body linear acceleration on the Z direction
    Numerical value
    
9. timeGravityAccMeanX
    Mean of the Average Time of Gravity acceleration on the X direction
    Numerical value
    
10. timeGravityAccMeanY
    Mean of the Average Time of Gravity acceleration on the Y direction
    Numerical value
    
11. timeGravityAccMeanZ
    Mean of the Average Time of Gravity acceleration on the Z direction
    Numerical value
    
12. timeGravityAccStandardDeviationX
    Mean of the Standard deviation Time of Gravity acceleration on the X direction
    Numerical value
    
13. timeGravityAccStandardDeviationY
    Mean of the Standard deviation Time of Gravity acceleration on the Y direction
    Numerical value
    
14. timeGravityAccStandardDeviationZ
    Mean of the Standard deviation Time of Gravity acceleration on the Z direction
    Numerical value
    
15. timeBodyAccJerkMeanX
    Mean of the Average Derivation in Time of the body linear acceleration on the X direction
    Numerical value
    
16. timeBodyAccJerkMeanY
    Mean of the Average Derivation in Time of the body linear acceleration on the Y direction
    Numerical value
    
17. timeBodyAccJerkMeanZ
    Mean of the Average Derivation in Time of the body linear acceleration on the Z direction
    Numerical value
    
18. timeBodyAccJerkStandardDeviationX
    Mean of the Standard deviation Derivation in Time of the body linear acceleration on the X direction
    Numerical value
    
19. timeBodyAccJerkStandardDeviationY
    Mean of the Standard deviation Derivation in Time of the body linear acceleration on the Y direction
    Numerical value
    
20. timeBodyAccJerkStandardDeviationZ
    Mean of the Standard deviation Derivation in Time of the body linear acceleration on the Z direction
    Numerical value
    
21. timeBodyGyroMeanX
    Mean of the Average Time of the body angular velocity on the X direction
    Numerical value
    
22. timeBodyGyroMeanY
    Mean of the Average Time of the body angular velocity on the Y direction
    Numerical value
    
23. timeBodyGyroMeanZ
    Mean of the Average Time of the body angular velocity on the Z direction
    Numerical value
    
24. timeBodyGyroStandardDeviationX
    Mean of the Standard deviation Time of the body angular velocity on the X direction
    
25. timeBodyGyroStandardDeviationY
    Mean of the Standard deviation Time of the body angular velocity on the Y direction
    
26. timeBodyGyroStandardDeviationZ
    Mean of the Standard deviation Time of the body angular velocity on the Z direction
    Numerical value
    
27. timeBodyGyroJerkMeanX
    Mean of the Average Derived Time of the body angular velocity on the X direction
    Numerical value
    
28. timeBodyGyroJerkMeanY
    Mean of the Average Derived Time of the body angular velocity on the Y direction
    Numerical value
    
29. timeBodyGyroJerkMeanZ
    Mean of the Average Derived Time of the body angular velocity on the Z direction
    Numerical value
    
30. timeBodyGyroJerkStandardDeviationX
    Mean of the Standard deviation Derived Time of the body angular velocity on the X direction
    Numerical value
    
31. timeBodyGyroJerkStandardDeviationY
    Mean of the Standard deviation Derived Time of the body angular velocity on the Y direction
    Numerical value
    
32. timeBodyGyroJerkStandardDeviationZ
    Mean of the Standard deviation Derived Time of the body angular velocity on the Z direction
    Numerical value
    
33. timeBodyAccMagMean
    Mean of the Average Magnitude Time of the body angular velocity
    Numerical value

34. timeBodyAccMagStandardDeviation
    Mean of the Standard deviation Magnitude Time of the body angular velocity
    Numerical value
    
35. timeGravityAccMagMean
    Mean of the Average Magnitude Time of the gravity acceleration
    Numerical value
    
36. timeGravityAccMagStandardDeviation
    Mean of the Standard deviation Magnitude Time of the gravity acceleration
    Numerical value
    
37. timeBodyAccJerkMagMean
    Mean of the Average Magnitue Derivation in Time of the body linear acceleration
    Numerical value
    
38. timeBodyAccJerkMagStandardDeviation
    Mean of the Standard deviation Magnitue Derivation in Time of the body linear acceleration
    Numerical value
    
39. timeBodyGyroMagMean
    Mean of the Average Magnitude Time of the body angular velocity
    Numerical value
    
40. timeBodyGyroMagStandardDeviation
    Mean of the Standard deviation Magnitude Time of the body angular velocity
    Numerical value
    
41. timeBodyGyroJerkMagMean
    Mean of the Average Derived Magnitude Time of the body angular velocity
    Numerical value
    
42. timeBodyGyroJerkMagStandardDeviation
    Mean of the Standard deviation Derived Magnitude Time of the body angular velocity
    Numerical value
    
43. freqBodyAccMeanX
    Mean of the Average Frequency of body linear acceleration on the X direction
    Numerical value
    
44. freqBodyAccMeanY
    Mean of the Average Frequency of body linear acceleration on the Y direction
    Numerical value
    
45. freqBodyAccMeanZ
    Mean of the Average Frequency of body linear acceleration on the Z direction
    Numerical value
    
46. freqBodyAccStandardDeviationX
    Mean of the Standard deviation Frequency of body linear acceleration on the X direction
    Numerical value
    
47. freqBodyAccStandardDeviationY
    Mean of the Standard deviation Frequency of body linear acceleration on the Y direction
    Numerical value
    
48. freqBodyAccStandardDeviationZ
    Mean of the Standard deviation Frequency of body linear acceleration on the Z direction
    Numerical value
    
49. freqBodyAccJerkMeanX
    Mean of the Average Derived Frequency of body linear acceleration on the X direction
    Numerical value
    
50. freqBodyAccJerkMeanY
    Mean of the Average Derived Frequency of body linear acceleration on the Y direction
    Numerical value
    
51. freqBodyAccJerkMeanZ
    Mean of the Average Derived Frequency of body linear acceleration on the Z direction
    Numerical value
    
52. freqBodyAccJerkStandardDeviationX
    Mean of the Standard deviation Derived Frequency of body linear acceleration on the X direction
    Numerical value
    
53. freqBodyAccJerkStandardDeviationY
    Mean of the Standard deviation Derived Frequency of body linear acceleration on the Y direction
    Numerical value
    
54. freqBodyAccJerkStandardDeviationZ
    Mean of the Standard deviation Derived Frequency of body linear acceleration on the Z direction
    Numerical value
    
55. freqBodyGyroMeanX
    Mean of the Average Frequency of the body angular velocity on the X direction
    Numerical value
    
56. freqBodyGyroMeanY
    Mean of the Average Frequency of the body angular velocity on the Y direction
    Numerical value
    
57. freqBodyGyroMeanZ
    Mean of the Average Frequency of the body angular velocity on the Z direction
    Numerical value
    
58. freqBodyGyroStandardDeviationX
    Mean of the Standard deviation Frequency of the body angular velocity on the X direction
    Numerical value
    
59. freqBodyGyroStandardDeviationY
    Mean of the Standard deviation Frequency of the body angular velocity on the Y direction
    Numerical value
    
60. freqBodyGyroStandardDeviationZ
    Mean of the Standard deviation Frequency of the body angular velocity on the Z direction
    Numerical value
    
61. freqBodyAccMagMean
    Mean of the Average Magnitude Frequency of body linear acceleration
    Numerical value
    
62. freqBodyAccMagStandardDeviation
    Mean of the Standard deviation Magnitude Frequency of body linear acceleration
    Numerical value
    
63. freqBodyBodyAccJerkMagMean
    Mean of the Average Magnitude Derived Frequency of body linear acceleration
    Numerical value
    
64. freqBodyBodyAccJerkMagStandardDeviation
    Mean of the Standard deviation Magnitude Derived Frequency of body linear acceleration
    Numerical value
    
65. freqBodyBodyGyroMagMean
    Mean of the Average Magnitude Frequency of the body angular velocity
    Numerical value
    
66. freqBodyBodyGyroMagStandardDeviation
    Mean of the Standard deviation Magnitude Frequency of the body angular velocity
    Numerical value
    
67. freqBodyBodyGyroJerkMagMean
    Mean of the Average Magnitude Derived Frequency of the body angular velocity
    Numerical value
    
68. freqBodyBodyGyroJerkMagStandardDeviation
    Mean of the Standard deviation Magnitude Derived Frequency of the body angular velocity
    Numerical value
    
## For more information about this data, please check the files "features_info.txt" and "README.txt"
## A full description is available at the site where the data was obtained: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
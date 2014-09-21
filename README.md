GCD-CourseProject
=================

Coursera Getting and Cleaning Data repo for Course Project

You'll find on the GitHub repo the following files:
- run_analysis.R (situated on the directory called "UCI HAR Dataset")
- CodeBook.md (situated on the directory called "UCI HAR Dataset")
- README.md

The CodeBook file (CodeBook.md) describes the variables, the data, and any transformations or work that I performed to clean up the data.

For executing the run_analysis.R code:

1. The data which needs to be cleaned up can be found on the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Download it and unzip it on a working directory

3. Then set the working directory to the newly unzipped "UCI HAR Dataset" directory by using the command 'setwd()'

4. Download the run_analysis.R file and copy it in the "UCI HAR Dataset" directory

5. Execute it by using the following commands:

source("run_analysis.R")

run_analysis()

Executing this code produces a file called "tidyData.txt" in your working directory.

For viewing the data contained in the file, please execute the following command:

data <- read.table("tidyData.txt", header = TRUE)

View(data)
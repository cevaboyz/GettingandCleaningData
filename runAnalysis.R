
#Installing the Packages that are going to be used for the assignment

install.packages("data.table")
install.packages("dplyr")
library(data.table)
library(dplyr)

#Obtaining the Data Sets used for the assignment 

dir.create("./Getting_and_Cleaning_Data")

setwd("./Getting_and_Cleaning_Data")

fileurl <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

download.file(fileurl, destfile = "pf.zip", method = "curl" )

unzip("pf.zip")

#You have now obtained the UCI HAR Dataset to use in this assignment
#set the new folder as the working directory

setwd("./UCI HAR Dataset")

#we need to import the features and activity labels to correctly 
#analyze the test and train datasets

activity <- read.csv("activity_labels.txt", sep = "", header = FALSE)

#we only want the V2 Column with the features aka the variables of our final ds

features <- read.csv("features.txt", sep = "", header = FALSE)

features <- features[2]

#Importing and reading the 2 main Sets: X_test and X_train

testds <- read.csv("./test/X_test.txt", sep = "", header = FALSE)

trainds <- read.csv("./train/X_train.txt", sep = "", header = FALSE)

#With the 2 imported data sets: testds and trainds we can now row bind them
#we will achieve one single data set 

assembled <- rbind(testds, trainds)

#we will check if the last row of the new merged dataset is equal to the last 
#of the trainds data set

assembled[nrow(assembled),1] == trainds[nrow(trainds),1]

#TRUE 

#it's time to import the movements data sets: y_test and y_train 

testmovesds <- read.csv("./test/y_test.txt", sep = "", header = FALSE)















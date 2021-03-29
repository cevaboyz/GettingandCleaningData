
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

trainmovesds <- read.csv("./train/y_train.txt", sep = "", header = FALSE)

#these new two data sets represent the type of movements expressed by the 
#activity label from 1 to 6 
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING

#now we can row bind the movements, test and train, in a unique data set

assembledmoves <- rbind(testmovesds, trainmovesds)

#we will check if the last row of the new merged dataset is equal to the last 
#of the trainmovesds data set

assembledmoves[nrow(assembledmoves),1] == trainmovesds[nrow(trainmovesds),1]

#TRUE

#now we have to import the subject_test.txt for the test and train datas
#this file contains the identification ID for the people whose movements were
#collected

testdsID <- read.csv("./test/subject_test.txt", sep = "", header = FALSE)

traindsID <- read.csv("./train/subject_train.txt", sep = "", header = FALSE)

assembledID <- rbind(testdsID, traindsID)

#we will check if the last row of the new merged dataset is equal to the last 
#of the traindsID data set

assembledID[nrow(assembledID),1] == traindsID[nrow(traindsID),1]

#now we can apply the feature vector to the assembled data set, we will 
#change the default Column Names of the assembled data set with the elements
#in the feature vector

names(assembled) <- features[,1]

#now that the assembled data set has the proper label for each column we can
#extract only the columns with the mean and standard deviation measurements

assembledMean_std_only <- assembled[grepl("mean|std", names(assembled), ignore.case = TRUE)]


#we have made a new data set, from with only the mean and std measurements and 
#we are going to merge the assembledmoves data set to the activities in order
#to obtain descriptive names aka "WALKING" etc..

assembledmoves <- merge(assembledmoves, activity, by.x = "V1", by.y = "V1")

#we don't need the number of the activity due to the presence of the extended
#written form 

assembledmoves <- assembledmoves[2]

#we can now apply to the assembledMean_std_only the cbind function and add the 
#descriptive columns about the person ID and movement to the data set

assembledMean_std_only <- cbind(assembledID, assembledmoves, assembledMean_std_only)

#we can now rename the first two columns with descriptive names: PersonalID and Movement 

names(assembledMean_std_only)[1] <- paste("PersonalID")
names(assembledMean_std_only)[2] <- paste("Movement")

#now we can use the dplyr function group_by to obtain a tidy data set 

library(dplyr)

#we are going to group by personalID and Movement and summarise each column 
#applying the mean function to obtain the average of each variable for each variable

final <- group_by(assembledMean_std_only, PersonalID, Movement) %>% summarise_each(funs(mean))

#we are now going to generate a new file with the final data set

write.table(final, "tds.txt", row.names = FALSE)

write.csv(final, "tds1.csv", row.names = FALSE)















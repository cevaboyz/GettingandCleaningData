
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



#Delete variables from workspace... optional
rm(list=ls())
#Script for the Class Project
#Getting and Cleaning Data course on Coursera
#Please install the dplyr and tidyr packages or make sure that it is in your 
#library: latest versions
####prefered

#Create a temporary subdirectory in your working directory
if (!file.exists("course_project")) {
  dir.create("course_project")
}

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20
HAR%20Dataset.zip"
#Url to the zip file we need to work with ##Note s was removed from https. this
#reduces the number of arguments in the function and packages to load

#Download the zip file
download.file(fileUrl, destfile = "samsung_data.zip", quiet = T) 
#To get the day file was downloaded
date_downloaded <- date() 

unzip("samsung_data.zip", exdir = "course_project")
#Once the zip file is unzipped in our directory, delete it
unlink("samsung_data.zip")

setwd("course_project") #Get inside the directory where files were extracted
setwd("UCI HAR Dataset") #Get inside the folder containing the files

#Get the variable names from the features.txt file
column_names <- read.table("features.txt", colClasses = c("numeric", "character"))
column_names <- column_names[[2]] #The characters only

#Make a char vector with names of columns we want to extract
mean_col <- column_names
#This returns all column names with mean measurement excluding meanfreq
mean_col <- setdiff(grep("mean()", mean_col),grep("Freq", mean_col)) 
std_col <- column_names
#Indexes of Columns with std() measurement
std_col <- grep("std()", std_col)
#the vector with mean and std measurements
##After inspecting data with dim() I know what column indexes will contain
###subject and activity measurements
char_vec <- c(mean_col, std_col, 562, 563) 
#562 and 563 are the last 2 columns(subjects and activity columns)
#Organize indexes so that they match the order they are encountered in the data
char_vec <- char_vec[order(char_vec)]
##Vectors creation done


##Make sure the y_test and y_train files are matched with proper names in 
#activity_labels

x_test_data <- read.table("test/X_test.txt") #read the x test data
names(x_test_data) <- column_names #Immediately set variable names
y_test_data <- read.table("test/Y_test.txt") #read the y test data into a df
y_test_data <- y_test_data[[1]] #From a df to a vector
#Same thing for the train data
x_train_data <- read.table("train/X_train.txt")
names(x_train_data) <- column_names
y_train_data <- read.table("train/Y_train.txt")
y_train_data <- y_train_data[[1]] #from a df to a vector
#Now read in the subject ids from the subject_*.txt files
test_subjects <- read.table("test/subject_test.txt")
test_subjects <- test_subjects[[1]] #Chane the table to a vector
train_subjects <- read.table("train/subject_train.txt")
train_subjects <- train_subjects[[1]] #vector
#Read the activity names
activity <- read.table("activity_labels.txt", colClasses = 
                         c("numeric", "character"))
activity <- activity[[2]] #Table to vector... as.vector or class() <- might
                          #cause problems
#Match activity ids with labels
##The lazy way to change names in the y_test and y_train vectors
y_test_data_temp <- y_test_data #temporary vector with activity id _test data
y_train_data_temp <- y_train_data #same as above _for the train data_
#Take the id from the y vector and match with its corresponding value in
#the activity label vector
for (i in 1:length(y_test_data)) {
  y_test_data_temp[i] <- activity[y_test_data[i]]
}
for (j in 1:length(y_train_data)) {
  y_train_data_temp[j] <- activity[y_train_data[j]]
}
##Load dplyr, tidyr packages quietly *not recommended but prettier*
library(dplyr, quietly = TRUE) 
library(tidyr, quietly = TRUE)
##Change X_test and X_train df to a tbl_df
x_test_data <- tbl_df(x_test_data)
x_train_data <- tbl_df(x_train_data)

##Add subjects and actvities performed to the x datas
  #Append the subjects column
  x_test_data <- data.frame(x_test_data, subjects = test_subjects)
  #Now append the activities performes column
  x_test_data <- data.frame(x_test_data, activity = y_test_data_temp)
  #Change the df to a tbl_df for easier management with tidyr
  x_test_data <- tbl_df(x_test_data)
  
##Do the same things from line 90-95 to the X_train data
  x_train_data <- data.frame(x_train_data, subjects = train_subjects)
  x_train_data <- data.frame(x_train_data, activity = y_train_data_temp)
  x_train_data <- tbl_df(x_train_data)

#Combining training and test data
data_set_temp <- rbind(x_train_data, x_test_data) #bind_rows function would work
data_set <- tbl_df(data_set_temp) #making sure the data remains a tbl_df class
#Selecting the columns with the mean() and std() measurements
data_set_mean_std <- select(data_set, char_vec)  #line 44 for char_vec
##line above returns a subset of our original data that only contains columns
###with mean() and std() measurements but also the subjects and the activity 
####being performed

##Tidy data set creation
###Group by subjects and activity(unordered or sorted)
####summarize to get mean for all variables in each subject-activity combo
####%Then further tidy the data (notice original Var names do not neet to be 
####%%changed; they are now observations for an overall measurement*measure*)
tidy_data_set <- data_set_mean_std %>% group_by(subjects, activity) %>%
  summarise_each(funs(mean)) %>% gather(measure, mean, -subjects, - activity)%>% 
  arrange(subjects, activity)
##Now write data to text file
###To return to original working directory
setwd("..")
setwd("..")
########
write.table(tidy_data_set, file = "tidydata_set.txt", row.names = FALSE)
#Since variables are saved in the workspace after switching directories
##as the script is unique
#end of project
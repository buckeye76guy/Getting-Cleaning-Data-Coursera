This codebook is based on [a study on Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The variables described in this codebook are those I created to process the data. The researchers involved in the study have thoroughly documented their study *see link above*.

Experimental design and background: 30 individuals (subjects)were selected to perform 6 activities (activity) while wearing a smartphone (Samsung Galaxy S II) on the waist. The phone has an embedded accelerometer and gyroscope that were used to make measurements Triaxial (x,y,z) acceleration and Triaxial Angular Velocity. Different characteristics of the measurements were saved as different variables. ""The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."" To avoid plagiarism and/or stating wrong facts about the study I recommend **downloading** the zip file from the study and reading it's *README*.

Raw data: The study provides different data sets. The X_test data set is a 2947 by 561 data table with observations for each subjects in the test experiments. The X_train data set is a a 7352 by 561 data table with observations for each subjects in the train experiments. The Y_test and Y_train data sets are vectors with 2947 and 7352 elements respectively. They contain numeric IDs representing the activities being performed by subjects in a given observation.

Processed data: 
Variables | Class
--------- | -----
"activity" | character
"char_vec" | numeric
"column_names" | character
"data_set" | tbl_df
"data_set_mean_std" | tbl_df
"data_set_temp" | tbl_df
"date_downloaded" | character
"fileUrl" | character
"mean_col" | integer
"std_col" | integer
"test_subjects" | integer
"tidy_data_set" | tbl_df
"train_subjects" | integer
"x_test_data" | tbl_df
"x_train_data" | tbl_df
"y_test_data" | integer
"y_test_data_temp" | character
"y_train_data" | integer
"y_train_data_temp" |character

Features was read as a data frame whose second column was a character vector. The second column was saved as column_names. column_names was subsetted into mean_col and std_col in a way that mean_col contained the indexes of the measurements from the X data sets that were pure mean measurements (excluding meanFreq) and std_col contained the indexes of the measurements that were standard deviation measurements. Both mean_col and std_col were put together to form the char_vec which is then sorted to provide the indexes of the selected columns as they would appear in the X data sets left to right.
The X_test data set is read into the variable x_test data which is later turned into a data frame tbl. The X_train data was read into the x_train_data variable which was also turned into a tbl_df class. The Y_test and Y_train data sets were read into the y_test_data and y_train data variables respectively. The vraibles were later turned into character vectors y_test_data_temp and y_train_data_temp by matching the numeric ID from the Y data sets to the corresponding activity labels in the variable activity. The latter was formed by picking the second column of activty_labels data set. The first column in that activity_labels data set consits of numeric values (1:6) with matching characer values in the second column. The same values in the first column appeared in the Y data sets thus making it easy to match an activity with it's numeric ID.
The x_test_data and x_train_data variables were then modified by appending a subjects column and an activity column. The activity columns match the y_test_data_temp and y_train_data_temp. The subjects column was created by picking the first column of the subject_test and subject_train data sets. The values in the subject columns range from 1 to 30 since there were only 30 individuals observed in this expreiment.
The newly made x_test_data and x_train_data were row binded to form the data_set variable which is immediately turned into a data frame tbl. This made it easy to subsect our combined data set by the char_vec. This produced the data_set_mean_std variable which is a data set with the mean and standard deviation measurements for every observation.
data_set_mean_std is then exposed to 4 transformations to create the final tidy_data_set where the original mean and standard deviation measurements were placed in a column named "measure" as factors. We first grouped the data_set_mean_std data frame by its subjects and activity variables. Then we obtain the mean for each variable by subjects-activity combination and gathered all mean and standard deviation measurements into the measure column while keeping the values in the mean column.
The final tidy data has 11880 observations and 4 measurements. This data is then written to a test file called *tidydata_set.txt* in the working directory.
The script is heavily commented for a better understanding of the process.

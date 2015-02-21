# Getting-Cleaning-Data-Coursera
##This **repository** contains a *run_analysis.r* file and *codebook.md* file. An R-script was created to generate a tidy data with measurements of interest from the data obtained from [a study on Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* The codebook
	This is a markdown file that describes the variables encountered in the R script.
* The script
	* This script written in R will download the required data in a zip file and use it to produce a tidy data with 11880 rows and 4 columns.
	* The first 30 lines of the script consist of downloading a zip file, unzipping it and making the working directory the same that contains the required data for the project. In this directory we have access to numerous files. We will use the following:
		1. features.txt
		2. activity_labels.txt
		3. test (a subfolder in our directory)
		4. train (a subfolder in our directory)
	* We then read in the *features.txt* file into a **column_names** variable. The latter is subsetted into a **mean_col** variable consisting of the indexes of each element of 'column_names' that contain mean measurements (excluding meanFrequency measurements) and a **std_col** variable consisting of the indexes of elements with standard deviation measurements. Both 'mean_col' and 'std_col' are put together to form a numeric vector **char_vec** to which we add the indexes 562 and 563 as place holders for columns that we will be appending our given data sets.
	* Then we read in both X and Y data sets from our 'test' and 'train' subdirectories. We also read in the 'activity_labels' data which we use to assign descriptive activity labels to the Y data sets.
	* We proceed to loading the dplyr and tidyr packages from our library and change our X data sets into a [data frame tbl](http://www.inside-r.org/packages/cran/dplyr/docs/tbl_df). This makes it easy to add the 'subjects' and 'activity' columns with 562 and 563 as their respective indexes. It might be helful to note that both X data from our test and train sets have 561 columns.
	* We then combine our X_test and X_train data to form a *data_set* variable. Then we use our previously constructed 'char_vec' variable to subset 'data_set'. Now that we have a data set with desired measurements proceed to the final steps. We create a tidy data by grouping, summarizing, gathering and arrnaging by specific variables. While summarizing we apply the mean function to get the average for each measurement for all **subject-activity** combination. **See *run_analysis.r***
	* By applying the previous functions on our data, we succesfully turn our original column names that hard to manipulate into observations of class factor. We finally save our tidy data into a *tidydata_set.txt* file. 
	* Most importantly every observation is put in a single row, every column has exactly one variable and the variable names are easy to manipulate, and each type of observational unit forms a table.
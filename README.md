# Getting-Cleaning-Data-Coursera
##This **repository** contains a *run_analysis.r* file and *codebook.md* file. An R-script was created to generate a tidy data with measurements of interest from the data obtained from [a study on > Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* The codebook
	This is a markdown file that describes the variables encountered in the R script.
* The script
	* This script written in R will download the required data in a zip file and use it to produce a tidy data with 11880 rows and 4 columns.
	* The first 30 lines of the script consist of downloading a zip file, unzipping it and making the working directory the same that contains the required data for the project. In this directory we have access to numerous files. We will use the following:
		1. features.txt
		2. activity_labels.txt
		3. test (a subfolder in our directory)
		4. train (a subfolder in our directory)
We then read in the 
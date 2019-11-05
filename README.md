This analysis is submitted for the peer-graded assignment: Getting and Cleaning Data Course Project

There is only one R script used in this analysis:

        1. run_analysis.R

1. Step 1 - ensure the UCI HAR Dataset is saved in the same directory as run_analysis.R
2. Step 2 - run run_analysis.R

run_analysis does the following:

1. Loads the necessary packages into R (tidyverse and data.table)
2. Imports the raw data files: activity_labels.txt, features.txt, X_test.txt, Y_test.txt, subject_test.txt, X_train.txt, Y_train.txt, subject_train.txt 
3. Renames the columns in the training and test sets to the variable names set out in "features.txt"
4. Renames the columns in the training and test sets to "activity" and "subject"
5. Combines x, y and subject data sets for both test and training sets
6. Adds a column to boths sets to denote which measurement window each data point refers to
7. Adds a "set" column to retain information on whether each observation is from the test or training set
8. Combines the test and training data sets into a single data set
9. Extracts only mean and standard deviation measurements from this data set
10. Gives variables meaningful names
11. Creates a new data set which summarises data by the mean of each variable for each subject and activity
12. Writes a .txt file containing the summary tidy data set
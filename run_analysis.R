## Load packages

library(tidyverse)
library(data.table)

## Import metadata into R

activity_labels <- read.delim("./UCI HAR Dataset/activity_labels.txt",header = FALSE,sep = "") %>% as.tbl()
features <- read.delim("./UCI HAR Dataset/features.txt",header = FALSE,sep = "") %>% as.tbl()

## Import test data into R

x_test <- read.delim("./UCI HAR Dataset/test/X_test.txt",header = FALSE,sep = "") %>% as.tbl()
y_test <- read.delim("./UCI HAR Dataset/test/Y_test.txt",header = FALSE,sep = "") %>% as.tbl()
subject_test <- read.delim("./UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep = "") %>% as.tbl()

# Import training data into R

x_train <- read.delim("./UCI HAR Dataset/train/X_train.txt",header = FALSE,sep = "") %>% as.tbl()
y_train <- read.delim("./UCI HAR Dataset/train/Y_train.txt",header = FALSE,sep = "") %>% as.tbl()
subject_train <- read.delim("./UCI HAR Dataset/train/subject_train.txt",header = FALSE,sep = "") %>% as.tbl()

# Rename columns in training and test sets to variable names set out in "features.txt"

colnames(x_test) <- features[[2]]
colnames(x_train) <- features[[2]]

# Rename columns in training and test sets to "activity" and "subject"

colnames(y_test) <- c("activity")
colnames(y_train) <- c("activity")

colnames(subject_test) <- c("subject")
colnames(subject_train) <- c("subject")

# Combine x, y and subject for both test and training sets

test_data <- bind_cols(subject_test, y_test, x_test)
train_data <- bind_cols(subject_train, y_train, x_train)


# Add column to denote which window each measurement refers to

test_data <- test_data %>% 
        mutate(window = cumsum(c(1,!(test_data$activity == shift(test_data$activity,1))[-1]))) %>% 
        select(subject,activity,window,`tBodyAcc-mean()-X`:`angle(Z,gravityMean)`) 

test_data <- test_data %>% mutate(window = test_data %>% 
                       split(test_data$window) %>% 
                       sapply(function(x){1:nrow(x)}) %>% 
                       combine())

train_data <- train_data %>% 
        mutate(window = cumsum(c(1,!(train_data$activity == shift(train_data$activity,1))[-1]))) %>% 
        select(subject,activity,window,`tBodyAcc-mean()-X`:`angle(Z,gravityMean)`) 

train_data <- train_data %>% mutate(window = train_data %>% 
                                          split(train_data$window) %>% 
                                          sapply(function(x){1:nrow(x)}) %>% 
                                          combine())

# Add "set" column to retain information on whether observation is test or train

test_data <- test_data %>% mutate(set = "test")
train_data <- train_data %>% mutate(set = "train")

# Combine test and training data

combined_data <- bind_rows(test_data,train_data)

# Extract only mean and standard deviation measurements

mean_std_data <- combined_data %>% select(subject,activity,window,set,contains("mean()"),contains("std()"))

# Rename activity labels

activity_labels$V2 <- str_to_lower(activity_labels$V2)
activity_labels$V2 <- str_replace(activity_labels$V2,"_","")

mean_std_data <- mean_std_data %>% mutate(activity = activity_labels[mean_std_data$activity,2]$V2)

# Remove unnecessary raw data from the global environment

rm(activity_labels, features,subject_test,subject_train,test_data,train_data,x_test,x_train,y_test,y_train)

# Give variables meaningful names

colnames(mean_std_data) <- str_replace(names(mean_std_data),"^t","timedomain")
colnames(mean_std_data) <- str_replace(names(mean_std_data),"^f","frequencydomain ")
colnames(mean_std_data) <- str_replace(names(mean_std_data),"Acc","accelerometer")
colnames(mean_std_data) <- str_replace(names(mean_std_data),"Gyro","gyroscope")
colnames(mean_std_data) <- str_replace_all(names(mean_std_data),"-","")
colnames(mean_std_data) <- str_replace(names(mean_std_data),"\\(\\)","")
colnames(mean_std_data) <- str_replace(names(mean_std_data),"std","standarddeviation")
colnames(mean_std_data) <- str_replace(names(mean_std_data),"Mag","magnitude")
colnames(mean_std_data) <- str_to_lower(names(mean_std_data))

# Create a new data set which summarises data by mean of each variable for each subject and activity

summary_data <- mean_std_data %>% group_by(subject,activity) %>% summarise_all(mean) %>% select(-c(window,set))

# Writes a .txt file containing the summary tidy data set
write.table(summary_data, "./tidy_data_set.txt", row.name = FALSE)
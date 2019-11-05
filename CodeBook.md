# Code Book

## Code and raw data
The code used in this analysis is contatined in the file run_analysis.R. This code was run on the data sets in the UCI Human Activity Recognition Using Smartphones Dataset Version 1.0 [1]. Details of the raw data and the experimental conditions are included in the README.txt file within the raw data set. This codebook should be used alongside the codebooks contained in the raw dataset:
        README.txt
        activity_labels.txt
        features_info.txt
        features.txt

## Tidy data sets
Two data sets are produced by the code in run_analysis.R:

        mean_std_data   This contains the estimate of mean and standard deviation for each variable for each measurement window used in the original experiment
        summary_data    This contains a summary of each variable in the mean_std_data data set, summarized by the mean for each subject and activity
        
## Variables

The following means and standard deviations of the variable below are contained in the dataset, mean_std_data

- Time domain body and gravity acceleration signals for all x,y,z components and the magnitude of these signals
- Time domain body gyroscope signals for all x,y,z components and the magnitude of these signals
- Time domain body acceleration and gyroscope jerk signals for all x,y,z components and the magnitude of these signals
- Frequency domain body acceleration signals for all x,y,z components and the magnitude of these signals
- Frequency domain body gyroscope signals for all x,y,z components and the magnitude of these signals
- Frequency domain body acceleration and gyroscope jerk signals for all x,y,z components and the magnitude of these signals

## Units
- Acceleration measurements are in standard gravity units 'g'
- Gyroscope measurements are in units of radians/second
- Each measurement is normalized and bounded within [-1,1]

##References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# Summary of Human Activity Recognition Using Smartphones dataset
## Aim

To builds a summary by activity and subject of the mean and standard deviation feature variables encountered in the dataset.

## Script
The single script run_analysis.R executes the getting and the cleaning operations on the dataset.
### Setup
Store the run_analysis.R script in a project directory which already contains the UCI HAR Dataset directory.

Open the run_analysis.R script inside RStudio and set the working directory to the project directory.

Source the run_analysis.R script.

### Output
The execution of the run_analysis.R script generates the tidy_dataset.txt file. 

## Getting and Cleaning

The script loads the training and test X_ datasets which contains the feature variables.

The feature variables in both datasets are renamed using the descriptive naming provided by the data of the features vector. The undesired characters found in the feature names data are dropped before the renaming.

The rows of the test X_ dataset are added to the training X_ dataset. The new Group column is added and groups the two sets of rows.

The resulting dataset is merged with the Activity dataset. This sets a better descriptive variable name for the activity inside the dataset.

Finally the dataset is summarized by activity and subject. Each feature variable is replaced by the mean of its values. The Group column is not considered.

## Other

The execution of the script logs the different stages.

This script uses functions of the dplyr package.

The load_signals_DS function loads the datasets which contain the Triaxial acceleration from the accelerometer (total acceleration), the estimated body acceleration and the Triaxial Angular velocity from the gyroscope. This function is not called by default.

The data is taken from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The explanation for the variables is here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

With this script I tooke the data (y, X and subject) from test and train directories which are in the zip file and merge but only the mean and std values (not meanfreq).
This is stored in final data frame.
The names and unities of the variables are those expalined in the source data.

I also calculate the mean of each variable of the final file per each subject and activity and stored in result data frame, with the same name variables as before.
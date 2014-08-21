ProgrammingAssignment_Getting-and-Cleaning-Data_Rprogramming
============================================================

Programming assignment in the frame of Getting and Cleaning Data course

The R file uses 3 libraries stringr, plyr, reshape2
First the code reads all the train and test data, merges them and saves into new folder "total"
Next the appropriate labeling for activity and test dataset is performed
Finally the subset, containing mean & std data is selected, melted into single column with melt function and ddply calculates the mean value of the values for all combinations of subject & activities
The data is saved then

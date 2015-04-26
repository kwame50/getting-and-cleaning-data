# getting-and-cleaning-data
This is the repository for the getting and cleaning data project.

The run_analysis.R script performs the following steps to clean the data:
i.Read X_train.txt, y_train.txt and subject_train.txt from the "train" folder and store them in trainData, trainLabel and trainSubject variables respectively.

ii.Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in testData, testLabel and testsubject variables respectively.

iii.Concatenate testData to trainData to generate a 10299x561 data frame, joinData; concatenate testLabel to trainLabel to generate a 10299x1 data frame, joinLabel; concatenate testSubject to trainSubject to generate a 10299x1 data frame, joinSubject.

iv.Read the features.txt file from the "/data" folder and store the data in a variable called features. We only extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of joinData with the 66 corresponding columns.

v.Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.

vi.Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called activity.

vii.Clean the activity names in the second column of activity. We first make all names to lower cases. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore.

viii.Transform the values of joinLabel according to the activity data frame.

ix.Combine the joinSubject, joinLabel and joinData by column to get a new cleaned data frame, cleanedData. 

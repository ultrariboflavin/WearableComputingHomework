Key variables and summaries created by the run_analysis.R script:

-------------------------------------------------------------------------------------------------------------------

completedataframe: Dataframe containing all train & test data for the study. This dataframe is created by combining subject data (subject_train.txt, subject_test.txt) with the features (X_train.txt, X_test.txt) and the results (ytrain.txt, ytest.txt).  

meanstddataframe: Dataframe that removes features that are not mean and standard deviation features from the completedataframe data frame.

activitydataframe: Dataframe that adds a descriptive activity column to the meanstddataframe.

activitymelt: Dataframe that summarizes activitydataframe by taking the mean of each of the features by Subject and ActivityName




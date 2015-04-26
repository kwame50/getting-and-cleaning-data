# Step1. Merges the training and the test sets to create one data set.
trainLabel <- NULL
trainSubject <- NULL
trainData <- NULL
testLabel <- NULL
testSubject <- NULL
testData <- NULL

setwd("C:/Users/Daddy 2/Documents/getting and cleaning data/class project")
setInternet2(use = TRUE)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- tempfile()

if(!file.exists(zipFile)) { download.file(url, zipFile) }
  
dataDir <- "UCI HAR Dataset"
if(!file.exists(dataDir)) {unzip(zipFile, exdir = ".") }

readData <- function(path) {
  read.table(filePath(dataDir, path))
}

# Read and cache Training and Test data
if(is.null(trainData)) { trainData <<- readData("train/X_train.txt") }
if(is.null(testData))  { testData  <<- readData("test/X_test.txt") }
if(is.null(trainLabel))  { trainLabel  <<- readData("train/y_train.txt") }
if(is.null(testLabel))  { trainLabel  <<- readData("test/y_test.txt") }
if(is.null(trainSubject))  { trainSubject  <<- readData("train/subject_train.txt") }
if(is.null(testSubject))  { testSubject  <<- readData("test/subject_test.txt") }

joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)[, 1]
joinSubject <- rbind(trainSubject, testSubject)[, 1]

# Step2. Extracts only the measurements on the mean and standard  
# deviation for each measurement.  

featureNames <- readData("features.txt")[, 2]
feature <- featureNames
names(features) <- c("colnum", "name")

# feature names with mean/std in the name
fmean <- grepl("mean()", featureNames)  # TODO: does meanFreq() count as mean?
fstd <- grepl("std()", featureNames)
fkeep <- fmean | fstd

# extract only mean/std columns, add variable names
Xmeanstd <- joinData[, fkeep]
names(Xmeanstd) <- featureNames[fkeep]

# Step3. Uses descriptive activity names to name the activities in  
# the data set 
activities <- factor(joinSubject, 
              levels=c(1, 2, 3, 4, 5, 6),
              labels=c("Walk", "Walk up stairs", "Walk down stairs", "Sit", "Stand", "Lay"))
subject <- joinSubject              

# Step4. Appropriately labels the data set with descriptive activity  
# names.
Xcombined <- cbind(Xmeanstd, activities, joinSubject)
Xmelt <- melt(Xcombined,
              id=c("activities", "subject"),
              measure.vars=names(Xmeanstd))
Xtidy <- dcast(Xmelt, activities + subject ~ variable, mean)

# Step5. Creates a second, independent tidy data set with the average of  
# each variable for each activity and each subject.  
write.table(Xtidy,
            "tidy.csv",
            sep=",",
            row.names=FALSE) 

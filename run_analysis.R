#Load dplry package for data frame manipulations
library(dplyr)


###
#           READING GENERAL DATA SECTION
###

#Read Activity Data Labels from "activity_labels.txt" file as character strings
activityDataLabels <- read.table("activity_labels.txt",
                                 colClasses = c("numeric", "character"),
                                 col.name = c("TrainingID", "TrainingType"))

#Read Measurement data variables names from "features.txt" as
#character strings
measurementLabels <- read.table("features.txt",
                                colClasses = c("character"),
                                col.name = c("Unused", "Measurement"))


###
#Create Descriptive Variable Names for each measurement summary
###

#Start by creating a vector copy of original measurement variables names
descMeasurementLabels <- subset(measurementLabels, select=Measurement, drop=TRUE)

#Replace cryptic variable name parts with more descriptive parts
descMeasurementLabels <- sub("angle\\(tBodyAccMean,gravity\\)",
                             "AngleBetweenBodyAndGravityAccelerationMeans",
                             descMeasurementLabels)
descMeasurementLabels <- sub("angle\\(tBodyAccJerkMean\\),gravityMean)",
                             "AngleBetweenBodyJerkAndGravityAccelarationMeans",
                             descMeasurementLabels)
descMeasurementLabels <- sub("angle\\(tBodyGyroMean,gravityMean\\)",
                             "AngleBetweenBodyGyroVelocityAndGravityAccelarationMeans",
                             descMeasurementLabels)
descMeasurementLabels <- sub("angle\\(tBodyGyroJerkMean,gravityMean\\)",
                             "AngleBetweenBodyGyroJerkAndGravityAccelarationMeans",
                             descMeasurementLabels)
descMeasurementLabels <- sub("angle\\(X,gravityMean\\)",
                             "AngleBetweenXAndGravityAccelarationMean",
                             descMeasurementLabels)
descMeasurementLabels <- sub("angle\\(Y,gravityMean\\)",
                             "AngleBetweenYAndGravityAccelarationMean",
                             descMeasurementLabels)
descMeasurementLabels <- sub("angle\\(Z,gravityMean\\)",
                             "AngleBetweenZAndGravityAccelarationMean",
                             descMeasurementLabels)
descMeasurementLabels <- sub("tBodyBody", "TimeDomainBody", descMeasurementLabels)
descMeasurementLabels <- sub("tBody", "TimeDomainBody", descMeasurementLabels)
descMeasurementLabels <- sub("tGravity", "TimeDomainGravity", descMeasurementLabels)
descMeasurementLabels <- sub("Acc", "Accel", descMeasurementLabels)
descMeasurementLabels <- sub("-mean\\(\\)-X", "XDirMean", descMeasurementLabels)
descMeasurementLabels <- sub("-mean\\(\\)-Y", "YDirMean", descMeasurementLabels)
descMeasurementLabels <- sub("-mean\\(\\)-Z", "ZDirMean", descMeasurementLabels)
descMeasurementLabels <- sub("-mean\\(\\)", "Mean", descMeasurementLabels)
descMeasurementLabels <- sub("AccJerk", "Jerk", descMeasurementLabels)
descMeasurementLabels <- sub("-std\\(\\)-X", "XDirStdDev", descMeasurementLabels)
descMeasurementLabels <- sub("-std\\(\\)-Y", "YDirStdDev", descMeasurementLabels)
descMeasurementLabels <- sub("-std\\(\\)-Z", "ZDirStdDev", descMeasurementLabels)
descMeasurementLabels <- sub("-std\\(\\)", "StdDev", descMeasurementLabels)
descMeasurementLabels <- sub("Gyro", "AngularVelocity", descMeasurementLabels)
descMeasurementLabels <- sub("-meanFreq\\(\\)-X", "XDirFreqMean", descMeasurementLabels)
descMeasurementLabels <- sub("meanFreq\\(\\)-X", "XDirFreqMean", descMeasurementLabels)
descMeasurementLabels <- sub("-meanFreq\\(\\)-Y", "YDirFreqMean", descMeasurementLabels)
descMeasurementLabels <- sub("meanFreq\\(\\)-Y", "YDirFreqMean", descMeasurementLabels)
descMeasurementLabels <- sub("-meanFreq\\(\\)-Z", "ZDirFreqMean", descMeasurementLabels)
descMeasurementLabels <- sub("meanFreq\\(\\)-Z", "ZDirFreqMean", descMeasurementLabels)
descMeasurementLabels <- sub("fBodyBody", "FreqDomainBody", descMeasurementLabels)
descMeasurementLabels <- sub("fBody", "FreqDomainBody", descMeasurementLabels)
descMeasurementLabels <- sub("-meanFreq\\(\\)", "MeanFreq", descMeasurementLabels)

#Add descriptive Labels to Data measurement Label Dataframe and keep as characters (not factors)
measurementLabels <- cbind(measurementLabels, DescriptiveMeasurementName=as.character(descMeasurementLabels))
measurementLabels$DescriptiveMeasurementName <- as.character(measurementLabels$DescriptiveMeasurementName)

#create a vector of training variables with mean/Mean and standard deviation only
measLabels <- measurementLabels[,3]
meanTrainVars <- measLabels[regexpr("Mean", measLabels) > 0]
stdTrainVars <- measLabels[regexpr("StdDev", measLabels) > 0]
trainVars <- c(meanTrainVars, stdTrainVars)
remove(meanTrainVars, stdTrainVars, measLabels, descMeasurementLabels)

#Add subject and activity variable names to training variables to keep
#trainVars <- c("Subject", "TrainingID", "TrainingType", trainVars)
trainVars <- c("Subject", "TrainingID", trainVars)


###
#           READING TRAIN DATA SECTION
###

#Read Training Type ID for each Activity recored in "X_train.txt"
#from "Y_train.txt" in "train" folder cast as numeric variables
trainType <- read.table("train/Y_train.txt",
                        colClasses = "numeric",
                        col.name = c("TrainingID"))

#Read Subject ID for each Activity recorded in "X_train.txt"
#from "subject_train.txt" in "train" folder cast as numeric variables
trainSubject <- read.table("train/subject_train.txt",
                           colClasses = "numeric",
                           col.name = c("Subject"))

#Read activity measurement data from "X_train.txt" in "train" folder
#using variable headings from measurementLabels third (descriptive) column
trainActivityData <- read.table("train/X_train.txt",
                                colClasses = "numeric",
                                comment.char = "",
                                col.name = measurementLabels[,3])

#combine Subject ID variable, Training Type ID and Description
#variable and measurement data variables
trainActivityData <- cbind(trainSubject, trainType, trainActivityData)


###
#           READING TEST DATA SECTION
###

#Read Training Type ID for each Activity recored in "X_test.txt"
#from "Y_test.txt" in "test" folder cast as numeric variables
testType <- read.table("test/Y_test.txt",
                       colClasses = "numeric",
                       col.name = c("TrainingID"))

#Add a column to testType of the description of training from
#activityDataLabels
#testType <- join(testType,
#                 activityDataLabels,
#                 by="TrainingID",
#                 type="left")

#Read Subject ID for each Activity recorded in "X_test.txt"
#from "subject_test.txt" in "test" folder cast as numeric variables
testSubject <- read.table("test/subject_test.txt",
                           colClasses = "numeric",
                           col.name = c("Subject"))

#Read activity measurement data from "X_test.txt" in "test" folder
#using variable headings from measurementLabels  third (descriptive) column
testActivityData <- read.table("test/X_test.txt",
                               colClasses = "numeric",
                               comment.char = "",
                               col.name = measurementLabels[,3])

#combine Subject ID variable, Test Type ID and Description
#variable and measurement data variables
testActivityData <- cbind(testSubject, testType, testActivityData)


#Combine training activity data and test activity data into activityData
activityData <- rbind(trainActivityData,
                      testActivityData)

#Remove temporary data from memory
remove(trainSubject,
       trainType,
       trainActivityData,
       testSubject,
       testType,
       testActivityData)


#Subset activityData with only subject, activity and mean/Mean/std measurements
activityData <- select(activityData, one_of(trainVars))


###
#Create Summary by Subject
###

#Split Activity Data into a list of dataframes by Subject number
subjectMeasurementData <- split(activityData, activityData$Subject)

#Create matrix of column means for each data frame in list of activity data by subject
subjectMeasurementDataMean <- sapply(subjectMeasurementData, colMeans)

#Transpose matrix of column means to put variables in columns, subjects in rows
subjectMeasurementDataMean <- t(subjectMeasurementDataMean)

#Remove column of means of Traning IDs as nonsense data
subjectMeasurementDataMean <- subset(subjectMeasurementDataMean, select = -c(TrainingID))

#Convert matrix of measurement means for each subjct to data frame
subjectMeasurementDataMean <- as.data.frame(subjectMeasurementDataMean)


###
#Create Summary by Activity
###

#Split Activity Data into a list of dataframes by Activity
activityMeasurementData <- split(activityData, activityData$TrainingID)

#Create matrix of column means for each data frame in list of activity data by activity
activityMeasurementDataMean <- sapply(activityMeasurementData, colMeans)

#Transpose matrix of column means to put variables in columns, activities in rows
activityMeasurementDataMean <- t(activityMeasurementDataMean)

#Remove column of means of Subject numbers as nonsense data
#Also remove TrainingIDs as we want Descriptive Training Types
activityMeasurementDataMean <- subset(activityMeasurementDataMean, select = -c(Subject, TrainingID))

#Add Training Types as first column, also converts to data.frame, Yea!
activityMeasurementDataMean <- cbind(activityDataLabels[2],
                                     activityMeasurementDataMean)

#Clean-up unneeded temporary data from memeory
remove(subjectMeasurementData,
       activityMeasurementData)


#Write Mean data of columns summary by subject and activity to files

write.table(subjectMeasurementDataMean,
            file="SubjectMeasurementDataMean.txt",
            row.name=FALSE)

write.table(activityMeasurementDataMean,
            file="ActivityMeasurementDataMean.txt",
            row.name=FALSE)


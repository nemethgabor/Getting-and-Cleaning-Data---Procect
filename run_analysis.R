
getwd()
[1] "\\\\DC02/Redirection/g.nemeth/Documents"
setwd("C:/Data Science/R/Getting and Cleaning Data/Assignment/UCI HAR Dataset/")

#1. Read the data into R
#a. Read the data from the train ordner
X_train<-read.table("./train/X_train.txt")
X_train<-read.table("./train/X_train.txt")
sub_train<-read.table("./train/subject_train.txt")

#b. Read the data from the test ordner
X_test<-read.table("./test/X_test.txt")
Y_test<-read.table("./test/y_test.txt")
sub_test<-read.table("./test/subject_test.txt")

#c. Read the data from the main ordner (features.txt and activity_labels.txt)
features<-read.table("./features.txt")
activityLabels<-read.table("./activity_labels.txt")

#d. Assign column names to the datas
colnames(X_train)<-features[,2]
colnames(Y_train)<-"activityId"
colnames(sub_train)<-"subId"
colnames(X_test)<-features[,2]
colnames(Y_test)<-"activityId"
colnames(sub_test)<-"subId"
colnames(activityLabels)<-c("activityId","activityType")  

#2. Merging data together
Traindata<-cbind(Y_train,sub_train,X_train)
Traindata<-cbind(Y_train,sub_train,X_train)
Testdata<-cbind(Y_test,sub_test,X_test)
alldata<-rbind(Traindata,Testdata)

#3. Use mean and standard deviation for each measurement
#a. Reading column names
alldata<-rbind(Traindata,Testdata)

#b. Create a logical vector for ID, mean and standard deviation
mean_and_std<-(grepl("activityId", colnames) |
                    grepl("subId", colnames) |
                    grepl("mean..", colnames) |
                    grepl("std..", colnames)
			
#c. Makeing a subset from alldata
tomean_and_std<-alldata[,mean_and_std==TRUE]
			
#4. Add descriptive names to the activities in tomean_and_std data
dataWithActivityNames<-merge(tomean_and_std,activityLabels, by="activityId", all.x = TRUE)

#5. Based on the data from the step 4 create a second independent tidy data set with the average of each variable for each activity and each subject

#a. Creating a new tidy data set
TidySet<-aggregate(.~subId+activityId, dataWithActivityNames,mean)
TidySet<-TidySet[order(TidySet$subId,TidySet$activityId),]
#b. Writing a second tidy data set in text (txt) format
write.table(TidySet, "TidySet.txt", row.names=FALSE)


#I use the following sources to my assignment
# 1. https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
# 2. https://rpubs.com/Zanin_Pavel/158283
# 3. https://github.com/rackaron/Cleaning-and-Getting-Data-Course-Project/blob/master/run_analysis.R






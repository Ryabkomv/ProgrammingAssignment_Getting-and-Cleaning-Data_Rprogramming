library(stringr)
library(plyr)
library(reshape2)
# creating object with all text files for test data
Files<-c(paste(".//UCI HAR Dataset//test//", list.files(".//UCI HAR Dataset//test")[2:4],sep=''), paste(".//UCI HAR Dataset//test//Inertial Signals//", list.files(".//UCI HAR Dataset//test//Inertial Signals") , sep="")) 

# if not exist, creation of the folder for the merged data
if(!file.exists('.//UCI HAR Dataset//total') {dir.create(".//UCI HAR Dataset//total")}
if(!file.exists('.//UCI HAR Dataset//total//Inertial Signals') {dir.create(".//UCI HAR Dataset//total//Inertial Signals")}

# mearging each test and training data and saving to total
for (i in 1:length(Files)) {
  temp_test <- (read.table(Files[i],header = FALSE))
  #replace teat for train in each filename
  temp_train <- (read.table(gsub("test", "train", Files[i]),header = FALSE))
  write.table(mapply(c, temp_test, temp_train, SIMPLIFY=FALSE), gsub("test", "total", Files[i]) , row.name=FALSE, col.names=FALSE)
}

#read activity data and activity labels
y_total<-(read.table('.//UCI HAR Dataset//total//y_total.txt',header = FALSE))
activity<-(read.table('.//UCI HAR Dataset//activity_labels.txt',header = FALSE))

#assign lables to activities
for (i in activity$V1){
  y_total[activity$V1[i] == y_total]=(as.character(activity$V2)[i])
}

#save activities
write.table(y_total, './/UCI HAR Dataset//total//y_total.txt', row.name=FALSE , col.names=FALSE) 

#read activity data and activity labels
X_total<-(read.table('.//UCI HAR Dataset//total//X_total.txt',header = FALSE))
features<-(read.table('.//UCI HAR Dataset//features.txt',header = FALSE))

#lowercase ans set column names
colnames(X_total)<-gsub("()", "", tolower(as.character(features$V2)), fixed = TRUE)

write.table(X_total, './/UCI HAR Dataset//total//X_total.txt', row.name=FALSE , col.names=FALSE) 

#extraction of the features on mean and std measurements
Data<-X_total[,grep("mean|std", tolower(as.character(features$V2)))]


subject <- (read.table('.//UCI HAR Dataset//total//subject_total.txt',header = FALSE))

tidy<-data.frame(subject=subject, activity=activity, data=Data)
K<-melt(tidy, id.vars=c("V1","V1.1"))
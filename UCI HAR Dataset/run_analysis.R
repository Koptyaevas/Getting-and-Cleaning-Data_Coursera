## 1. Merges the training and the test sets to create one data set.

train1 <- read.table("train/X_train.txt")
train2 <- read.table("test/X_test.txt")
new <- rbind(train1, train2)

train1 <- read.table("train/subject_train.txt")
train2 <- read.table("test/subject_test.txt")
new2 <- rbind(train1, train2)

train1 <- read.table("train/y_train.txt")
train2 <- read.table("test/y_test.txt")
new3 <- rbind(train1, train2)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

feat <- read.table("features.txt")
ok_feat <- grep("-mean\\(\\)|-std\\(\\)", feat[, 2])
X <- new[, ok_feat]
names(X) <- feat[ok_feat, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

## 3. Uses descriptive activity names to name the activities in the data set

activ <- read.table("activity_labels.txt")
activ[, 2] = gsub("_", "", tolower(as.character(activ[, 2])))
new3[,1] = activ[new3[,1], 2]
names(new3) <- "activity"

## 4. Appropriately labels the data set with descriptive variable names. 

names(new2) <- "subject"
clean <- cbind(new2, new3, new)
write.table(clean, "merge_clean_data.txt")

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(new2)[,1]
numSubjects = length(unique(new2)[,1])
numActivities = length(activ[,1])
numCols = dim(clean)[2]
result = clean[1:(numSubjects*numActivities), ]

row = 1
for (new2 in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[new2]
    result[row, 2] = activ[a, 2]
    tmp <- clean[clean$subject==new2 & clean$activ==activ[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "data_with_the_averages.txt")

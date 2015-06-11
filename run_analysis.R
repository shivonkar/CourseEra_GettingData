library(data.table)

setwd("D:/Projects/Analytics/CourseEra/DataScience/03_GettingData/Project")

y_train <- read.table("UCIHARDataset/train/y_train.txt")
x_train <- read.table("UCIHARDataset/train/x_train.txt")
subject_train <- read.table("UCIHARDataset/train/subject_train.txt")

y_test <- read.table("UCIHARDataset/test/y_test.txt")
x_test <- read.table("UCIHARDataset/test/x_test.txt")
subject_test <- read.table("UCIHARDataset/test/subject_test.txt")

features <- read.table("UCIHARDataset/features.txt")

colnames(x_train) <- t(features[2])
colnames(x_test) <- t(features[2])

x_train$activities <- y_train[, 1]
x_train$participants <- subject_train[, 1]
x_test$activities <- y_test[, 1]
x_test$participants <- subject_test[, 1]


#Part 1
Merge_train_test <- rbind(x_train, x_test)
Merge_train_test <- Merge_train_test[, !duplicated(colnames(Merge_train_test))]

# Part 2
Mean <- grep("mean()", names(Merge_train_test), value = FALSE, fixed = TRUE)
Merge_train_test_Mean <- Merge_train_test[Mean]

Std <- grep("std()", names(Merge_train_test), value = FALSE)
Merge_train_test_Mean_std <- Merge_train_test[Std]

#Part 3
Merge_train_test$activities <- as.character(Merge_train_test$activities)
Merge_train_test$activities[Merge_train_test$activities == 1] <- "Walking"
Merge_train_test$activities[Merge_train_test$activities == 2] <- "Walking Upstairs"
Merge_train_test$activities[Merge_train_test$activities == 3] <- "Walking Downstairs"
Merge_train_test$activities[Merge_train_test$activities == 4] <- "Sitting"
Merge_train_test$activities[Merge_train_test$activities == 5] <- "Standing"
Merge_train_test$activities[Merge_train_test$activities == 6] <- "Laying"
Merge_train_test$activities <- as.factor(Merge_train_test$activities)

#Part 4
names(Merge_train_test) <- gsub("Acc", "Accelerator", names(Merge_train_test))
names(Merge_train_test) <- gsub("Mag", "Magnitude", names(Merge_train_test))
names(Merge_train_test) <- gsub("Gyro", "Gyroscope", names(Merge_train_test))
names(Merge_train_test) <- gsub("^t", "time", names(Merge_train_test))
names(Merge_train_test) <- gsub("^f", "frequency", names(Merge_train_test))


Merge_train_test$participants <- as.character(Merge_train_test$participants)
Merge_train_test$participants[Merge_train_test$participants == 1] <- "Participant 1"
Merge_train_test$participants[Merge_train_test$participants == 2] <- "Participant 2"
Merge_train_test$participants[Merge_train_test$participants == 3] <- "Participant 3"
Merge_train_test$participants[Merge_train_test$participants == 4] <- "Participant 4"
Merge_train_test$participants[Merge_train_test$participants == 5] <- "Participant 5"
Merge_train_test$participants[Merge_train_test$participants == 6] <- "Participant 6"
Merge_train_test$participants[Merge_train_test$participants == 7] <- "Participant 7"
Merge_train_test$participants[Merge_train_test$participants == 8] <- "Participant 8"
Merge_train_test$participants[Merge_train_test$participants == 9] <- "Participant 9"
Merge_train_test$participants[Merge_train_test$participants == 10] <- "Participant 10"
Merge_train_test$participants[Merge_train_test$participants == 11] <- "Participant 11"
Merge_train_test$participants[Merge_train_test$participants == 12] <- "Participant 12"
Merge_train_test$participants[Merge_train_test$participants == 13] <- "Participant 13"
Merge_train_test$participants[Merge_train_test$participants == 14] <- "Participant 14"
Merge_train_test$participants[Merge_train_test$participants == 15] <- "Participant 15"
Merge_train_test$participants[Merge_train_test$participants == 16] <- "Participant 16"
Merge_train_test$participants[Merge_train_test$participants == 17] <- "Participant 17"
Merge_train_test$participants[Merge_train_test$participants == 18] <- "Participant 18"
Merge_train_test$participants[Merge_train_test$participants == 19] <- "Participant 19"
Merge_train_test$participants[Merge_train_test$participants == 20] <- "Participant 20"
Merge_train_test$participants[Merge_train_test$participants == 21] <- "Participant 21"
Merge_train_test$participants[Merge_train_test$participants == 22] <- "Participant 22"
Merge_train_test$participants[Merge_train_test$participants == 23] <- "Participant 23"
Merge_train_test$participants[Merge_train_test$participants == 24] <- "Participant 24"
Merge_train_test$participants[Merge_train_test$participants == 25] <- "Participant 25"
Merge_train_test$participants[Merge_train_test$participants == 26] <- "Participant 26"
Merge_train_test$participants[Merge_train_test$participants == 27] <- "Participant 27"
Merge_train_test$participants[Merge_train_test$participants == 28] <- "Participant 28"
Merge_train_test$participants[Merge_train_test$participants == 29] <- "Participant 29"
Merge_train_test$participants[Merge_train_test$participants == 30] <- "Participant 30"
Merge_train_test$participants <- as.factor(Merge_train_test$participants)

#Part 5
Merge_train_test <- data.table(Merge_train_test)
Tidy <- Merge_train_test[, lapply(.SD, mean), by = 'participants,activities']
write.table(Tidy, file = "Tidy.txt", row.names = FALSE)

install.packages("dplyr")

library(dplyr)

# 0.Utility functions

loaded = function(dataset, name) {
    message(paste("loaded dataset", name, nrow(dataset), ncol(dataset), sep = ":"))
}

load_X_DS = function(features, kind = "train") {
    setwd(paste0("./", kind))
    
    loaded(X_DS<-read.table(paste0("X_", kind, ".txt")), "X_")
    names(X_DS)<-features

    setwd("..")
    X_DS
}

load_y_subject_DS = function(X_DS, kind = "train") {
    setwd(paste0("./", kind))
    
    loaded(y_DS<-read.table(paste0("y_", kind, ".txt"), col.names = c("activityId")), "y_")
    loaded(subject_DS<-read.table(paste0("subject_", kind, ".txt"), col.names = c("subject")), "subject_")
    
    result_DS<-bind_cols(y_DS, subject_DS, X_DS)
    rm(y_DS, subject_DS)
    
    setwd("..")
    result_DS
}

load_signals_DS = function(X_DS, kind = "train") {
    setwd(paste0("./", kind,"/Inertial Signals"))
    
    body_acc_x_DS<-read.table(paste0("body_acc_x_", kind, ".txt")) %>% setNames(paste0('ba.x.', names(.)))
    body_acc_y_DS<-read.table(paste0("body_acc_y_", kind, ".txt")) %>% setNames(paste0('ba.y.', names(.)))
    body_acc_z_DS<-read.table(paste0("body_acc_z_", kind, ".txt")) %>% setNames(paste0('ba.z.', names(.)))
    loaded(body_acc_DS<-bind_cols(body_acc_x_DS, body_acc_y_DS, body_acc_z_DS), "body_acc_X/Y/Z")
    rm(body_acc_x_DS, body_acc_y_DS, body_acc_z_DS)
    
    body_gyro_x_DS<-read.table(paste0("body_gyro_x_", kind, ".txt")) %>% setNames(paste0('bg.x.', names(.)))
    body_gyro_y_DS<-read.table(paste0("body_gyro_y_", kind, ".txt")) %>% setNames(paste0('bg.y.', names(.)))
    body_gyro_z_DS<-read.table(paste0("body_gyro_z_", kind, ".txt")) %>% setNames(paste0('bg.z.', names(.)))
    loaded(body_gyro_DS<-bind_cols(body_gyro_x_DS, body_gyro_y_DS, body_gyro_z_DS), "body_gyro_X/Y/Z")
    rm(body_gyro_x_DS, body_gyro_y_DS, body_gyro_z_DS)
    
    total_acc_x_DS<-read.table(paste0("total_acc_x_", kind, ".txt")) %>% setNames(paste0('ta.x.', names(.)))
    total_acc_y_DS<-read.table(paste0("total_acc_y_", kind, ".txt")) %>% setNames(paste0('ta.y.', names(.)))
    total_acc_z_DS<-read.table(paste0("total_acc_z_", kind, ".txt")) %>% setNames(paste0('ta.z.', names(.)))
    loaded(total_acc_DS<-bind_cols(total_acc_x_DS, total_acc_y_DS, total_acc_z_DS), "total_acc_X/Y/Z")
    rm(total_acc_x_DS, total_acc_y_DS, total_acc_z_DS)
    
    result_DS<-bind_cols(X_DS, body_acc_DS, body_gyro_DS, total_acc_DS)
    rm(body_acc_DS, body_gyro_DS, total_acc_DS)

    setwd("../..")
    result_DS
}

load_features = function() {
    loaded(features<-read.table("features.txt", stringsAsFactors = F)[,2], "features")
    
    gsub("\\)","", gsub("\\(","_", gsub("\\(\\)","", gsub(",","_", gsub("-","_", tolower(features))))))
}

# 1.Merges the training and the test sets to create one data set.
message("Load train and test datasets")

setwd("../UCI HAR Dataset")

features<-load_features()
train_DS<-load_X_DS(features)
test_DS<-load_X_DS(features, kind="test")

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
message("Extract mean and standart deviation, and fuse train and test datasets")

selected_features <- grepl("mean|std", features)

train_DS<-train_DS[,selected_features]
train_DS<-load_y_subject_DS(train_DS)
train_DS$group = "train"

test_DS<-test_DS[,selected_features]
test_DS<-load_y_subject_DS(test_DS, kind = "test")
test_DS$group = "test"

dataset = rbind(train_DS, test_DS)
rm(train_DS, test_DS)

# 3.Uses descriptive activity names to name the activities in the data set
message("Set descriptive activity names")

activity_labels_DS<-read.table("activity_labels.txt", col.names = c("activityId","activity"))
dataset<-merge(dataset, activity_labels_DS)
rm(activity_labels_DS)

# 4.Appropriately labels the data set with descriptive variable names.
message("Last cleaning of variable names")

tidy_DS<-select(dataset, -activityId)

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
message("Summarize and finalize dataset")

final_tidy_DS<-tidy_DS %>%
    select(-group) %>%
    group_by(activity, subject) %>%
    summarise_all(mean)

# Submission
message("Write dataset")

write.table(final_tidy_DS, file = "./tidy_dataset.txt", row.name=F)

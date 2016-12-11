# Exercise 1

setwd("/Users/olivier/Documents/workspace/labor/education/coursera-data-science/week3_3")
if (!file.exists("data")) { dir.create("data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, method = "curl", destfile = "./data/Fss06hid.csv")
dateDownloaded <- date()
data<-read.csv("./data/Fss06hid.csv",header = T)

# Create a logical vector that identifies the households on greater than 10 acres
# who sold more than $10,000 worth of agriculture products.
agricultureLogical <- data$ACR == 3 & data$AGS == 6 # subsetting

# Assign that logical vector to the variable agricultureLogical.
data$agricultureLogical <- agricultureLogical

# Apply the which() function like this to identify the rows of the data frame where
# the logical vector is TRUE.
which(agricultureLogical) # dealing with missing values

# What are the first 3 values that result?
which(agricultureLogical)[1:3]

# -->[1] 125 238 262
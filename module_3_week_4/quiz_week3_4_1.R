# Exercise 1

setwd("/Users/olivier/Documents/workspace/labor/education/coursera-data-science/week3_4")
if (!file.exists("data")) { dir.create("data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, method = "curl", destfile = "./data/Fss06hid.csv")
data<-read.csv("./data/Fss06hid.csv",header = T)

# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
strsplit(names(data), "wgtp")
# What is the value of the 123 element of the resulting list?
#-->"" "15"


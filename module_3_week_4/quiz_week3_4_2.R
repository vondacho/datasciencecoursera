# Exercise 2

setwd("/Users/olivier/Documents/workspace/labor/education/coursera-data-science/week3_4")
if (!file.exists("data")) { dir.create("data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, method = "curl", destfile = "./data/FGDP.csv")
data<-read.csv("./data/FGDP.csv",header = T)

# Remove the commas from the GDP numbers in millions of dollars and average them
p<-data[data$X != "" & !data$Gross.domestic.product.2012 %in% c("",".. Not available."),]
mean(as.numeric(gsub(",","", p$X.3)))
#--[1] 377652.4


# Exercise 3

# How many countries begin with United?
length(grep("^United", data$X.2, useBytes = T))


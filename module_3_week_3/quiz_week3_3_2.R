# Exercise 2

install.packages("jpeg")
library(jpeg)

setwd("/Users/olivier/Documents/workspace/labor/education/coursera-data-science/week3_3")
if (!file.exists("data")) { dir.create("data") }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, method = "curl", destfile = "./data/Fjeff.jpg")
dateDownloaded <- date()

# Use the parameter native=TRUE.
data <- readJPEG("./data/Fjeff.jpg", native = T)

# What are the 30th and 80th quantiles of the resulting data?
# (some Linux systems may produce an answer 638 different for the 30th quantile)
quantile(data, c(0.3,0.8))

# -->       30%       80% 
# --> -15259150 -10575416 
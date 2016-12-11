# Exercise 4

setwd("/Users/olivier/Documents/workspace/labor/education/coursera-data-science/week3_4")
if (!file.exists("data")) { dir.create("data") }
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, method = "curl", destfile = "./data/FGDP.csv")
download.file(fileUrl2, method = "curl", destfile = "./data/FEDSTATS_Country.csv")
product<-read.csv("./data/FGDP.csv",header = T)
educational<-read.csv("./data/FEDSTATS_Country.csv",header = T)

# Match the data based on the country shortcode.
product$CountryCode <- product$X
m<-merge(product, educational, all = F)

# Of the countries for which the end of the fiscal year is available, how many end in June?
length(grep(pattern = "fiscal +year +end( *:)? *june", x = tolower(m$Special.Notes)))
#-->13




# Exercise 3

setwd("/Users/olivier/Documents/workspace/labor/education/coursera-data-science/week3_3")
if (!file.exists("data")) { dir.create("data") }

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, destfile = "./data/2FGDP.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/FEDSTATS_Country.csv", method = "curl")
product<-read.csv("./data/2FGDP.csv",header = T)
educational<-read.csv("./data/FEDSTATS_Country.csv",header = T)

# Match the data based on the country shortcode.
summary(educational)
summary(cp)
p<-product[product$X != "" & !products$Gross.domestic.product.2012 %in% c("",".. Not available."),]
p$CountryCode <- cp$X
m<-merge(p, educational, all = F)

# How many of the IDs match?
nrow(m) # --> [1] 189

# Sort the data frame in descending order by GDP rank (so United States is last).
m$GDP <- as.numeric(as.character(m$Gross.domestic.product.2012))
ms<-m[order(m$GDP, decreasing = T),]

# What is the 13th country in the resulting data frame?
ms[13,c("CountryCode", "Short.Name", "GDP")]
# -->   CountryCode          Short.Name GDP
# -->93         KNA St. Kitts and Nevis 178


# Exercise 4

# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
g<-m[m$Income.Group %in% c("High income: OECD","High income: nonOECD"),c("Income.Group","GDP")]
tapply(g$GDP, g$Income.Group, mean)[c("High income: OECD","High income: nonOECD")]
# --> High income: OECD High income: nonOECD 
# --> 32.96667             91.91304 


# Exercise 5

# Cut the GDP ranking into 5 separate quantile groups.
install.packages("Hmisc")
library(Hmisc)
m$GDPqg <- cut2(m$GDP,g=5)
# Make a table versus Income.Group.
ta<-table(m$GDPqg, m$Income.Group)
# How many countries are Lower middle income but among the 38 nations with highest GDP?
ta[1,"Lower middle income"] # -->5

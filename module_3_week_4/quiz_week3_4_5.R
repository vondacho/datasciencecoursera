# Exercise 5

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012?
sum(year(sampleTimes) == 2012)
#-->250

# How many values were collected on Mondays in 2012?
sum(format(sampleTimes, "%Y%a") == "2012Lun")
sum(year(sampleTimes) == 2012 & wday(sampleTimes) == 2)
#-->47
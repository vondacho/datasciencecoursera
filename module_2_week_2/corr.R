# Write a function that takes a directory of data files and a threshold for complete cases and
# calculates the correlation between sulfate and nitrate for monitor locations where the number
# of completely observed cases (on all variables) is greater than the threshold.

# The function should return a vector of correlations for the monitors that meet the threshold
# requirement. If no monitors meet the threshold requirement, then the function should return a
# numeric vector of length 0
corr <- function(directory, threshold = 0) {
    filenames <- list.files(directory)
    monitors <- cbind(1:length(filenames), NA)
    
    for (i in 1:length(filenames)) {
        path <- paste(directory, filenames[i], sep="/")
        data <- na.omit(read.csv(file=path, header = TRUE, sep=","))

        if (nrow(data) > threshold) {
            monitors[i,2] <- cor(data[,"sulfate"], data[,"nitrate"])
        }
    }
    result <- monitors[complete.cases(monitors),]
    if (nrow(result) > 0) result[,2]
    else numeric()
}
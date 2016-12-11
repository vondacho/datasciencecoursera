# reads a directory full of files and reports the number of completely observed cases in each data file.
# The function should return a data frame where the first column is the name of the file and the second
# column is the number of complete cases
complete <- function(directory, id=1:332) {
    files <- list.files(directory)
    filenames <- files[id]
    monitors <- cbind(id,0)
    for (i in 1:length(filenames)) {
        path <- paste(directory, filenames[i], sep="/")
        data <- read.csv(file=path, header = TRUE, sep=",")
        monitors[i,2] <- sum(complete.cases(data))
    }
    df<-data.frame(monitors)
    colnames(df) <- c("id","nobs")
    df
}
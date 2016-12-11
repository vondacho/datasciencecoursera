# calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors
polluantmean <- function(directory, polluant, id = 1:332) {
    files <- list.files(directory)
    filenames <- files[id]
    sumPolluantValues <- 0
    countPolluantValues <- 0    
    for (filename in filenames) {
        path <- paste(directory, filename, sep="/")
        data <- read.csv(file=path, header = TRUE, sep=",")
        polluantValues <- na.omit(data[polluant])
        if (nrow(polluantValues) > 0) {
            sumPolluantValues <- sumPolluantValues + sum(polluantValues)
            countPolluantValues <- countPolluantValues + nrow(polluantValues)
        }
    }
    sumPolluantValues / countPolluantValues
}
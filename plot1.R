plot1 <- function() {
    # Reading data from the text file
    # Only the necessary rows are loading into the memory (skip, nrows)
    data <- read.table("household_power_consumption.txt", 
                       sep=";", na.strings = "?",
                       skip = 66637, nrows=2880,
                       colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
    # As the skip parameter throw away the real header row
    # read only the header and apply the names to the data table
    names(data) <- names(read.table("household_power_consumption.txt",
                         header=TRUE, sep=";", nrows=1))
    # Combining the Date and Time columns into one single POSIX column
    data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
    # Deleting the Date and the Time columns
    data <- data[,3:10]
    png(filename = "plot1.png")
    hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
    dev.off()
}
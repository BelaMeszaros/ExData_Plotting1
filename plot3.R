plot3 <- function () {
    # I'm working on a computer with regional setting other than English
    # It is necessary to set for getting "Thu", "Fri" and "Sat"
    # on x-axis
    Sys.setlocale("LC_TIME", "US")
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
    png(filename = "plot3.png")
    # A plot with type="n" creates the chart area without plotting
    plot(data$DateTime, data$Sub_metering_1, type="n", main="", xlab="", ylab="Energy sub metering")
    # This is where the line charts are drawn
    lines(data$DateTime, data$Sub_metering_1)
    lines(data$DateTime, data$Sub_metering_2, col="red")
    lines(data$DateTime, data$Sub_metering_3, col="blue")
    # Legend with line: lty="solid"
    legend("topright",
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col=c("black","red", "blue"), lty= "solid")
    dev.off()
}
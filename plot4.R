plot4 <- function() {
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
    png(filename = "plot4.png")
    par(mfrow = c(2,2))
    # Subchart 1 (same as Plot2)
    plot(data$DateTime, data$Global_active_power, type="n", main="", xlab="", ylab="Global Active Power")
    lines(data$DateTime, data$Global_active_power)
    # Subchart 2
    plot(data$DateTime, data$Voltage, type="n", main="", xlab="datetime", ylab="Voltage")
    lines(data$DateTime, data$Voltage)
    # subchart 3 (same as Plot3, but w/o border around the legend)
    plot(data$DateTime, data$Sub_metering_1, type="n", main="", xlab="", ylab="Energy sub metering")
    lines(data$DateTime, data$Sub_metering_1)
    lines(data$DateTime, data$Sub_metering_2, col="red")
    lines(data$DateTime, data$Sub_metering_3, col="blue")
    legend("topright",
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col=c("black","red", "blue"), lty= "solid", bty ="n")
    # subchart4
    plot(data$DateTime, data$Global_reactive_power, type="n", main="", xlab="datetime", ylab="Global_reactive_power")
    lines(data$DateTime, data$Global_reactive_power)
    dev.off()
}
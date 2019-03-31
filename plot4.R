## setwd() to location of household_power_consumption.txt before running

# Read in parts of file we're interested in (approx. row 66000 - 70000)
consumption <- read.table(file = "household_power_consumption.txt", 
                          skip = 66000, 
                          nrows = 4000, 
                          sep = ";", 
                          na.strings = "?", 
                          colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
# Get the column names
consumption.names <- colnames(read.table(file = "household_power_consumption.txt",
                                         sep = ";",
                                         nrows = 1,
                                         header = TRUE))
colnames(consumption) <- consumption.names

# Add a DateTime column converted from Date and Time
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time), 
                                 format = "%d/%m/%Y %T")

# Subset data for Feb 1, 2007 - Feb 2, 2007
beginDate <- as.POSIXlt("2007-02-01")
endDate <- as.POSIXlt("2007-02-03")
graphData <- subset(consumption, DateTime >= beginDate)
graphData <- subset(graphData, DateTime < endDate)

# Set device to png
png("figure/plot4.png", 
    width = 480, 
    height = 480,
    bg = NA)

# Setup 2 rows and columns for plotting
par(mfrow = c(2,2))

# Plot top-left
plot(x = graphData$DateTime,
     y = graphData$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# Plot top-right
plot(x = graphData$DateTime,
     y = graphData$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Plot bottom-left
plot(x = graphData$DateTime, 
     y = graphData$Sub_metering_1, 
     type = "l",
     xlab = "", 
     ylab = "Energy sub metering")
lines(x = graphData$DateTime, 
      y = graphData$Sub_metering_2, 
      type = "l", 
      col = "red")
lines(x = graphData$DateTime, 
      y = graphData$Sub_metering_3, 
      type = "l", 
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1,
       bty = "n",
       cex = 0.95)

# Plot bottom-right
with(graphData, plot(x = DateTime,
     y = Global_reactive_power,
     type = "l",
     xlab = "datetime",
     lwd = 0.2))

# Shut down the png device
dev.off()
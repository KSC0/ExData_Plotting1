## setwd() to location of household_power_consumption.txt before running

# Read in parts of file we're interested in
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
png("figure/plot1.png", 
    width = 480, 
    height = 480,
    bg = NA)

# Plot histogram
hist(graphData$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Shut down the png device
dev.off()
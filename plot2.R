## setwd() to location of household_power_consumption.txt before running

# Explicitly set date and time to character
columnClasses <- c(Date = "character", Time = "character")
# Read in file 
consumption <- read.table(file = "household_power_consumption.txt",
                          header = TRUE,
                          sep = ";",
                          na.strings = "?",
                          colClasses = columnClasses)

# Approximately remove data outside range we're interested in
consumption <- consumption[66000:70000,]

# Add a DateTime column converted from Date and Time
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time), 
                                 format = "%d/%m/%Y %T")

# Subset data for Feb 1, 2007 - Feb 2, 2007
beginDate <- as.POSIXlt("2007-02-01")
endDate <- as.POSIXlt("2007-02-03")
graphData <- subset(consumption, DateTime >= beginDate)
graphData <- subset(graphData, DateTime < endDate)

# Set device to png
png("figure/plot2.png", 
    width = 480, 
    height = 480,
    bg = NA)

# Plot
plot(x = graphData$DateTime, 
     y = graphData$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# Shut down the png device
dev.off()
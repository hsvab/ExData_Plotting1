# Downloading database
# Download the zip file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzip it your working directory.

library(datasets)

#Reading Data
data = read.table('household_power_consumption.txt', header=TRUE, sep=';', na.strings="?")

# Merging Date and Time variables
data$DT <- paste(data$Date, data$Time, sep=' ')

# Converting the DT string into a Date/Time field
data$DT <- strptime(data$DT, format='%d/%m/%Y %H:%M:%S')

#Filtering Data
filtered_data <- data[data$DT >= '2007-02-01' & data$DT < '2007-02-03', ]

#Opening PNG device; create 'plot1.png' in my working directory
png(file = "plot1.png") 

#Drawing the Histogram
hist(as.numeric(filtered_data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Closing de the PNG device
dev.off()

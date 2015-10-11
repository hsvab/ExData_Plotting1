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

#Transforming into Weekdays
Sys.setlocale(category="LC_TIME", locale="C")
filtered_data$dia_da_semana <- weekdays(filtered_data$DT)

#Opening PNG device; create 'plot1.png' in my working directory
png(file = "plot3.png") 

#Drawing the 3 Scatterplot in overlay
plot(filtered_data$DT, filtered_data$Sub_metering_1, col = "black", type = "l", xlab="", ylab = "Energy sub metering")
lines(filtered_data$DT, filtered_data$Sub_metering_2, col = "red", type="l", xlab = "", ylab = "")
lines(filtered_data$DT, filtered_data$Sub_metering_3, col = "blue", type="l", xlab = "", ylab = "")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

#Closing de the PNG device
dev.off()

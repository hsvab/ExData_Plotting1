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

#Opening PNG device; create 'plot4.png' in my working directory
png(file = "plot4.png") 

#Defining a grid of two rows and two columns
par(mfrow = c(2,2))

#Plotting Graph 1
with(filtered_data, plot(DT, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#Plotting Graph 2
with(filtered_data, plot(DT, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))

#Plotting Graph 3
plot(filtered_data$DT, filtered_data$Sub_metering_1, col = "black", type = "l", xlab="", ylab = "Energy sub metering")
lines(filtered_data$DT, filtered_data$Sub_metering_2, col = "red", type="l", xlab = "", ylab = "")
lines(filtered_data$DT, filtered_data$Sub_metering_3, col = "blue", type="l", xlab = "", ylab = "")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty='n', cex=.75)

#Plotting Graph 4
with(filtered_data, plot(DT, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power"))

#Closing de the PNG device
dev.off()

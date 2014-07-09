## Code for EDA Week 1 Project
## This scrip needs to be where the zip file is stored

unzip("exdata-data-household_power_consumption.zip") ##unzip file
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")) ##read the whole file

## combine date and time and convert to R format
data$dateTime <- paste(data$Date, data$Time)
data$dateTime <- strptime(data$dateTime, format = "%d/%m/%Y %H:%M:%S")

## extracting just the dates of interest
data$Date <- as.Date(data$Date, format="%d/%m/%Y") ##converting to date from character
subdata <- subset(data, (data$Date=="2007-02-01" | data$Date=="2007-02-02"))

par(mfrow=c(2,2))

with(subdata, {
	plot(subdata$dateTime, subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)") ## plot line chart

	plot(subdata$dateTime, subdata$Voltage, type="l", xlab="datetime", ylab="Voltage")

	plot(subdata$dateTime, subdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	with(subdata, points(subdata$dateTime, subdata$Sub_metering_2, type="l", col="red"))
	with(subdata, points(subdata$dateTime, subdata$Sub_metering_3, type="l", col="blue"))
	legend("topright", pch="___", col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	
	plot(subdata$dateTime, subdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})

## send to png device
dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()

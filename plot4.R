library(data.table)
library(dplyr)

# Set the URL of the zip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Set the file names
zip_file <- "household_power_consumption.zip"
text_file <- "household_power_consumption.txt"

if (!file.exists(zip_file)) {
  # Download the zip file
  download.file(url, destfile = zip_file)
  # Unzip the data file from the zip file
  unzip(zip_file, text_file)
}

# Load the data into a data table
library(data.table)
data <- fread("household_power_consumption.txt", header = TRUE, sep = ";")

# Convert ? to NA
data[data == "?"] <- NA

# Convert the Date variable to a date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Filter the data to include only rows from 2007-02-01 and 2007-02-02
data_filtered <- data[Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

# Convert sub metering to a numeric
data_filtered$Global_active_power <- as.numeric(data_filtered$Global_active_power)
data_filtered$Global_reactive_power <- as.numeric(data_filtered$Global_reactive_power)
data_filtered$Sub_metering_1 <- as.numeric(data_filtered$Sub_metering_1)
data_filtered$Sub_metering_2 <- as.numeric(data_filtered$Sub_metering_2)
data_filtered$Sub_metering_3 <- as.numeric(data_filtered$Sub_metering_3)


par(mfrow=c(2,2))
with(data_filtered, {
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Global_active_power,type="l",ylab="Global Active Power",xlab="")
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
  lines(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Sub_metering_2,type="l",col="red")
  lines(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Sub_metering_3,type="l",col="blue")
  legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,lty=1,bty = "n",cex=1)
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Global_reactive_power,type="l",ylab="global_reactive_power",xlab="datetime")
  
})

png(file="plot4.png")
par(mfrow=c(2,2))
with(data_filtered, {
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Global_active_power,type="l",ylab="Global Active Power",xlab="")
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
  lines(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Sub_metering_2,type="l",col="red")
  lines(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Sub_metering_3,type="l",col="blue")
  legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,lty=1,bty = "n",cex=1)
  plot(strptime(paste(data_filtered$Date,data_filtered$Time),"%Y-%m-%d %H:%M:%S"),Global_reactive_power,type="l",ylab="global_reactive_power",xlab="datetime")
  
})
dev.off()

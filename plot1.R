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

data_filtered$Global_active_power <- as.numeric(data_filtered$Global_active_power)


par(mfrow=c(1,1))
with(data_filtered,hist(Global_active_power,col="red",main = "Global Active Power",xlab="Global Active Power (kilowatts)"))

png(file="plot1.png")
with(data_filtered,hist(Global_active_power,col="red",main = "Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()
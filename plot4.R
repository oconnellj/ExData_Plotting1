## This script assumes that the data is in a zip file
## in the local directory. First steps are to unzip the
## file and read the data, in csv format, into a table

fname <- "exdata_data_household_power_consumption.zip"

if (!file.exists(fname))
	print("Cannot find zip data file in local directory")

unzip(fname)

## After unzipping, the raw data is in the .txt file

fname <- "household_power_consumption.txt"
f <- file(fname, open = "r")
cs <- read.csv2(f, header = TRUE)
close(f)

## Extract those rows of the table that have a date
## of either 2007-02-01 or 2007-02-02.

cs$Date <- as.Date(cs$Date, "%d/%m/%Y")
x <- cs[cs$Date == "2007-02-01" | cs$Date == "2007-02-02",]

## Merge the date and time values into a single set of data
BB <- paste(x$Date, x$Time)

## Use strptime() to set the format of the merged data
strptime(BB, "%Y-%m-%d %H:%M:%S")

## Load the graphics and grDevices packages

library(graphics)
library(grDevices)

## Open the plot4.png file
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
plot(as.POSIXct(BB), as.numeric(as.character(x$Global_active_power)), 
	type = "l", xlab = "", ylab = "Global Active Power")
plot(as.POSIXct(BB), as.numeric(as.character(x$Voltage)), 
	type = "l", xlab = "", ylab = "Voltage", sub = "datetime")
plot(as.POSIXct(BB), as.numeric(as.character(x$Sub_metering_1)), 
	type = "l", xlab = "", ylab = "Energy sub metering")
points(as.POSIXct(BB),as.numeric(as.character(x$Sub_metering_2)), 
	type = "l", col = "red")
points(as.POSIXct(BB),as.numeric(as.character(x$Sub_metering_3)), 
	type = "l", col = "blue")
plot(as.POSIXct(BB), as.numeric(as.character(x$Global_reactive_power)), 
	type = "l", xlab = "", ylab = "Global_reactive_power", sub = "datetime")

## Close the png file

dev.off()
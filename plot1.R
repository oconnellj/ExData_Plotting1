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

## Load the graphics and grDevices packages

library(graphics)
library(grDevices)

## Open the plot1.png file
png(filename = "plot1.png", width = 480, height = 480)

## Plot a histogram of the data in the 
## Global_active_power column, in red

hist(as.numeric(as.character(x$Global_active_power)), 
	col = "red", 
	xlab = "Global Active Power (kilowatts)", 
	main = "Global Active Power")

## Close the png file

dev.off()
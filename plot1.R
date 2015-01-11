## Opens data file and plots the Frequency of Global Active Power

## Install data.tabe package if not already installed
package <- c("data.table")
new.package <- package[!(package %in% installed.packages()[,"Package"])]
if(length(new.package)) install.packages(new.package) 
library(data.table)

## Read needed data from data directory in current working directory
file <- "./data/household_power_consumption.txt"

## Read 1st row to use to create character vector of column names
DTNames <- read.table(file, sep=";", nrows=1)

## Read in only the needed data
dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread(file, skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))

## Set column names that were lost during fread
newNames <- as.character(as.matrix(DTNames))
setnames(DT,newNames)

## Create plot1.png
png(filename="plot1.png",width = 480, height = 480, units = "px")
hist(DT[,Global_active_power],main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()
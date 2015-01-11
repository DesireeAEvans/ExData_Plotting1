## Opens data file and plots the Frequency of Global Active Power, Voltage
## Energy sub metering, and Global reactive power

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

## Combine Date and Time to create one vector for x values
  x <- as.POSIXct(paste(DT[,Date],DT[,Time]), format="%d/%m/%Y %H:%M:%S")
    
  y <- DT[,Global_active_power]
  
  z <- DT[,Voltage]
  
  a <- DT[,Sub_metering_1]
  b <- DT[,Sub_metering_2]
  c <- DT[,Sub_metering_3]
  
  w <- DT[,Global_reactive_power]

## Create plot4.png
  png(filename="plot4.png",width = 480, height = 480, units = "px")
  par(mfrow=c(2,2))
  
    plot(x,y,type="l",xlab="",ylab="Global Active Power")
  
    plot(x,z,type="l",xlab="datetime",ylab="Voltage")
  
    plot(x,a,type="l",xlab="",ylab="Energy sub metering",col="black")
    lines(x,b,type="l",col="red")
    lines(x,c,type="l",col="blue")
    legend("topright", legend=newNames[7:9],bty="n",lty=c(1,1),col=c("black","red","blue"))

    plot(x,w,type="l",xlab="datetime",ylab="Global_reactive_power")
  
  dev.off()
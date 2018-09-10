# Set default directory
setwd("C:\\Rprograms\\ExploritoryData")

#get and unzip file
zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

#make dataframe by importing unzip raw data file
electricdata <- read.table(file.path(tempdir(), "/myzip/household_power_consumption.txt"), sep=";", header= TRUE)

#add column for date and time to use function on 
electricdata$newdatetime <- as.Date(paste(electricdata$Date, electricdata$Time), format="%d/%m/%Y %H:%M:%S")

#make tidyset to use to plot graphs
tidyset <- subset(electricdata, electricdata$newdatetime==as.Date("2007-02-01") | electricdata$newdatetime==as.Date("2007-02-02"))

#create plot
hist((as.numeric(tidyset$Global_active_power) / 1000)
     , xlab="Global Active Power (kilowatts)"
     , col="Red"
     , main="Global Active Power"
    # , axis(1, at=seq(0,6,by=2), labels=seq(0,6,by=2) )
     , xlim=c(0,6)
    # , ylim=c(0,1200)
     , breaks=15
    )
dev.copy(png, "plot1.png")
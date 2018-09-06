library("dplyr")
setwd("C:\\Rprograms\\ExploritoryData")

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

electricdata <- read.table(file.path(tempdir(), "/myzip/household_power_consumption.txt"), sep=";", header= TRUE)

#add column for date and time to use function on 
electricdata$newdatetime <- as.Date(paste(electricdata$Date, electricdata$Time), format="%d/%m/%Y %H:%M:%S")
#electricdata$newdate <- as.Date(electricdata$Date, format="%d/%m/%y")
#electricdata$newtime <- as.POSIXct(strptime(electricdata$Time, "%H:%M:%S"))

tidyset <- subset(electricdata, newdatetime==as.Date("2007-02-01") | newdatetime==as.Date("2007-02-02"))


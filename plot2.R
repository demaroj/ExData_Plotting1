# Set default directory
setwd("C:\\Rprograms\\ExploritoryData")

#get and unzip file
zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

#make dataframe by importing unzip raw data file
electricdata <- read.table(file.path(tempdir(), "/myzip/household_power_consumption.txt"), sep=";", header= TRUE)

#add column for date and time to use function on 
electricdata$newdatetime <- as.POSIXct(paste(electricdata$Date, electricdata$Time), format="%d/%m/%Y %H:%M:%S")
#make tidyset to use to plot graphs
tidydata <- (subset(electricdata, electricdata$newdatetime > "2007-02-01"))
#make tidyset to use to plot graphs
#tidyset <- subset(electricdata, electricdata$Date==as.Date("2007-02-01") | electricdata$Date==as.Date("2007-02-02"))
tidydata <- (subset(tidydata, tidydata$newdatetime < "2007-02-03"))

plot(tidydata$newdatetime, (as.numeric(tidydata$Global_active_power) / 1000)
     ,ylab="Global Active Power (kilowatts)"
     ,xlab="Day of Week"
     ,type="l"
     ,col="blue"
     ,ylim=c(0,6)
     )
dev.copy(png, "plot2.png")

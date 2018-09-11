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


par(mfrow=c(2,2))

#create plot a
hist((as.numeric(tidydata$Global_active_power) / 1000)
     , xlab="Global Active Power (kilowatts)"
     , col="Red"
     , main="Global Active Power"
     # , axis(1, at=seq(0,6,by=2), labels=seq(0,6,by=2) )
     , xlim=c(0,6)
     # , ylim=c(0,1200)
     , breaks=15
)

#create plot b
plot(tidydata$newdatetime, (as.numeric(tidydata$Voltage))
     ,ylab="Voltage"
     ,xlab="datetime"
     ,type="l"
     ,col="black"
     
)

#create plot c
x<-tidydata$newdatetime
y1<-as.numeric(tidydata$Sub_metering_1)
y2<-as.numeric(tidydata$Sub_metering_2)
y3<-as.numeric(tidydata$Sub_metering_3)
#plot graph
plot(x,y1,type="l", col="brown", ylab="Energy sub metering", xlab="datetime", cex.lab=0.75)
lines(x,y2,col="red")
lines(x,y3,col="blue")

#legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1:2, col=c("brown","red","blue"), box.col="orange")

#create plot d
plot(tidydata$newdatetime, (as.numeric(tidydata$Global_reactive_power))
     ,ylab="Global_reactive_power"
     ,xlab="datetime"
     ,type="l"
     ,col="black"
     )
dev.copy(png, "plot4.png")

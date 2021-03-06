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
tidydata <- (subset(electricdata, electricdata$newdatetime >= "2007-02-01"))
#make tidyset to use to plot graphs
#tidyset <- subset(electricdata, electricdata$Date==as.Date("2007-02-01") | electricdata$Date==as.Date("2007-02-02"))
tidydata <- (subset(tidydata, tidydata$newdatetime < "2007-02-03"))

#plot graphs in 2x2 panel
par(mfrow=c(2,2))

#create plot a
plot(tidydata$newdatetime,(as.numeric(as.character(tidydata$Global_active_power)))
     #, xlab="Global Active Power (kilowatts)"
     , col="black"
     , type="l"
     , xlab=""
     , ylab="Global Active Power"
     # , axis(1, at=seq(0,6,by=2), labels=seq(0,6,by=2) )
     # xlim=c(0,6)
     # , ylim=c(0,1200)
     #, breaks=15
)

#create plot b
plot(tidydata$newdatetime, as.numeric(as.character(tidydata$Voltage))
     ,ylab="Voltage"
     ,xlab="datetime"
     ,type="l"
     ,col="black"
     
)

#create plot c
x<-tidydata$newdatetime
y1<-as.numeric(as.character(tidydata$Sub_metering_1))
y2<-as.numeric(as.character(tidydata$Sub_metering_2))
y3<-as.numeric(as.character(tidydata$Sub_metering_3))

#plot graph
plot(x,y1,type="l", col="black", ylab="Energy sub metering",  xlab="")
lines(x,y2,col="red")
lines(x,y3,col="blue")

legend("topright",inset=0.01,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.col="white", lty=1, col=c("black","red","blue"), cex=0.75)

#create plot d
plot(tidydata$newdatetime, as.numeric(as.character(tidydata$Global_reactive_power))
     ,ylab="Global_reactive_power"
     ,xlab="datetime"
     ,type="l"
     ,col="black"
     )
dev.copy(png, "plot4.png")

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

x<-tidydata$newdatetime
y1<-as.numeric(as.character(tidydata$Sub_metering_1))
y2<-as.numeric(as.character(tidydata$Sub_metering_2))
y3<-as.numeric(as.character(tidydata$Sub_metering_3))


#plot graph
plot(x,y1,type="l", col="black", ylab="Energy sub metering",  xlab="", cex.lab=0.75)
lines(x,y2,col="red")
lines(x,y3,col="blue")

legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"), box.col="black")

dev.copy(png, "plot3.png")

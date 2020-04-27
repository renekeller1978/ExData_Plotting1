
## Load & unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power cons.zip")
unzip("power cons.zip")

##Read table
powerdatabig <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE,na.strings = "?",stringsAsFactors = FALSE)

##Filter out 1/2/2007 and 2/2/2007
powerdata<-powerdatabig[
  as.Date(powerdatabig[,"Date"], "%d/%m/%Y")==as.Date("01/02/2007", "%d/%m/%Y") | 
    as.Date(powerdatabig[,"Date"], "%d/%m/%Y")==as.Date("02/02/2007", "%d/%m/%Y"),]

##Create combined Date/Time as String
timeString<-paste(powerdata$Date,powerdata$Time)

##Convert into proper Time/Date format
timeDate<-strptime(timeString,"%d/%m/%Y %H:%M:%S")

##Create Grid
par(mfrow=c(2,2))

######################Top left plot#######################################

##Plot the graph
plot(timeDate,type="l",powerdata$Global_active_power,ylab="Global Active Power",xlab="")

######################Top right plot######################################

##Plot the graph
plot(timeDate,type="l",powerdata$Voltage,ylab="Voltage",xlab="datetime")

######################Bottom left plot####################################

##plot initial line for sub metering 1 in black
plot(timeDate,type="l",powerdata$Sub_metering_1,ylab="Energy sub metering",xlab="")

##plot 2nd line for sub metering 2 in red
lines(timeDate,powerdata$Sub_metering_2,type="l",col="red")

##plot 3rd line for sub metering 3 in blue
lines(timeDate,powerdata$Sub_metering_3,type="l",col="blue")

##Add the legend
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=c(1,1,1)
)

######################Bottom right plot###################################

##Plot the graph
plot(timeDate,type="l",powerdata$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime")


##Create png file
dev.copy(png,file="plot4.png")
dev.off()
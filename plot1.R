
## Load & unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power cons.zip")
unzip("power cons.zip")

##Read table
powerdatabig <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE,na.strings = "?",stringsAsFactors = FALSE)

##Filter out 1/2/2007 and 2/2/2007
powerdata<-powerdatabig[
    as.Date(powerdatabig[,"Date"], "%d/%m/%Y")==as.Date("01/02/2007", "%d/%m/%Y") | 
    as.Date(powerdatabig[,"Date"], "%d/%m/%Y")==as.Date("02/02/2007", "%d/%m/%Y"),]

##Do the histogram
hist(powerdata$Global_active_power,
      main="Global Active Power",
      xlab="Global Active Power (kilowatts)",
      col="red",
      ylim=c(0,1200)
     )

##Create png file
dev.copy(png,file="plot1.png")
dev.off()


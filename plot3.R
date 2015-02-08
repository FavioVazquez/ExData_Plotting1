#Make sure that the this packages are installed. If not use
#install.packages("data.table")

#Make sure you are in the directory where the file
#household_power_consumption.txt is.

require(data.table)
#read the file
DT <- fread("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
#Convert Date and Time variables into DateTime
DT$DateTime <- paste(DT$Date, DT$Time)
#Give format to DateTime varaible
strptime(DT$DateTime, "%d/%m/%Y %H:%M:%S")

#Subset Data
DTsubset <- subset(DT, as.Date(DateTime) >= "01/02/2007 00:00:00" 
                   & as.Date(DateTime) < "02/02/2007 00:00:00")

#Making the plot
DTsubset<-DTsubset[!(DTsubset$Sub_metering_1=="?"),]
DTsubset<-DTsubset[!(DTsubset$Sub_metering_2=="?"),]
DTsubset<-DTsubset[!(DTsubset$Sub_metering_3=="?"),]

par(cex=.85,cex.axis=.85,cex.lab=.85)

with(DTsubset,plot(DateTime,Sub_metering_1,type="l",
                 xlab=NA,ylab="Energy sub metering",yaxt="n"))

with(DTsubset,lines(DateTime,Sub_metering_2,col="red"))

with(DTsubset,lines(DateTime,Sub_metering_3,col="blue"))

axis(2,at=c(0,10,20,30))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.85)

#Saving in png format
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()

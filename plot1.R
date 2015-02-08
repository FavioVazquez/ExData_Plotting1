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
par(cex=.85,cex.axis=.85,cex.lab=.85,cex.main=1)
DTsubset[,Global_active_power:= as.numeric(Global_active_power)]
hist(DTsubset$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

#Saving in png format
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()

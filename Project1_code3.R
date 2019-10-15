getwd()
setwd("C:/Users/William/Desktop/DSToolbox/ExploratoryDataAnalysisCourse/ExData_Plotting1")
getwd()

##Reads the data from file and then creates subsets data for specified the dates
powerdtable <- data.table::fread(input = "household_power_consumption.txt"
                                 , na.strings="?"
)

##This is to prevent the data from being read in Scientific Notation
powerdtable[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

##This code is to create POSIXct date to be filtered and graphed by time of day
powerdtable[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

##Filter data whose dates are between 2007-02-01 and 2007-02-02
powerdtable <- powerdtable[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

##Create a png file to store our plot
png("plot3.png", width=480, height=480)

##Create a Plot of the data under the png file and turn the Graphic Device off
plot(powerdtable[, dateTime], powerdtable[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerdtable[, dateTime], powerdtable[, Sub_metering_2],col="red")
lines(powerdtable[, dateTime], powerdtable[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
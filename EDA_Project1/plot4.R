library(data.table)
library(lubridate)

textfile <- paste0(getwd(),"/exdata_data_household_power_consumption/household_power_consumption.txt")
#Reads in data & subsets for specified dates
powerDT <- fread(input = textfile
                 , na.strings="?")
powerDT[, Global_active_power := lapply(.SD, as.numeric)
        , .SDcols = c("Global_active_power")] # Prevent scientific notation

powerDT$Date <- dmy(powerDT$Date)
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")] # Filter Dates
powerDT$dateTime <- as.POSIXct(paste0(powerDT$Date,powerDT$Time))

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(powerDT[, dateTime]
     , powerDT[, Global_active_power]
     , type="l", xlab=""
     , ylab="Global Active Power")

# Plot 2
plot(powerDT[, dateTime]
     ,powerDT[, Voltage]
     , type="l", xlab="datetime"
     , ylab="Voltage")

# Plot 3
plot(powerDT[, dateTime]
     , powerDT[, Sub_metering_1]
     , type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime]
      , powerDT[, Sub_metering_2], col="red")
lines(powerDT[, dateTime]
      , powerDT[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1) , bty="n", cex=.5) 

# Plot 4
plot(powerDT[, dateTime]
     , powerDT[,Global_reactive_power]
     , type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
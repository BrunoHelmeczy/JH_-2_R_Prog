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

png("plot2.png", width=480, height=480) # Create PNG

## Plot 2
plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)"
     ,xlim =)

dev.off()

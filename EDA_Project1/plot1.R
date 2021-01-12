library(data.table)

textfile <- paste0(getwd(),"/exdata_data_household_power_consumption/household_power_consumption.txt")
#Reads in data & subsets for specified dates
powerDT <- fread(input = textfile
                 , na.strings="?")
powerDT[, Global_active_power := lapply(.SD, as.numeric)
        , .SDcols = c("Global_active_power")] # Prevent scientific notation

powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")] # Change to Date Type

powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")] # Filter Dates
png("plot1.png", width=480, height=480) # Create PNG

## Plot 1
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()

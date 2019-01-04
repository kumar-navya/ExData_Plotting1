# script to build Plot 4

# data file household_power_consumption.txt has been 
# unzipped into workng directory

# identify rows to keep, i.e. those starting with date 1/2/2007 or 2/2/2007

tokeep <- grep("^1/2/2007|^2/2/2007",readLines("household_power_consumption.txt"))

# reading in only chosen subset

chosenData <- read.table("household_power_consumption.txt", sep=";",skip=tokeep[1]-1, nrows=length(tokeep), stringsAsFactors = FALSE)

# naming columns of dataset
# names are taken from original description, 
# but all in lower case and no underscore

names(chosenData) <- c("date", "time", "globalactivepower", "globalreactivepower", "voltage", "globalintensity", "submetering1", "submetering2", "submetering3")

# adding a date-time column by concatenating date and time fields
# and converting to POSIXlt
chosenData$datetime <- paste(chosenData$date,chosenData$time,sep=" ")
chosenData$datetime <- strptime(chosenData$datetime, format="%d/%m/%Y %H:%M:%S")

# creating plot 4 and saving to png file

# setting display area into a 2x2 grid for 4 plots
par(mfrow = c(2,2), mar=c(4, 4, 1, 1))

# first plot
with(chosenData, plot(datetime, globalactivepower, type="l", xlab = "", ylab = "Global Active Power (killowatts)"))

# second plot
with(chosenData, plot(datetime, voltage, type="l", xlab = "datetime", ylab = "Voltage"))

# third plot
with(chosenData, {
  plot(datetime, submetering1, type="l", xlab = "", ylab = "Energy sub metering", col = "black")
  points(datetime,submetering2, type ="l", col="red")
  points(datetime,submetering3, type ="l", col="blue")
  legend("topright", pch = "_", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n", cex = 0.8, y.intersp = 0.6)
})

# fourth plot
with(chosenData,plot(datetime, globalreactivepower, type = "l", xlab = "datetime", ylab="Global_reactive_power"))
dev.copy(png, file="plot4.png")
dev.off()
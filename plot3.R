# script to build Plot 3

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

# creating plot 3 and saving to png file
png(filename = "plot3.png", width = 480, height = 480)
with(chosenData, {
  plot(datetime, submetering1, type="l", xlab = "", ylab = "Energy sub metering", col = "black")
  points(datetime,submetering2, type ="l", col="red")
  points(datetime,submetering3, type ="l", col="blue")
  legend("topright", pch = "_", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
})
dev.off()
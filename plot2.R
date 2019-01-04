# script to build Plot 2

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

# creating plot 2 and saving to png file
with(chosenData, plot(datetime, globalactivepower, type="l", xlab = "", ylab = "Global Active Power (killowatts)"))

dev.copy(png, file="plot2.png")
dev.off()
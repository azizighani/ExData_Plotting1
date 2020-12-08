library("data.table")

# Specify Working Directory
setwd("C:/Users/azizi/Desktop/4. Exploratory Data Analysis/Week 1/6. Course Project 1/")

# Specify URL where file is stored
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Specify destination where file should be saved
#destfile <- "C:/Users/azizi/Desktop/4. Exploratory Data Analysis/Week 1/6. Course Project 1/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Apply download.file function in R
#download.file(url, destfile)

# Unzipping the file
#unzip(zipfile="C:/Users/azizi/Desktop/4. Exploratory Data Analysis/Week 1/6. Course Project 1/exdata%2Fdata%2Fhousehold_power_consumption.zip")

EPCdatasets <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
EPCdatasets$Date <- as.Date(EPCdatasets$Date, "%d/%m/%Y")

## Selecting specific range from the datasets
EPCdatasets <- subset(EPCdatasets,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Return a logical vector indicating which cases are complete, i.e., have no missing values.
EPCdatasets <- EPCdatasets[complete.cases(EPCdatasets),]

## Combining the Date and Time column
dateTime <- paste(EPCdatasets$Date, EPCdatasets$Time)

## Naming the new combined vector
dateTime <- setNames(dateTime, "DateTime")

## Removing the given Date and Time column
EPCdatasets <- EPCdatasets[ ,!(names(EPCdatasets) %in% c("Date","Time"))]

## Combining the DateTime column into the datasets
EPCdatasets <- cbind(dateTime, EPCdatasets)

## Setting default for UTC
EPCdatasets$dateTime <- as.POSIXct(dateTime)

# Preparing plot
png("plot2.png", width=480, height=480)

# Plotting Plot 2
plot(EPCdatasets$Global_active_power~EPCdatasets$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()


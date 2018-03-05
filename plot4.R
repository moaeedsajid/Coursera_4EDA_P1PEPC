# Coursera EDA Week 1
# Plot 4
# Moaeed Sajid
# 
# V1.0 4th Feb 2007

# Clear any existing environment values
rm (list = ls())

# Set this to 1 to keep any objects in environment for debugging
debugmode <- "0"

dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localZip <- "UciEpcDs.zip"

if (file.exists(localZip)) {
        print("Local copy of file exists so will not download again")
} else {
        print("File is missing, will download")
        download.file(dataurl,localZip,method = "auto")       
}

unzip(localZip)

# Load one percent of the dataset and calulate total size required for complete
firstread <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, nrows = 20753)
totalmem <- format(object.size(firstread) * 100, units = "auto") 
print(paste("Total dataset memory required is estimated at ",totalmem ))

# Clean environment for efficiency
if (debugmode == "0") {
        rm(firstread, dataurl, localZip, totalmem)      
}


# Identify the rows that contain info for the 2 days in January
print("Calculating rows to import for our first 2 days in February 2007")
dateread <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL"))
mytwodays <- which(dateread$Date == "1/2/2007" | dateread$Date == "2/2/2007")
startfrom <- min(mytwodays)
importrows <- (max(mytwodays) - startfrom)+1
print (paste("We will import",importrows, "rows starting from", startfrom))

# Clean environment for efficiency
if (debugmode == "0") {
        rm(dateread, mytwodays)        
}


# First plot requires date, time and global active power values
plotDs <- read.table("household_power_consumption.txt", sep = ";", header = FALSE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "NULL", "numeric", "numeric", "numeric"), skip = startfrom, nrows = importrows, col.names = c("Date", "Time", "GAP", "GRP", "Voltage", NA, "Sub_metering_1","Sub_metering_2","Sub_metering_3"))
if (debugmode == "1") {
        print("Start and end of imported dataset shown below")
        print(head(plotDs,2))
        print(tail(plotDs,2))        
}


print ("Plotting directly to png file")

png("plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2,2))

#Plot 1
plot(plotDs$GAP, pch = NA, ylab = "Global Active Power", xlab = "", type = "l", axes = FALSE)
axis(2, at = c(0,2,4,6))
axis(1, at = c(0, 1440, 2880), lab = c("Thu", "Fri", "Sat"))
box()

#Plot 2
plot(plotDs$Voltage, pch = NA, ylab = "Voltage", xlab = "datetime", type = "l", axes = FALSE)
axis(1, at = c(0, 1440, 2880), lab = c("Thu", "Fri", "Sat"))
axis(2, at = c(234,238,242,246))
box()

#Plot 3
plot(plotDs$Sub_metering_1, pch = NA, ylab = "Energy sub metering", xlab = "", type = "l", axes = FALSE)
lines(plotDs$Sub_metering_2, pch = NA, col = "Red")
lines(plotDs$Sub_metering_3, pch = NA, col = "Blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black", "Red", "Blue"), lty = 1, bty = "n")
axis(2, at = c(0,10,20,30))
axis(1, at = c(0, 1440, 2880), lab = c("Thu", "Fri", "Sat"))
box()

#Plot 4
plot(plotDs$GRP, pch = NA, ylab = "Global_reactive_power", xlab = "datetime", type = "l", axes = FALSE)
axis(1, at = c(0, 1440, 2880), lab = c("Thu", "Fri", "Sat"))
axis(2, at = c(0.0, 0.1,0.2,0.3,0.4,0.5))
box()

# Close out the png file
dev.off()

print ("Plot exported to plot4.png")


# Clean environment for efficiency
if (debugmode == "0") {
        rm(plotDs, importrows, startfrom, debugmode)
}
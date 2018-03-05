# Coursera EDA Week 1
# Plot 1
# Moaeed Sajid
# 
# V1.0 4th Feb 2007

rm (list = ls())

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
rm(firstread, dataurl, localZip, totalmem)

# Identify the rows that contain info for the 2 days in January
print("Calculating rows to import for our first 2 days in February 2007")
dateread <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL"))
mytwodays <- which(dateread$Date == "1/2/2007" | dateread$Date == "2/2/2007")
startfrom <- min(mytwodays)
importrows <- (max(mytwodays) - startfrom)+1
print (paste("We will import",importrows, "rows starting from", startfrom))

# Clean environment for efficiency
rm(dateread, mytwodays)

# First plot requires date, time and global active power values
plotOneDs <- read.table("household_power_consumption.txt", sep = ";", header = FALSE, colClasses = c("character", "character", "numeric", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL"), skip = startfrom, nrows = importrows, col.names = c("Date", "Time", "GAP", NA, NA, NA, NA, NA, NA))
print("Start and end of imported dataset shown below")
print(head(plotOneDs,2))
print(tail(plotOneDs,2))

print ("Plotting to Console")
hist(plotOneDs$GAP, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Exporting plot to png
dev.copy(png, width=480, height= 480, file = "plot1.png")
dev.off()
print ("Plot exported to plot1.png")

# Clean environment for efficiency
rm(plotOneDs, importrows, startfrom)
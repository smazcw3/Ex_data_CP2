##This is to make a plot showing the total emissions from PM[2.5] in the Baltimore County, Maryland from 1999 to 2008

##Reading the data in the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data for Baltimore County
BC <- subset(NEI, fips == '24510')

##Open the png file device
png(filename = 'plot2.png')

##Construct the plot
barplot(tapply(X = BC$Emissions, INDEX = BC$year, FUN = sum), 
        main = "Total emissions from PM[2.5] in the Baltimore City, Maryland",
        xlab = "Year", ylab = "PM[2.5] emissions")

dev.off() ##Close the file device
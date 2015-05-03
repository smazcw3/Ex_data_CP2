##This is to make a plot showing the total PM2.5 emission from all sources for each of the  years 1999, 2002, 2005, and 2008

##Reading the data in the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregate NEI data frame by year returning sum
em <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
em$PM <- round(em[, 2] / 1000, 2)

##Open the png file device
png(filename = "plot1.png")

##Construct the plot
barplot(em$PM, names.arg = em$Group.1, main = "Total emissions from PM[2.5] in the US", xlab = "Year", ylab = "PM [2.5] emissions in kilotons")

dev.off() #close the file device




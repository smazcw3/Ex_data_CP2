##This is to construct the plot for emission per source type for baltimore city during 1999-2008

##Load ggplot2 package
library(ggplot2)

##Reading the data in the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data for Baltimore County
BC <- subset(NEI, fips == '24510')

##Construct the plot using the ggplot2 system
ggplot(BC,aes(factor(year),Emissions, fill = type)) +
  geom_bar(stat = "identity") + guides(fill = FALSE) +
  facet_grid(.~type,scales = "free", space = "free") + 
  labs(x = "Year", y = "Total PM[2.5] Emission (in tons)") + 
  labs(title = "PM[2.5] Emissions by Source Type for Baltimore City during 1999-2008")

#save a ggplot2 graph from the screen to a file
ggsave("plot3.png", width = 9, height = 6, dpi = 100)


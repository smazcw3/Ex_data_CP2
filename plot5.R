##This is to construct the plot for showing the change in emissions from motor vehicle sources during 1999-2008

##Loads ggplot2package
library(ggplot2)

##Reading the data in the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subsetting the data for on-road source type in Baltimore City, Maryland
BC.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

##Aggregates emissions of onroad source type in baltimore city by year returning sum
BC.df <- aggregate(BC.onroad[, 'Emissions'], by = list(BC.onroad$year), sum)
colnames(BC.df) <- c('year', 'Emissions')

##Construct the plot with ggplot2 system
ggplot(data = BC.df, aes(factor(year), Emissions)) + 
geom_bar(aes(fill = year), stat = "identity", fill = "grey") + 
guides(fill = F) + 
ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland during 1999-2008') + 
ylab("PM[2.5] emissions") + 
xlab("Year") + theme(legend.position = 'none') + 
geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))

##save a ggplot2 graph from the screen to a file
ggsave("plot5.png", width = 9, height = 9, dpi = 100)
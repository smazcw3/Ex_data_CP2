##This is to construct the plot for comparing the emissions from motor vehicle sources in Baltimore County, Maryland with Los Angeles County, California

##Loads ggplot2package
library(ggplot2)

##Reading the data in the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subsetting the data for on-road source type in Baltimore City, Maryland
BC.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
##Subsetting the data for on-road source type in Los Angeles County, California
LA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

##Aggregates emissions of onroad source type in baltimore city by year returning sum
BC.df <- aggregate(BC.onroad[, 'Emissions'], by = list(BC.onroad$year), sum)
colnames(BC.df) <- c('year', 'Emissions')
BC.df$City <- paste(rep('BC', 4))

##Aggregates emissions of onroad source type in Los Angeles county by year returning sum
LA.df <- aggregate(LA.onroad[, 'Emissions'], by = list(LA.onroad$year), sum)
colnames(LA.df) <- c('year', 'Emissions')
LA.df$City <- paste(rep('LA', 4))
 
DataFrame <- as.data.frame(rbind(BC.df, LA.df))

ggplot(data = DataFrame, aes(factor(year), Emissions)) + 
geom_bar(aes(fill = year),stat = "identity", fill = "grey") + guides(fill = F) + 
ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
ylab("PM[2.5] emissions") + 
xlab("Year") + theme(legend.position = 'none') + 
facet_grid(. ~ City) + 
geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))

##save a ggplot2 graph from the screen to a file
ggsave("plot6.png", width = 9, height = 9, dpi = 100)
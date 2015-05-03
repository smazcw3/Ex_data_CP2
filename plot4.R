##This is to construct the plot for showing the change of emissions from coal combustible-related sources during 1999-2008

##Load ggplot2 package
library(ggplot2)

##Reading the data in the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal-related SCC
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

#Merges two data sets
merge <- merge(x = NEI, y = SCC.coal, by = 'SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

##Construct the plot with ggplot system
ggplot(data = merge.sum, aes(x = Year, y = Emissions / 1000)) + 
geom_line(aes(group = 1, col = Emissions)) + 
geom_point(aes(size = 2, col = Emissions)) + 
ggtitle("PM[2.5] Coal Combustion Source Emissions across US during 1999-2008") + 
ylab("PM[2.5] emissions in kilotons") + 
geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 1.5, vjust = 1.5)) + 
theme(legend.position = 'none') + 
scale_colour_gradient(low = 'red', high = 'black')

#save a ggplot2 graph from the screen to a file
ggsave("plot4.png", width = 7, height = 7, dpi = 100)
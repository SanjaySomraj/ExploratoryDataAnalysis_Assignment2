# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, CA. 
#
# Which city has seen greater changes over time in motor vehicle emissions?
#
# The following R script plot shows the total PM2.5 emissions from motor vehicle sources in 
# Baltimore City, MD Vs Los Angeles county, CA for each of the years 1999, 2002, 2005, and 2008.
#
# The bar plot generated shows the PM2.5 emissions from motor vehicle sources in 
# Baltimore City, MD Vs Los Angeles county, CA for 1999 - 2008

library(ggplot2)

# Reading from NEI Dataset
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Setting width and height of PNG
PNG_width <- 1000
PNG_height <- 800

# Color to be used for the plot
colors <- c("navy", "magenta","green", "orange")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Data frames Baltimore City, MD and Los Angeles County, CA
Onroad_Data_MD <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
Onroad_Data_CA <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate data for MD
DataFrame_MD <- aggregate(Onroad_Data_MD[, 'Emissions'], by=list(Onroad_Data_MD$year), sum)
colnames(DataFrame_MD) <- c('year', 'Emissions')
DataFrame_MD$City <- paste(rep('MD', 4))

# Aggregate data for MD
DataFrame_CA <- aggregate(Onroad_Data_CA[, 'Emissions'], by=list(Onroad_Data_CA$year), sum)
colnames(DataFrame_CA) <- c('year', 'Emissions')
DataFrame_CA$City <- paste(rep('CA', 4))

# Consolidate the MD and CA data
ConsolidatedDF <- as.data.frame(rbind(DataFrame_MD, DataFrame_CA))

# Facet headings
ConsolidatedDF$City[ConsolidatedDF$City=="MD"]<- "Baltimore, MD"
ConsolidatedDF$City[ConsolidatedDF$City=="CA"]<- "Los Angeles, CA"

# Plotting
png("plot6.png", width=PNG_width, height=PNG_height)
g<-ggplot(data=ConsolidatedDF,aes(year,Emissions)) + 
     geom_bar(aes(fill=year), stat = "identity") +
     facet_grid(.~City) +
     ggtitle('Total Emissions of Motor Vehicle Sources\nBaltimore City, Maryland Vs Los Angeles County, California') +
     ylab("PM[2.5]") + xlab('Year') +
     scale_fill_manual(values=colors) +
     geom_text(aes(label=round(Emissions,0), size=10, hjust=0.5, vjust=-1))

print(g)
dev.off()

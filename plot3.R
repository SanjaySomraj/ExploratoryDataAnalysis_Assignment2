# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?
#
# The following R script plot shows the total PM2.5 emissions across 4 types of source in 
# Baltimore City, MD for each of the years 1999, 2002, 2005, and 2008.
#
# The bar plot generated shows the PM2.5 emissions across 4 types of source in Baltimore city, MD for 1999 - 2008

library(dplyr)
library(ggplot2)

# Reading the NEI Dataset
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Setting width and height of PNG
PNG_width <- 1000
PNG_height <- 800

# Color to be used for the plot
colors <- c("navy", "magenta","green", "orange")


yearlyEmissionsBaltimore <- summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))
yearlyEmissionsBaltimore$year <- factor(yearlyEmissionsBaltimore$year, levels=c('1999', '2002', '2005', '2008'))

png("plot3.png", width=PNG_width, height=PNG_height)
g <- ggplot(data=yearlyEmissionsBaltimore, aes(year,Emissions)) +
     geom_bar(aes(fill=year), stat = "identity") +
     facet_grid(. ~ type) +
     scale_fill_manual(values=colors)+
     xlab("Year") +
     ylab(expression("Total PM"[2.5]*" emission in tonnes")) +
     ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                        "City by various source types", sep="")))+
     geom_text(aes(label=round(Emissions,0), size=10, hjust=0.5, vjust=-1))
print(g)
dev.off()
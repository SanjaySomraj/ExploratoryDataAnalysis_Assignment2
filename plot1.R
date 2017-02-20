# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# The following R script plot shows the total PM2.5 emission from all sources for each 
# of the years 1999, 2002, 2005, and 2008.
#
# The bar plot generated shows a gradual decline in the PM2.5 emissions
# in the United States for the period 1999 - 2008

library(dplyr)

# Reading from NEI Dataset
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Setting width and height of PNG
PNG_width <- 800
PNG_height <- 800

# Color to be used for the plot
colors <- c("navy", "magenta","green", "orange")

# Total Emissions per year
TotalEmissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))

# Plotting
png('plot1.png', width=PNG_width, height = PNG_height)
barplot(height=TotalEmissions$Emissions/1000, 
        names.arg=TotalEmissions$year,
        xlab="Years", ylab="Emissions (PM 2.5) in millions",
        ylim=c(0,8000),
        main="Emissions PM [2.5] per year",
        col=colors)
dev.off()
# Have total emissions from PM2.5 decreased in the  Baltimore City, Maryland from 1999-2008?
#
# The following R script plot shows the total PM2.5 emissions in Baltimore City, MD from all 
# sources for each of the years 1999, 2002, 2005, and 2008.
#
# The bar plot generated shows the PM2.5 emissions in the Baltimore city, MD for 1999 - 2008

library(dplyr)

# Reading from NEI Datasets
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Setting width and height of PNG
PNG_width <- 1000
PNG_height <- 800

# Color to be used for the plot
colors <- c("navy", "magenta","green", "orange")

# Subset total emissions from PM2.5 for Baltimore City, Maryland (fips == "24510") from 1999 to 2008
BaltimoreEmissions  <- subset(NEI, fips=="24510")

# Emission totals per year
BaltimoreEmissionTotalByYear <- tapply(BaltimoreEmissions$Emissions, BaltimoreEmissions$year, sum)

# Plotting
png('plot2.png')
barplot(BaltimoreEmissionTotalByYear, 
        xlab="Years", ylab="Total PM'[2.5]* Emission",
        main="Emissions PM [2.5] per year in the Baltimore City, MD",
        col = colors)
dev.off()
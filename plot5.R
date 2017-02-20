# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#
# The following R script plot shows the total PM2.5 emissions from motor vehicle sources in 
# Baltimore City, MD for each of the years 1999, 2002, 2005, and 2008.
#
# The bar plot generated shows the PM2.5 emissions from motor vehicle sources in Baltimore city, MD for 1999 - 2008

library(ggplot2)

# Reading from NEI and SCC Datasets
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Setting width and height of PNG
PNG_width <- 1000
PNG_height <- 800

# Color to be used for the plot
colors <- c("navy", "magenta","green", "orange")

# subsetting SCC with vehicle values
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]
yearlyEmissionsBaltimore <- subset(NEI, fips == "24510")

# Merging NEI and SCC subset dataframes
BaltimoreEmissionsSCC <- merge(yearlyEmissionsBaltimore, subsetSCC, by="SCC")

# Collating emission data per year per type
totalEmissions <- tapply(BaltimoreEmissionsSCC$Emissions, NEISCC$year, sum)

# Plotting
png('plot5.png', width = PNG_width, height = PNG_height)
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (in tonnes)", 
        main = "Total Emission from motor sources in Baltimore,MD",
        col = colors)
dev.off()
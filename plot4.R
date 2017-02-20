# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
#
# The following R script plot shows the total PM2.5 emissions from coal-combustion sources in 
# Baltimore City, MD for each of the years 1999, 2002, 2005, and 2008.
#
# The bar plot generated shows the PM2.5 emissions from coal-combustion sources in Baltimore city, MD for 1999 - 2008

library(ggplot2)

# Reading from NEI and SCC Datasets
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Setting width and height of PNG
PNG_width <- 1000
PNG_height <- 800

# Color to be used for the plot
colors <- c("navy", "magenta","green", "orange")

# Subsetting SCC with coal values
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

# Merging NEI and SCC dataframes
NEISCC <- merge(NEI, subsetSCC, by="SCC")

# Total Emissions data per year
totalEmissions <- tapply(NEISCC$Emissions/1000, NEISCC$year, sum)

# Plotting
png('plot4.png', width=PNG_width, height = PNG_height)
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (in tonnes)", 
        main = "Total Emission from coal sources 1999-2008",
        col = colors)
dev.off()

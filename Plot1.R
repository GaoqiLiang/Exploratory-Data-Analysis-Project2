library (httr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", 
     xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~"Emissions (tons)"), 
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"), 
     col="Red")
dev.off()
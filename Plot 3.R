setwd("C:/Users/c3179782/Desktop/R/Coursera/Lecture4_Project2")

library (httr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


baltimore <- subset (NEI, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

# Rename the col: Emissions
colnames(typePM25.year)[3] <- "Emissions"

png("plot3.png") 
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line")+ 
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year"))+ 
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
dev.off()

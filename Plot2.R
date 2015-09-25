library (httr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.

baltimore <- subset (NEI, fips == "24510")
total.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

png("plot2.png")
plot(names(total.PM25yr), total.PM25yr, type = "l", 
     xlab="Year", 
     ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
     main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), 
     col = "blue")
dev.off()  
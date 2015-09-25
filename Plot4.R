library (httr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# subset our data for only coal-combustion
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
                                             "Fuel Comb - Electric Generation - Coal", 
                                             "Fuel Comb - Industrial Boilers, ICEs - Coal"))

# comparisons so that we didn't ommit anything weird
coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

nrow(coalcomb.scc) #evaluate: rows 0

nrow(coalcomb.scc1) #evaluate: rows 91
# set the differences 
dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

length(dif1)#0

length(dif2)#91

# look at the union of these sets
coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
length(coalcomb.codes) #91

# subset again for what we want
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

# get the PM25 values as well
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

# rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"


png("plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line")+ 
  stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + 
  geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
  xlab("Year")+ 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

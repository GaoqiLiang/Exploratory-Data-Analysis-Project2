setwd("C:/Users/Desktop/R/Coursera/Lecture4_Project2")


## download files
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "Air_Pollutant_PM25.zip"
if(!file.exists(file)){
  download.file(url, file)
}

#unzip and create folders (if those ain't exist)
datafolder <- "Air_Pollutant_PM25"
if(!file.exists(datafolder)){
  unzip(file, list = FALSE, overwrite = TRUE)
}


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

names(NEI)
names(SCC)
head(NEI)
head(SCC)

length(NEI$Emissions)
length(NEI$year)
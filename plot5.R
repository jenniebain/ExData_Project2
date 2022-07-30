## QUESTION
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(ggplot2)
library(dplyr)

## If the data does not already exist in the working directory, download and unzip it

if(!file.exists("pm25Data.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl,destfile = "./pm25Data.zip",method="curl")
  if(!file.exists("summarySCC_PM25.rds")){unzip("./pm25Data.zip")}}

## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data to only Baltimore City (fips=24510)
bc <- subset(NEI,fips == "24510")

## Subset to motor vehicle related sources, identified by Category = 'Onroad'
mv <- subset(SCC,Data.Category == "Onroad")

bc_mv <- subset(bc,SCC %in% mv$SCC)
bc_mv$year <- as.factor(bc_mv$year)

## plot total emissions by year
png(file="plot5.png")
ggplot(bc_mv) + 
  geom_bar(aes(x=year,y=Emissions),stat="identity") +
  ggtitle("Total Emissions from PM2.5 by Motor Vehicle Sources in Baltimore City") +
  xlab("Year") +
  ylab("Total Tons of PM2.5 Emitted")
dev.off()
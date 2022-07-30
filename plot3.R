## QUESTION
## Of the 4 types of sources (point, nonpoint, onroad, nonroad), which of these 4 sources have seen decreases in
## emissions from 1999 - 2008 for Baltimore City?
## Which have seen increases in emissions from 1999-2008?

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

## Sum by year and by type
png(file="plot3.png")
bc %>%
  group_by(year,type) %>%
  summarise(sum=sum(Emissions)) %>%
  ggplot(aes(x=year,y=sum,color=type)) + 
  geom_line(size=2,show.legend = FALSE) +
  facet_wrap(~type) +
  ggtitle("Total Emissions from PM2.5 by Source and Year for Baltimore City") +
  xlab("Year") +
  ylab("Total Tons of PM2.5 Emitted") +
  labs(color="Source Type")
dev.off()
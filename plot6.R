library(ggplot2)
library(dplyr)
## QUESTION
## Compare emissions from motor vehicle sources in Baltimore City eith emissions from motor vehicle
## sources in Los Angeles County, CA. Which city has seen greater changes over time in motor
## vehicle emissions?

## If the data does not already exist in the working directory, download and unzip it

if(!file.exists("pm25Data.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl,destfile = "./pm25Data.zip",method="curl")
  if(!file.exists("summarySCC_PM25.rds")){unzip("./pm25Data.zip")}}

## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data to only Baltimore City (fips=24510) or Los Angeles County (fips=06037)
bc_la <- subset(NEI,fips == "24510" | fips == "06037")

## Subset to motor vehicle related sources, identified by Category = 'Onroad'
mv <- subset(SCC,Data.Category == "Onroad")

bcla_mv <- subset(bc_la,SCC %in% mv$SCC)

## Sum by year and by city
png(file="plot6.png")
bcla_mv %>%
  group_by(year,fips) %>%
  summarise(sum=sum(Emissions)) %>%
  ggplot(aes(x=year,y=sum,color=fips)) + 
  geom_line(size=1) +
  ggtitle("Total Emissions from PM2.5 by Year for Baltimore City and Los Angeles County") +
  xlab("Year") +
  ylab("Total Tons of PM2.5 Emitted") +
  labs(color="County") +
  scale_color_manual(labels = c("Los Angeles County","Baltimore City"),values = c("blue","red"))
dev.off()
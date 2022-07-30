## QUESTION
## Across the US, how have emissions from coal combustion-related sources changed from 1999-2008?

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

## Subset to Coal related sources
coal <- SCC[grep("[Cc]oal",SCC$Short.Name),1]
c0 <- subset(NEI,SCC %in% coal)
c0$year <- as.factor(c0$year)

## strip out the state code from the fips so data can be grouped by state
c0$state <- substr(c0$fips,start=1,stop=2)

## Plot boxplots of the emissions by state for each year
png(file="plot4.png")
c0 %>%
  group_by(year,state) %>%
  summarise(sum=sum(Emissions)) %>%
  ggplot(aes(x=year,y=sum)) + 
  geom_boxplot() +
  coord_cartesian(ylim=c(0,60000)) +
  ggtitle("Total Emissions from PM2.5 by State and Year from Coal Related Sources") +
  xlab("Year") +
  ylab("Total Tons of PM2.5 Emitted")
dev.off()

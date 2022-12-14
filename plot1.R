## QUESTION
## Have total emissions from PM2.5 decreased in the US from 1999 to 2008?


## If the data does not already exist in the working directory, download and unzip it

if(!file.exists("pm25Data.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl,destfile = "./pm25Data.zip",method="curl")
  if(!file.exists("summarySCC_PM25.rds")){unzip("./pm25Data.zip")}}

## Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Find the total emissions from PM2.5 by year
total_em <- tapply(NEI$Emissions,NEI$year,sum,na.rm = TRUE)
d0 <- data.frame(year=names(total_em),mean=total_em)

## Plot the total emissions by year
png(file="plot1.png")
plot(d0,pch=20,type="b",main="Total Emissions from PM2.5 for all Sources by Year in the US",xlab="Year",ylab="Total Tons of PM2.5 Emitted")
dev.off()
## QUESTION
## Have total emissions from PM2.5 decreased in Baltimore City, Maryland from 1999 to 2008?

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

## Find the total emissions from PM2.5 by year
bc_em <- tapply(bc$Emissions,bc$year,sum,na.rm = TRUE)
d1 <- data.frame(year=names(total_em),mean=bc_em)

## Plot the total emissions by year
png(file="plot2.png")
plot(d1,pch=20,type="b",main="Total Emissions from PM2.5 for all Sources by Year \nfor Baltimore City",xlab="Year",ylab="Total Tons of PM2.5 Emitted")
dev.off()
library(ggplot2)
#Data Source
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
codeFile<-"Source_Classification_Code.rds"
datasetFile<-"summarySCC_PM25.rds"

#Download the data files and extract the dataset files
if(!file.exists(datasetFile)||!file.exists(codeFile)){
    download.file(url,"temp.zip",method="curl")
    unzip("temp.zip",exdir = "./")
    file.remove("temp.zip")
}

#Load dataset from files if aren't already loaded into memory
if (!exists("rawDataset")||!exists("classificationCodes")){
    rawDataset <- readRDS(datasetFile)
    classificationCodes <- readRDS(codeFile)
}

#Calculate the total pollution emission
desiredDataset<-subset(rawDataset,rawDataset$fips=="24510")
desiredDataset<-aggregate(desiredDataset$Emissions, by=list(Year=desiredDataset$year, Type=desiredDataset$type), FUN=sum)

#png("plot3.png", width=640, height=480)
g <- ggplot(desiredDataset, aes(Year, x, color = Type))
g <- g + geom_line() +
    xlab("Years") +
    ylab(expression('Total PM'[2.5]*" Emissions (Tons)")) +
    ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')+
    geom_point()+
    geom_text(aes(label=round(x,2),hjust=0,vjust=0))
print(g)
dev.copy(png,file="plot3.png", width=480,height=480)
dev.off()
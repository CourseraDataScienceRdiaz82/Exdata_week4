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
desiredDataset<-subset(rawDataset,rawDataset$fips=="24510" & rawDataset$type=="ON-ROAD")
desiredDataset<-aggregate(desiredDataset$Emissions, by=list(Year=desiredDataset$year), FUN=sum)

#Generate a bar plot with the required information
barplot(desiredDataset[,2],names.arg = desiredDataset[,1],
        main=expression(paste("Total Emission", PM[2.5], " between 1999 to 2008 in USAL (Coal sources)")),
        xlab="Year",
        ylab=expression(paste("Total Emission ", PM[2.5], " (Tons)")),
        col="skyblue")
grid()

dev.copy(png,file="plot5.png", width=480,height=480)
dev.off()
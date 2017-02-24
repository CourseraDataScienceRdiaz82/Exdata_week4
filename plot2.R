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
plot2<-subset(rawDataset,rawDataset$fips=="24510")
plot2<-aggregate(plot2$Emissions, by=list(Year=plot2$year), FUN=sum)

#Generate a bar plot with the required information
barplot(plot2[,2],names.arg = plot2[,1],
        main=expression(paste("Emissions from ", PM[2.5], " in Baltimore City from 1999 to 2008")),
        xlab="Year",
        ylab=expression(paste("Total Emission ", PM[2.5], " (Tons)")),
        col="skyblue")

#Save the plot to a file
dev.copy(png,file="plot2.png", width=480,height=480)
dev.off()
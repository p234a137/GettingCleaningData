# The American Community Survey distributes downloadable data about United States
# communities. Download the 2006 microdata survey about housing for the state of
# Idaho using download.file() from here: 

# The code book, describing the variable names is here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# create data dir first, if it does not exist
if (!file.exists("data")) {
  dir.create("data")
}

# CSV
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/idaho.csv", method = "curl")
list.files("./data")

dateDownloaded <- date()
dateDownloaded
idaho <- read.table("./data/idaho.csv", sep = ",", header = TRUE)
head(idaho)

# houses over 1 Milion
head(idaho,n=5)
names(idaho)
idaho$VAL
# according to data book, VAL == 24 denotes propertyies over 1 Milion dollar
overMilion = idaho[idaho$VAL == 24,37]
length(overMilion[!is.na(overMilion)]) # remove NAs

# tidy data
table(idaho$FES)
hist(idaho$FES)

# Excel file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/DATA.gov_NGAP.xlsx", method = "curl")
list.files("./data")
library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/DATA.gov_NGAP.xlsx",sheetIndex=1, colIndex=colIndex,rowIndex=rowIndex)
dat
sum(dat$Zip*dat$Ext,na.rm=T) 


# XML
library(XML)
library(RCurl)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData <- getURL(fileUrl)
#doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
doc <- xmlParse(xData)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zipCodes <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipCodes[zipCodes == "21231"])

# data.table
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/idaho2.csv", method = "curl")
list.files("./data")
library(data.table)
DT <- fread("./data/idaho2.csv")

# use system.time to find out fastest method
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})


# par(bg = "#36394A", col = "white", fg = "white", col.axis = "white", col.lab = "white", col.main = "white", family = "Verdana")
## csv file source
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "house.csv")
h <- read.csv("house.csv", sep=",", header=TRUE)

## house with property value over 1 million, code value is 24
dt <- data.table(h, key="VAL")
dim(dt[VAL>=24,,])[1]

## xlsx file source
require(xlsx)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "NGAP.xlsx",mode="wb")
ri <- 18:23
ci <- 7:15
dat <- read.xlsx("NGAP.xlsx", sheetName="NGAP Sample Data", rowIndex=ri, colIndex=ci)
sum(dat$Zip*dat$Ext,na.rm=T)

## xml file
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileurl, "restaurant.xml", method="curl")
doc <- xmlTreeParse("restaurant.xml",useInternal=TRUE)
r <- xmlRoot(doc)
n <- getNodeSet(doc,"//row[zipcode=21231]")
length(n)

## data.table package community csv file 
require(data.table)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl, "community.csv", method="curl")
DT <- fread("community.csv", sep=",")

system.time(for (i in 1:500) {mean(DT$pwgtp15,by=DT$SEX)})
#user  system elapsed 
#0.02    0.00    0.01 

system.time(for (i in 1:500) {tapply(DT$pwgtp15,DT$SEX,mean)})

#user  system elapsed 
#0.24    0.00    0.23 

#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] 
#Failed syntax Error in rowMeans(DT) : 'x' must be numeric

system.time(for (i in 1:500) {mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
#user  system elapsed 
#9.44    0.06    9.61

system.time(for (i in 1:500) {DT[,mean(pwgtp15),by=SEX]})
#user  system elapsed 
#0.30    0.00    0.29 

system.time(for (i in 1:500) {sapply(split(DT$pwgtp15,DT$SEX),mean)})
#user  system elapsed 
#0.22    0.00    0.22 
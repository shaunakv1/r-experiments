getwd()

if (!file.exists("AmericanCommunity")){
  dir.create("AmericanCommunity")
}
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileURL, destfile = "./AmericanCommunity/data.csv", method = "curl")

list.files("AmericanCommunity")

communitydata <- read.table("./AmericanCommunity/data.csv",sep = ",",header=TRUE)

head(communitydata)

library(data.table)

DT <- data.table(communitydata$VAL>=1000000,TRUE)
DT[,.N,by=communitydata$VAL]

communitydata$FES

## Question 3

install.packages("xlsx")
install.packages("rJava")

library(xlsx)

getwd()

if (!file.exists("NatGasAcq")){
  dir.create("NatGasAcq")
}
fileURLq3="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURLq3,destfile = "./NatGasAcq/data.xlsx",method="curl")

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./NatGasAcq/data.xlsx",sheetIndex=1,header=TRUE,colIndex = colIndex, rowIndex = rowIndex)
x <- sum(dat$Zip*dat$Ext,na.rm=T)
x

## Question 4
library(XML)
library(RCurl)

getwd()
if (!file.exists("BaltimoreRests")){
  dir.create("BaltimoreRests")
}
fileURLq4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileURLq4,destfile = "./BaltimoreRests/restaurants.xml",method = "curl")
restaurants <- xmlTreeParse("./BaltimoreRests/restaurants.xml", useInternalNodes = TRUE)

#common
rootNode <- xmlRoot(restaurants)
zipCodes <- xpathApply(rootNode,"//zipcode",xmlValue)
matchingZipCodes <- zipCodes[zipCodes == '21231']
length(matchingZipCodes)

## Question 5
getwd()
library(data.table)
library(microbenchmark)
library(ggplot2)
if (!file.exists("AmericanCommunityQ5")){
  dir.create("AmericanCommunityQ5")
}

fileURLq5="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURLq5, destfile = "./AmericanCommunityQ5/data.csv", method = "curl")
DT <- fread("./AmericanCommunityQ5/data.csv", header = TRUE)

f1 <- function(DT){ mean(DT$pwgtp15,by=DT$SEX) } #wrong
f2 <- function(DT){ tapply(DT$pwgtp15,DT$SEX,mean) }
f3 <- function(DT){ DT[,mean(pwgtp15),by=SEX] }

f4 <- function(DT){ #wrong
    ?rowMeans
    rowMeans(DT)[DT$SEX==1]; 
    rowMeans(DT)[DT$SEX==2] 
}

f5 <- function(DT){ sapply(split(DT$pwgtp15,DT$SEX),mean) } #wrong
f6 <- function(DT){ mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) } #wrong

tm <- microbenchmark(f1(DT),f2(DT),f3(DT),f5(DT),f6(DT),times=1000L)
autoplot(tm)









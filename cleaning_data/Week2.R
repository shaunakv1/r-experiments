####Week 2####

##Webscraping##

con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ")
htmlCode = readLines(con)
close(con)
htmlCode

# Parsing with XML #

library(XML)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = TRUE)
xpathSApply(html, "//head", xmlValue)

# GET from the httr package #

library(httr); html2 = GET(url) 
# same as  
# library(httr)
# html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml <- htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# Accessing websites with passwords #

#this won't work
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

#so do this
pg2= GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2

names(pg2)

###

##Reading from HDF5##

source("https://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

#Writing to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

#Write a dataset 
df = data.frame(1L:5L, seq(0,1,length.out = 5), c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
h5write(df,"example.h5", "df")
h5ls("example.h5")

#Reading data
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA
readB
readdf

#Reading and Writing in chunks
h5write(c(12,13,14),"example.h5","foo/A", index=list(1:3,1))
h5read("example.h5", "foo/A", index = list(3:5,1))

###

##Reading from mySQL

install.packages("RMySQL")
library(RMySQL)

#Connecting and listing databases
ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;")
dbDisconnect(ucscDb) #returns a TRUE which means that disconnection was successful

result #returns a list of all databases available at the host sql server

#Specify which database to connect to
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

#Get dimensions of a specific table
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2") #counts all the records in the table

#Read from a table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

#Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3") 
#misMatches is a column in the dataset
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10) 
#only "fetches" back the top 10 records back to your computer not the entire database
dbClearResult(query)
dim(affyMisSmall)

dbDisconnect(hg19)

###

##Reading from other sources
#best way to find out if a R package exists is to google 'data storage mechanism R package' 

#interacting more directly with files
# file: open a connection to a text file on your local computer
#url: open a url connection
#gzfile: open a connection to a .gz file (zipped file) on your computer
#bzfile: open a connection to a .bz2 file (zipped file) on your computer
#?connections for more information
## Remember to close connections
## other foreign packages: Loads data from Minitab, S, SAS, SPSS, Stata, Systat
# basic functions read.foo: where foo is the extension for the particular file to read
# - read.arff (WEKA)
# - read.dta (Stata)
# - read.mtp (Minitab)
# - read.octave (Octave)
# - read.spss (SPSS)
# - read.xport (SAS)




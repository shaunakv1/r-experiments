#Question 4
getwd()
library(XML)
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = as.vector(readLines(con))
close.connection(con)
nchar(htmlCode[c(10,20,30,100)])

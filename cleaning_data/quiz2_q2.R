#Question 2
library("sqldf")
library("RMySQL")

acs = read.csv("getdata-data-ss06pid.csv")
ans = sqldf("select pwgtp1 , AGEP from acs where AGEP < 50")


#Question 3

ans2 = sqldf("select distinct AGEP from acs")
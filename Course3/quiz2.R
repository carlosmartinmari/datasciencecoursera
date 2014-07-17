#Quiz2 

#Question 1 - Read github API of jtleek and retrieve the creation date of datasharing package

library(httr)
library(httpuv)
library(jsonlite)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

req <- GET("https://api.github.com/users/jtleek/repos", config("1da617658f009e59b5ed4e8501f59cc70fca9f47"))
stop_for_status(req)
output <- content(req)
list(output[[5]]$name, output[[5]]$created_at)


#Question 2 - 
library(sqldf)
# url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
# download.file(url, f)
acs <- read.csv(f)
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")

#Question 3 - compare two type of sql queries
compare<-unique(acs$AGEP)
query<-sqldf("select distinct AGEP from acs")
identical(compare, query$AGEP)

#Question 4 - number of character in a html line
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

#Question 5 - read certain data and sum number in the 4th column
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n = 10)
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])
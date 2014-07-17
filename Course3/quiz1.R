#Question 1 - Houses bought for more than 1G USD
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
f <- file.path(getwd(), "PUMSDataDict06.pdf")
download.file(url, f, mode = "wb")
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "ss06hid.csv")
download.file(url, f)
dt <- data.table(read.csv(f))
setkey(dt, VAL)
dt[, .N, key(dt)]

#Question 2 - what tidy data principle does the FES variable from the previous question not fulfill?
# tidy data has only one variable per column


#Question 3 - Value of the command sum(dat$Zip*dat$Ext,na.rm=T) after applying certain selection in data
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
f <- file.path(getwd(), "DATA.gov_NGAP.xlsx")
download.file(url, f, mode = "wb")
rows <- 18:23
cols <- 7:15
dat <- read.xlsx(f, 1, colIndex = cols, rowIndex = rows)
sum(dat$Zip * dat$Ext, na.rm = T)

#Question 4 - Restaurant at baltimore with certain zipcode
library(XML)
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
fileURL2 <- sub('https', 'http', fileURL)
doc <- xmlTreeParse(fileURL2, useInternal = TRUE)
class(doc)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zipcodes<-xpathSApply(rootNode,"//zipcode",xmlValue)
table(zipcodes == 21231)

#Question 5 
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
DT <- fread(f)
check <- function(y, t) {
        message(sprintf("Elapsed time: %.10f", t[3]))
        print(y)
}
t <- system.time(y <- sapply(split(DT$pwgtp15, DT$SEX), mean))
check(y, t)

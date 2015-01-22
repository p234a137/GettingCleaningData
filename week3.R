
# create data.frame
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] <- NA

# Subsetting
X[,1]
X[,"var1"]
X[1:2, "var2"]
X[(X$var1 <=3 & X$var3 > 11),]
X[(X$var1 <=3 | X$var3 > 15),]
# which can deal with NAs
X[which(X$var2>8),]

# Sorting
sort(X$var1)
sort(X$var1, decreasing = T)
sort(X$var2, na.last = T)
X[order(X$var1, X$var3),]

# Ordering with plyr
library(plyr)
arrange(X, var1)
arrange(X, desc(var1))

# Adding rows and columns
X$var4 <- rnorm(5)
X
X <- cbind(X,rnorm(5))
X


# Summarizing data
# https://data.baltimorecity.gov/Culture-Arts/Restaurants/k5ry-ef3g?
# https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
restData <- read.csv("./data//restaurants.csv")
head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = T)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9), na.rm = T)
# table does not use NAs by default
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict,restData$zipCode)
# check for missing data
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode>0)
# row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
# Values with speficic characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),]













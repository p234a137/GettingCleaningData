
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

# Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
# one variable vs 2 others
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt
# one variable vs all others
warpbreaks$replicate <- rep(1:9, len = 54)
warpbreaks$replicate
xt <- xtabs(breaks~., data = warpbreaks)
xt
ftable(xt) # display as flat table

# Size of a dataset
fakeData <- rnorm(1e5)
class(fakeData)
length(fakeData)      # length of array
object.size(fakeData) # size in bytes
object.size(fakeData)/length(fakeData) # how many bytes per element of array
print(object.size(fakeData), units='Mb') # print in Mb, class/object method overwrites/extends print


# Creating new variables
# creating sequences
s1 <- seq(1, 10, by = 2); s1
s2 <- seq(1, 10, length = 3); s2
x <- c(1,3,8,25,100); seq(along = x)

# subsetting variables
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
names(restData)
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode<0)

# creating categorical variables
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

# easier cutting
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
head(restData$zcf,n=10)
class(restData$zcf)

# levels of factor variable
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac <- factor(yesno,levels=c("yes","no"))
relevel(yesnofac,ref="yes")
as.numeric(yesnofac)

#cutting produces factor variables














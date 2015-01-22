
# create data.frame
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
?sample
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

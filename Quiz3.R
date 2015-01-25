# Quiz 3

# Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey
# about housing for the state of Idaho using download.file() from here: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is here: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Create a logical vector that identifies the 
# households on greater than 10 acres 
# who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical.
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical) What are the first 3 values that result?
# 125, 238,262  <-
# 236, 238, 262
# 153 ,236, 388
# 25, 36, 45
#
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/idaho2.csv", method = "curl")
idaho <- read.csv("./data//idaho2.csv")
agriCultureLogical <- idaho$ACR == 3 & idaho$AGS == 6
head(which(agriCultureLogical), n = 3)
# 125 238 262


# Question 2
# Using the jpeg package read in the following picture of your instructor into R 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may
# produce an answer 638 different for the 30th quantile)
# 10904118 -594524
# -10904118 -10575416
# -15259150 -10575416 <-
# -14191406 -10904118
library(jpeg)
require(RCurl)
jpegUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
#jeff <- readJPEG(getURLContent(jpegUrl)) # fails because of ssl, no time to solve this now, download the file manually
jeff <- readJPEG("./data/jeff.jpg", native = T)
quantile(jeff, probs=c(.3,.8))
# -15259150 -10575416 


# Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. How many of the IDs match?
# Sort the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame? 
# 
# Original data sources: 
#   http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats
# 189, St. Kitts and Nevis
# 189, Spain
# 234, Spain
# 234, St. Kitts and Nevis
# 190, Spain
# 190, St. Kitts and Nevis
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl2, destfile = "./data/FGDP.csv", method = "curl")
# skip and nrows very important for this dataset due to the way the file is organized
FGDP <- read.csv("./data/FGDP.csv", skip = 3, nrows = 232)
FGDP <- FGDP[!is.na(FGDP$Ranking) & FGDP$Ranking != "",]
# convert gros domestic product to numeric
FGDP$US.dollars. <- as.numeric(gsub(',','',FGDP$US.dollars.))
FGDP$Ranking <- as.numeric(FGDP$Ranking)
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl3, destfile = "./data/FEDSTATS_Country.csv", method = "curl")
FEDSTATS_Country <- read.csv("./data/FEDSTATS_Country.csv")

# matching
non_empty_gdp_country = FGDP$X[FGDP$X != ""]
non_empty_fed_country = FEDSTATS_Country$CountryCode[FEDSTATS_Country$CountryCode != ""]
# matched_data <- match(FGDP$X, FEDSTATS_Country$CountryCode, nomatch=0)
# # or FGDP$X %in% FEDSTATS_Country$CountryCode <- returns logical directly
# sum(matched_data != 0) # count non-zero elements, using the sum trick for logicals
sum(non_empty_fed_country %in% non_empty_gdp_country)
# 189

FGDP[order(FGDP$US.dollars., decreasing = F, na.last= T),][13,]
# St. Kitts and Nevis

# Question 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
# 32.96667, 91.91304 <- 
# 23, 30
# 133.72973, 32.96667 ?
# 30, 37
# 23.966667, 30.91304
# 23, 45

#selected_indices <- grep("High income", FGDP$Economy)
#FGDP[selected_indices,]
merged_data <- merge(FGDP, FEDSTATS_Country, by.x = "X", by.y = "CountryCode")
mean( merged_data[ merged_data$Income.Group == "High income: OECD",][,"Ranking"] )
mean( merged_data[ merged_data$Income.Group == "High income: nonOECD",][,"Ranking"], na.rm = T )
# 32.96667 91.91304

# 
# Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
# are Lower middle income but among the 38 nations with highest GDP?
# 0
# 5 <-
# 13
# 1
library(Hmisc)
merged_data$gdpGroups <- cut2(merged_data$Ranking, g = 5)
table(merged_data$gdpGroups)
table(merged_data$gdpGroups, merged_data$Income.Group)
# High income: nonOECD High income: OECD Low income Lower middle income Upper middle income
# [  1, 39)  0                    4                18          0                   5                  11
# [ 39, 77)  0                    5                10          1                  13                   9
# [ 77,115)  0                    8                 1          9                  12                   8
# [115,154)  0                    5                 1         16                   8                   8
# [154,190]  0                    1                 0         11                  16                   9










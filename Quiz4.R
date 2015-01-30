# Question 1
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# and load the data into R. The code book, describing the variable names is here:    
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?
# "wgtp"
# "" "15"   <-
# "wgt" "15"
# "wgtp" "15"
# dataset downloaded already in Quiz1.R
dateDownloaded <- date()
dateDownloaded
idaho <- read.table("./data/idaho.csv", sep = ",", header = TRUE)
head(idaho)
splitNames = strsplit(names(idaho),"wgtp")


# Question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table
# 381668.9
# 377652.4 <-
# 381615.4
# 293700.3
# skip and nrows very important for this dataset due to the way the file is organized
FGDP <- read.csv("./data/FGDP.csv", skip = 3, nrows = 216) # rows beyond 216 excluded from this exercise
# convert gros domestic product to numeric
FGDP$US.dollars. <- as.numeric(gsub(',','',FGDP$US.dollars.))
mean(FGDP$US.dollars., na.rm = T)

# Question 3
# In the data set from Question 2 what is a regular expression that would allow you
# to count the number of countries whose name begins with "United"? Assume that the
# variable with the country names in it is named countryNames. How many countries begin with United?
# grep("^United",countryNames), 4
# grep("*United",countryNames), 2
# grep("United$",countryNames), 3
# grep("^United",countryNames), 3  <- 
length(grep("^United", FGDP$Economy[1:214]))


# Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# Match the data based on the country shortcode.
# Of the countries for which the end of the fiscal year is available, how many end in June?
# Original data sources: 
#   http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats
# 13 <-
# 31
# 8
# 15
# dataset downloaded already in Quiz3
# skip and nrows very important for this dataset due to the way the file is organized
FGDP <- read.csv("./data/FGDP.csv", skip = 3, nrows = 232)
FGDP <- FGDP[!is.na(FGDP$Ranking) & FGDP$Ranking != "",]
FEDSTATS_Country <- read.csv("./data/FEDSTATS_Country.csv")
# matching
non_empty_gdp_country = FGDP$X[FGDP$X != ""]
non_empty_fed_country = FEDSTATS_Country$CountryCode[FEDSTATS_Country$CountryCode != ""]
sum(non_empty_fed_country %in% non_empty_gdp_country)
#
fiscal_year <- grep('^Fiscal year',FEDSTATS_Country$Special.Notes, value=T)
length(grep('^Fiscal year end: June', fiscal_year))
# 13

# Question 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices
# for publicly traded companies on the NASDAQ and NYSE.
# Use the following code to download data on Amazon's stock price and get the times the data was sampled.
# library(quantmod)
# amzn = getSymbols("AMZN",auto.assign=FALSE)
# sampleTimes = index(amzn) 
# How many values were collected in 2012? How many values were collected on Mondays in 2012?
# 251, 47
# 250, 47 <-
# 252, 47
# 365, 52
library(quantmod)
amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn)
y2012 <- as.Date(grep('^2012\\-',sampleTimes, value=T))
length(y2012)
length(grep('^Monday',weekdays(y2012)))





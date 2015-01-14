# Question 1
# Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.
# 2014-01-04T21:06:44Z
# 2013-11-07T13:25:07Z
# 2012-06-21T17:28:38Z
# 2014-02-06T16:13:11Z
# 
# Question 2
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called
# acs
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# 
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
# sqldf("select pwgtp1 from acs")
# sqldf("select * from acs")
# sqldf("select * from acs where AGEP < 50")
# sqldf("select pwgtp1 from acs where AGEP < 50")
# 
# Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
# sqldf("select unique * from acs")
# sqldf("select distinct AGEP from acs")
# sqldf("select distinct pwgtp1 from acs")
# sqldf("select unique AGEP from acs")
# 
# Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
#   
#   http://biostat.jhsph.edu/~jleek/contact.html 
# 
# (Hint: the nchar() function in R may be helpful)
# 45 31 7 31
# 45 31 7 25
# 45 0 2 2
# 45 31 2 25
# 43 99 7 25
# 43 99 8 6
# 45 92 7 2
# 
# Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
# 
# (Hint this is a fixed width file format)
# 222243.1
# 101.83
# 32426.7
# 35824.9
# 28893.3
# 36.5

# Question 1
# Client ID
# 4e7dd46f9a4ed510de35
# Client Secret
# 18ff64b92db01413feaeacaca9243ae4f01d3b17

# https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
 

library(httr)


# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
# Insert your client ID and secret below - if secret is omitted, it will
# look it up in the GITHUB_CONSUMER_SECRET environmental variable.
Sys.setenv(GITHUB_CONSUMER_SECRET = "18ff64b92db01413feaeacaca9243ae4f01d3b17")
myapp <- oauth_app("github", "4e7dd46f9a4ed510de35")
# "18ff64b92db01413feaeacaca9243ae4f01d3b17"

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)


# 4. Use API
gtoken <- config(token = github_token)
# req <- GET("https://api.github.com/rate_limit", gtoken)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)

library(jsonlite)
json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1)) # data.frame
names(json2) # use "url" to find out which is datasharing
json2$url # it is row number 5
json2[ json2$url == "https://api.github.com/repos/jtleek/datasharing", ]

json2$created_at[[5]]
# [1] "2013-11-07T13:25:07Z"



# Question 2
library(sqldf) # cannot install this on my R version but answer is sort of clear anyway
dateDownloaded <- date()
dateDownloaded
acs <- read.table("./data/ss06pid.csv", sep = ",", header = TRUE)
head(acs)
sqldf("select pwgtp1 from acs where AGEP < 50")


# Question 3
length(unique(acs$AGEP))
dim(sqldf("select distinct AGEP from acs"))


# Question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode
length(htmlCode)
nchar(htmlCode[c(10,20,30,100)])


# Question 5
# fixed width file
fwdata <- read.fwf("./data//wksst8110.for", width = c(10,9,4,9,4,9,4,9,4),  skip = 4, header = F)
#fwdata <- read.table("./data//wksst8110.for")
fwdata
sum(fwdata[4])







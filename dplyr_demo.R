library(dplyr)
#fileUrl <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds"
#download.file(fileUrl, destfile = "./chicago.rds", method = "curl")
chicago <-readRDS("./data/chicago.rds")
dim(chicago)

# select
head(select(chicago, 1:5))
names(chicago)
names(chicago)[1:3]
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
# equivalent of the '-' for exclusion using "plain" R
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

# filter
chic.f <- filter(chicago, pm25tmean2 > 20)
head(select(chic.f, 1:3, pm25tmean2), 10)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(select(chic.f, 1:3, pm25tmean2, tmpd), 10)

# arrange
chicago <- arrange(chicago, date)
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)
chicago <- arrange(chicago, desc(date)) # descending order
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)

# rename
head(chicago[,1:5], 3)
chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)
head(chicago[,1:5], 3)


# mutate
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = T))
head(select(chicago, pm25, pm25detrend))

# group_by, generating summary statistics by stratum
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels=c("cold","hot") ))
hotcold <- group_by(chicago, tempcat)
summarize(hotcold, pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2), no2 = median(no2tmean2))
#
chicago <- mutate(chicago,  year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2, na.rm = T), no2 = median(no2tmean2, na.rm = T))

# pipeline operator %>%
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2, na.rm = T), no2 = median(no2tmean2, na.rm = T))

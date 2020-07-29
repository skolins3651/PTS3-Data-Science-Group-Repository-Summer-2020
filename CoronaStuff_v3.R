# coronavirus (COVID-19) data

# Data Cleaning ----
# reading in the data, checking to see if it worked
# source: https://www.kaggle.com/imdevskp/corona-virus-report
?read.csv
corona <- read.csv("country_wise_latest.csv")
head(corona)
tail(corona)

# Libraries ----
library(ggplot2) # 3.3.2

# Visualizations ----
# bar graph of confirmed cases for each country/region
# use geom_bar(stat = 'identity') for continuous Y-axis data
# theme() makes text smaller, angles it, and aligns the end of it along x-axis
ggplot(corona, aes(x = Country.Region, y = Confirmed)) + 
  geom_bar(stat = 'identity') + 
  theme(axis.text.x = element_text(size = 5, angle = 45, vjust=1, hjust=1))

# Mental Health Data ----
# source: https://www.statista.com/statistics/1109207/covid-19-pandemic-share-of-persons-worried-about-their-mental-health/
# proportion in Germany, US, UK concerned about mental health during pandemic
germany.mental <- c(0.31, 0.29, 0.22, 0.28, 0.33)
us.mental <- c(0.27, 0.22, 0.33, 0.18, 0.30)
uk.mental <- c(0.41, 0.35, 0.31, 0.38, 0.34)
date <- c("2020-03-23", "2020-03-24", "2020-03-25", "2020-03-26", "2020-03-27")
date <- as.Date(date)

# create data frame mental.health
mental.health <- data.frame(date, germany.mental, uk.mental, us.mental)
mental.health

# rename rows and columns
names(mental.health) <- c("Date", "Germany", "US", "UK")
mental.health

# Line Plot of Data ----
# color guide for legend
mental.colors <- c("Germany" = "dodgerblue3", "UK" = "black", "US" = "gray75")

# the actual line plot
ggplot(mental.health, aes(x = date)) + 
  geom_line(aes(y = germany.mental, color = "Germany"), size = 2) +
  geom_point(aes(y = germany.mental, color = "Germany"), size = 4) +
  geom_line(aes(y = uk.mental, color = "UK"), size = 2) +
  geom_point(aes(y = uk.mental, color = "UK"), size = 4) +
  geom_line(aes(y = us.mental, color = "US"), size = 2) +
  geom_point(aes(y = us.mental, color = "US"), size = 4) +
  scale_y_continuous(labels=scales::percent) +
  labs(x = "Date", y = "Share of respondents", color = "Legend") +
  scale_color_manual(values = mental.colors) +
  ggtitle("Share of persons concerned about mental health during pandemic 2020")

# Mental Health Search Data and Cleaning ----
# source: https://www.kaggle.com/luckybro/mental-health-search-term?
mental_search.us <- read.csv("search_term_us.csv")
mental_search.uk <- read.csv("search_term_uk.csv")
mental_search.it <- read.csv("search_term_italy.csv")
date <- mental_search.us$Week # same for all three data frames

# collate depression data from 3 countries into one data frame
depression <- data.frame(date, mental_search.us$depression, 
                         mental_search.uk$depression, 
                         mental_search.it$depression)
colnames(depression) <- c("Date", "US", "UK", "Italy")
head(depression)
str(depression)
# convert date column into Date class
depression$Date <- as.Date(depression$Date, "%m/%d/%Y")
# the string "%m/%d/%Y" tells R that the date will be in the format MM/DD/YYYY
depression$Date
head(depression)

# Line Plot of Mental Health Search ----
# code is similar to mental health data from Statista
depression.colors <- c("US" = "cadetblue2",
                       "UK" = "cadetblue3",
                       "Italy" = "cadetblue4")
# data frame for geom_vline information
v <- data.frame(first = as.Date(c("2020-01-20", "2020-01-31")),
                lab = c("US first case", "UK/Italy first case"),
                clr = c("cadetblue2", "cadetblue4"))
ggplot(depression, aes(x = Date)) +
  geom_vline(v, mapping = aes(xintercept = first), color = v$clr, linetype = "longdash") +
  geom_line(aes(y = US, color = "US"), size = 2) +
  geom_point(aes(y = US, color = "US"), size = 4) +
  geom_line(aes(y = UK, color = "UK"), size = 2) +
  geom_point(aes(y = UK, color = "UK"), size = 4) +
  geom_line(aes(y = Italy, color = "Italy"), size = 2) +
  geom_point(aes(y = Italy, color = "Italy"), size = 4) +
  geom_text(v, mapping = aes(x = first, y = 0, label = lab), color = v$clr, 
            size = 3, angle = 90, vjust = -0.4, hjust = 0) +
  labs(x = "Date", y = "Search interest", color = "Legend") +
  scale_color_manual(values = depression.colors) +
  ggtitle("Popularity of search term 'depression' in different countries during pandemic") +
  theme(plot.title = element_text(size = 12))
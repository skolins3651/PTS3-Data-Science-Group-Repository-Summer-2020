# coronavirus (COVID-19) data

# Data Cleaning ----
# reading in the data, checking to see if it worked
# source: https://www.kaggle.com/imdevskp/corona-virus-report
?read.csv
corona <- read.csv("country_wise_latest.csv")
head(corona)
tail(corona)

# Libraries ----
library(ggplot2)

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

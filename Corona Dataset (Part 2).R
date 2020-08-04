# coronavirus (COVID19) data

#source: https://www.kaggle.com/imdevskp/corona-virus-report
?read.csv
corona<-read.csv("country_wise_latest.csv")
head(corona)
tail(corona)

#libraries used
library(ggplot2)

# bar graph of confirmed cases for each country/region
ggplot(corona,aes(x = Country.Region, y = Confirmed)) + geom_bar(stat = "identity")

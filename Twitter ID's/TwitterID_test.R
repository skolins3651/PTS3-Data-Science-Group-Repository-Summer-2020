# testing conversion of tweet ID's to tweets using Hydrator
# sentiment analysis using ???

# Creating Data ----
# all data sourced from here: https://github.com/echen102/COVID-19-TweetIDs
# in particular, tweets taken from 12:00 UTC (8 AM EST) April 1, 2020 file
tweet_test <- read.csv("test_2020-04-01-12.csv")
str(tweet_test)
head(tweet_test)

# Data Cleaning ----

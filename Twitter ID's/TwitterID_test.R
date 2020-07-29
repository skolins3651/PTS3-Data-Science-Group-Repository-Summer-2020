# testing conversion of tweet ID's to tweets using Hydrator
# sentiment analysis using ???

# Libraries ----
# sentimentr is not included in Lehman's RStudio Server, so we'll have to install it
install.packages("sentimentr")
library(sentimentr) # 2.7.1
library(ggplot2) # 3.3.2

# Creating Data ----
# all data sourced from here: https://github.com/echen102/COVID-19-TweetIDs
# in particular, tweets taken from 12:00 UTC (8 AM EST) April 1, 2020 file
tweet_test <- read.csv("test_2020-04-01-12.csv")
str(tweet_test)
head(tweet_test)

# Data Cleaning ----
# need to select only English tweets
# variable must not be a factor variable
tweets_en <- as.character(tweet_test$text[tweet_test$lang == 'en'])

# Sentiment Analysis ----
# guide source: https://towardsdatascience.com/doing-your-first-sentiment-analysis-in-r-with-sentimentr-167855445132
# one of the main functions that runs a sentiment analysis is "sentiment_by"
?sentiment_by
sentiment_by(tweets_en)
# warning: this will take some time!
sentiment_by(get_sentences(tweets_en)) # supposedly takes less time/memory

tweet_sentiment <- sentiment_by(get_sentences(tweets_en))
head(tweet_sentiment)
head(tweet_sentiment$ave_sentiment, 20)

# data frame comparing tweets to their scores
text_sentiment <- data.frame(tweets_en, tweet_sentiment$ave_sentiment, tweet_sentiment$sd)
head(text_sentiment)

# Histogram of Sentiment Scores ----
ggplot(tweet_sentiment, aes(ave_sentiment)) + geom_histogram() +
  xlab("Sentiment Score") + ylab("Frequency") +
  ggtitle("Sentiment Scores of April 1, 2020 8-9 AM EST COVID Tweets")

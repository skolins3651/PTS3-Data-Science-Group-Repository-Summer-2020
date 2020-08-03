# don't use this! it will only read the Git LFS pointer file!
corona_feb01 <- read.csv("./Twitter ID's/coronavirus-tweet-id-2020-02-01-00.csv")

# use this instead!
library(readr)
corona_feb01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-02-01-00.csv")
View(corona_feb01)
head(corona_feb01)

corona_jul01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-07-01-15.csv")
head(corona_jul01)
str(corona_jul01)

# do this for all datasets

# Libraries ----
# sentimentr is not included in Lehman's RStudio Server, so we'll have to install it
install.packages("sentimentr")
library(sentimentr) # 2.7.1
library(ggplot2) # 3.3.2

# Data Cleaning ----
# need to select only English tweets
# variable must not be a factor variable
tweets_jul01_en <- as.character(corona_jul01$text[corona_jul01$lang == 'en'])

# Sentiment Analysis ----
# guide source: https://towardsdatascience.com/doing-your-first-sentiment-analysis-in-r-with-sentimentr-167855445132
# one of the main functions that runs a sentiment analysis is "sentiment_by"
?sentiment_by
sentiment_by(tweets_jul01_en)
# warning: this will take some time!
sentiment_by(get_sentences(tweets_jul01_en)) # supposedly takes less time/memory

tweet_sentiment_jul01 <- sentiment_by(get_sentences(tweets_jul01_en))
head(tweet_sentiment_jul01)
head(tweet_sentiment_jul01$ave_sentiment, 20)

# data frame comparing tweets to their scores
text_sentiment_jul01 <- data.frame(tweets_jul01_en, tweet_sentiment_jul01$ave_sentiment, tweet_sentiment_jul01$sd)
head(text_sentiment_jul01)

# Histogram of Sentiment Scores ----
ggplot(tweet_sentiment_jul01, aes(ave_sentiment)) + geom_histogram() +
  xlab("Sentiment Score") + ylab("Frequency") +
  ggtitle("Sentiment Scores of July 1, 2020 11-12 AM EST COVID Tweets")
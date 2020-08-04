# use this instead!
library(readr)
corona_June01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-06-01-16.csv")
head(corona_June01)
str(corona_June01)

# do this for all datasets

# Libraries ----
# sentimentr is not included in Lehman's RStudio Server, so we'll have to install it
install.packages("sentimentr")
library(sentimentr) # 2.7.1
library(ggplot2) # 3.3.2

# Data Cleaning ----
# need to select only English tweets
# variable must not be a factor variable
tweets_June01_en <- as.character(corona_June01$text[corona_June01$lang == 'en'])

# Sentiment Analysis ----
# guide source: https://towardsdatascience.com/doing-your-first-sentiment-analysis-in-r-with-sentimentr-167855445132
# one of the main functions that runs a sentiment analysis is "sentiment_by"
?sentiment_by
sentiment_by(tweets_June01_en)
# warning: this will take some time!
sentiment_by(get_sentences(tweets_June01_en)) # supposedly takes less time/memory

tweet_sentiment_June01 <- sentiment_by(get_sentences(tweets_June01_en))
head(tweet_sentiment_June01)
head(tweet_sentiment_June01$ave_sentiment, 20)

# data frame comparing tweets to their scores
text_sentiment_June01 <- data.frame(tweets_June01_en, tweet_sentiment_June01$ave_sentiment, tweet_sentiment_June01$sd)
head(text_sentiment_June01)

# Histogram of Sentiment Scores ----
ggplot(tweet_sentiment_June01, aes(ave_sentiment)) + geom_histogram() +
  xlab("Sentiment Score") + ylab("Frequency") +
  ggtitle("Sentiment Scores of June 1, 2020 11-12 AM EST COVID Tweets")

# Smooth Distribution of Sentiment Scores ----
ggplot(tweet_sentiment_June01, aes(ave_sentiment)) + geom_density() +
  xlab("Sentiment Score") + ylab("Density") +
  ggtitle("Sentiment Scores Distribution of June 1 , 2020 11-12 AM EST COVID Tweets")

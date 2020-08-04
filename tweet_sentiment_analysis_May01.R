library(readr)
corona_May01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-05-01-18.csv")
head(corona_May01)
str(corona_May01)

install.packages("sentimentr")
library(sentimentr) # 2.7.1
library(ggplot2) # 3.3.2

tweets_May01_en <- as.character(corona_May01$text[corona_May01$lang == 'en'])

# Sentiment Analysis ----
# guide source: https://towardsdatascience.com/doing-your-first-sentiment-analysis-in-r-with-sentimentr-167855445132
# one of the main functions that runs a sentiment analysis is "sentiment_by"
?sentiment_by
sentiment_by(tweets_May01_en)
# warning: this will take some time!
sentiment_by(get_sentences(tweets_May01_en)) # supposedly takes less time/memory

tweet_sentiment_May01 <- sentiment_by(get_sentences(tweets_May01_en))
head(tweet_sentiment_May01)
head(tweet_sentiment_May01$ave_sentiment, 20)

# data frame comparing tweets to their scores
text_sentiment_May01 <- data.frame(tweets_May01_en, tweet_sentiment_May01$ave_sentiment, tweet_sentiment_May01$sd)
head(text_sentiment_May01)

# Histogram of Sentiment Scores ----
ggplot(tweet_sentiment_May01, aes(ave_sentiment)) + geom_histogram() +
  xlab("Sentiment Score") + ylab("Frequency") +
  ggtitle("Sentiment Scores of May 1, 2020 2-3 PM EST COVID Tweets")

# Smooth Distribution of Sentiment Scores ----
ggplot(tweet_sentiment_May01, aes(ave_sentiment)) + geom_density() +
  xlab("Sentiment Score") + ylab("Density") +
  ggtitle("Sentiment Scores Distribution of May 1 , 2020 2-3 PM EST COVID Tweets")


library(readr)
corona_Apr03 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-04-03-20.csv")
head(corona_Apr03)
str(corona_Apr03)

install.packages("sentimentr")
library(sentimentr) # 2.7.1
library(ggplot2) # 3.3.2

tweets_Apr03_en <- as.character(corona_Apr03$text[corona_Apr03$lang == 'en'])

# Sentiment Analysis ----
# guide source: https://towardsdatascience.com/doing-your-first-sentiment-analysis-in-r-with-sentimentr-167855445132
# one of the main functions that runs a sentiment analysis is "sentiment_by"
?sentiment_by
sentiment_by(tweets_Apr03_en)
# warning: this will take some time!
sentiment_by(get_sentences(tweets_Apr03_en)) # supposedly takes less time/memory

tweet_sentiment_Apr03 <- sentiment_by(get_sentences(tweets_Apr03_en))
head(tweet_sentiment_Apr03)
head(tweet_sentiment_Apr03$ave_sentiment, 20)

# data frame comparing tweets to their scores
text_sentiment_Apr03 <- data.frame(tweets_Apr03_en, tweet_sentiment_Apr03$ave_sentiment, tweet_sentiment_Apr03$sd)
head(text_sentiment_Apr03)

# Histogram of Sentiment Scores ----
ggplot(tweet_sentiment_Apr03, aes(ave_sentiment)) + geom_histogram() +
  xlab("Sentiment Score") + ylab("Frequency") +
  ggtitle("Sentiment Scores of April 3, 2020 4-5 PM EST COVID Tweets")

# Smooth Distribution of Sentiment Scores ----
ggplot(tweet_sentiment_Apr03, aes(ave_sentiment)) + geom_density() +
  xlab("Sentiment Score") + ylab("Density") +
  ggtitle("Sentiment Score Distribution of April 3, 2020 4-5 PM EST COVID Tweets")


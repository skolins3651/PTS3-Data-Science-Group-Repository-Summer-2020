library(readr)
corona_feb01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-02-18-22.csv")
View(corona_feb01)
head(corona_feb01)

corona_Mar17 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-03-17-15.csv")
head(corona_Mar17)
str(corona_Mar17)

install.packages("sentimentr")
library(sentimentr) # 2.7.1
library(ggplot2) # 3.3.2

tweets_Mar17_en <- as.character(corona_Mar17$text[corona_Mar17$lang == 'en'])

# Sentiment Analysis ----
# guide source: https://towardsdatascience.com/doing-your-first-sentiment-analysis-in-r-with-sentimentr-167855445132
# one of the main functions that runs a sentiment analysis is "sentiment_by"
?sentiment_by
sentiment_by(tweets_Mar17_en)
# warning: this will take some time!
sentiment_by(get_sentences(tweets_Mar17_en)) # supposedly takes less time/memory

tweet_sentiment_Mar17 <- sentiment_by(get_sentences(tweets_Mar17_en))
head(tweet_sentiment_Mar17)
head(tweet_sentiment_Mar17$ave_sentiment, 20)

# data frame comparing tweets to their scores
text_sentiment_Mar17 <- data.frame(tweets_Mar17_en, tweet_sentiment_Mar17$ave_sentiment, tweet_sentiment_Mar17$sd)
head(text_sentiment_Mar17)

# Histogram of Sentiment Scores ----
ggplot(tweet_sentiment_Mar17, aes(ave_sentiment)) + geom_histogram() +
  xlab("Sentiment Score") + ylab("Frequency") +
  ggtitle("Sentiment Scores of Mar 17, 2020 11-12 AM EST COVID Tweets")

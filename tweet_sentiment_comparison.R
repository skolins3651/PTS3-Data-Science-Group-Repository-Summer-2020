install.packages("sentimentr")
library(sentimentr) # 2.7.1
library(ggplot2) # 3.3.2

corona_Feb18 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-02-18-22.csv")
corona_Mar17 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-03-17-15.csv")
corona_Apr03 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-04-03-20.csv")
corona_May01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-05-01-18.csv")
corona_June01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-06-01-16.csv")
corona_jul01 <- read_csv("https://media.githubusercontent.com/media/skolins3651/PTS3-Data-Science-Group-Repository-Summer-2020/master/Twitter%20ID's/coronavirus-tweet-id-2020-07-01-15.csv")

tweets_Feb18_en <- as.character(corona_Feb18$text[corona_Feb18$lang == 'en'])
tweets_Mar17_en <- as.character(corona_Mar17$text[corona_Mar17$lang == 'en'])
tweets_Apr03_en <- as.character(corona_jul01$text[corona_Apr03$lang == 'en'])
tweets_May01_en <- as.character(corona_jul01$text[corona_May01$lang == 'en'])
tweets_june01_en <- as.character(corona_jul01$text[corona_june01$lang == 'en'])
tweets_jul01_en <- as.character(corona_jul01$text[corona_jul01$lang == 'en'])

# Sentiment Analysis ----
# guide source: https://towardsdatascience.com/doing-your-first-sentiment-analysis-in-r-with-sentimentr-167855445132

tweet_sentiment_Feb18 <- sentiment_by(get_sentences(tweets_Feb18_en))
head(tweet_sentiment_Feb18)
head(tweet_sentiment_Feb18$ave_sentiment, 20)

tweet_sentiment_Mar17 <- sentiment_by(get_sentences(tweets_Mar17_en))
head(tweet_sentiment_Mar17)
head(tweet_sentiment_Mar17$ave_sentiment, 20)

tweet_sentiment_Apr03 <- sentiment_by(get_sentences(tweets_Apr03_en))
head(tweet_sentiment_jul01)
head(tweet_sentiment_jul01$ave_sentiment, 20)

tweet_sentiment_May01 <- sentiment_by(get_sentences(tweets_May01_en))
head(tweet_sentiment_jul01)
head(tweet_sentiment_jul01$ave_sentiment, 20)

tweet_sentiment_june01 <- sentiment_by(get_sentences(tweets_june011_en))
head(tweet_sentiment_jul01)
head(tweet_sentiment_jul01$ave_sentiment, 20)

# data frame comparing tweets to their scores
text_sentiment_Feb18 <- data.frame(tweets_Feb18_en, tweet_sentiment_Feb18$ave_sentiment, tweet_sentiment_Feb18$sd)
head(text_sentiment_Feb18)

text_sentiment_Mar17 <- data.frame(tweets_Mar17_en, tweet_sentiment_Mar17$ave_sentiment, tweet_sentiment_Mar17$sd)
head(text_sentiment_Mar17)

text_sentiment_Apr03 <- data.frame(tweets_Apr03_en, tweet_sentiment_Apr03$ave_sentiment, tweet_sentiment_Apr03$sd)
head(text_sentiment_Apr03)

text_sentiment_May01 <- data.frame(tweets_May01_en, tweet_sentiment_May01$ave_sentiment, tweet_sentiment_May01$sd)
head(text_sentiment_Mayl01)

text_sentiment_june01 <- data.frame(tweets_june01_en,tweet_sentiment_june01$ave_sentimen, tweet_sentiment_june01$sd)
head(text_sentiment_june01)

text_sentiment_jul01 <- data.frame(tweets_jul01_en, tweet_sentiment_jul01$ave_sentiment, tweet_sentiment_jul01$sd)
head(text_sentiment_jul01)

# Smooth Distribution of Sentiment Scores ----

sentiment_colors <- c("March 17, 11-12 AM" = "black", "February 18, 6-7 PM" = "red","April 3, 4-5 PM" = "purple", "May 1, 2-3 PM" = "brown", "June 1, 11-12 AM" = "yellow" ,  "July 1, 11-12 AM" = "blue")

ggplot(tweet_sentiment_Mar17, aes(ave_sentiment, color = "March 17, 11-12 AM")) + geom_density() +
  geom_density(data = tweet_sentiment_Feb18, aes(ave_sentiment, color = "February 18, 6-7 PM")) +
geom_density(data = tweet_sentiment_Apr03, aes(ave_sentiment, color = "April 3, 4-5 PM")) +
geom_density(data = tweet_sentiment_May01, aes(ave_sentiment, color = " May 1, 2-3 PM")) +
geom_density(data = tweet_sentiment_June01, aes(ave_sentiment, color = "June 1, 11-12 AM")) +
  geom_density(data = tweet_sentiment_jul01, aes(ave_sentiment, color = "July 1, 11-12 AM")) +
  labs(x = "Sentiment Score", y = "Density", color = "Legend") +
  scale_color_manual(values = sentiment_colors) +
  ggtitle("Comparison of Sentiment Scores for COVID Tweets (February-July 2020)")

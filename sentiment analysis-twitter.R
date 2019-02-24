##steps to get your key:##https://medium.com/@GalarnykMichael/accessing-data-from-twitter-api-using-r-part1-b387a1c7d3e
#NPL ?
#web crawler?

#library("curl")
library("twitteR")
library("ROAuth")
library("syuzhet") #library for sentiment analysis - comparison


consumer_key='uRDuync3BziwQnor1MZFBKp0x'
consumer_secret='t8QPLr7RKpAg4qa7vth1SBsDvoPKawwwdEhNRjdpY0mfMMdRnV'
access_token='14366551-Fga25zWM1YefkTb2TZYxsrx2LVVSsK0uSpF08sugW'
access_token_secret='3ap8BZNVoBhE2GaMGLfuvuPF2OrHzM3MhGuPm96p3k6Cz'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_token_secret)

no.of.tweets <- 100

tweets <- searchTwitter("bitcoin", n=no.of.tweets,lang="en")
tweets
tweets[1:10]
tweets_user = twListToDF(tweets) 

tweets.df2 <- gsub("http.*","",tweets_user$text)#gsub is replacement func
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)

tweets = userTimeline("imVkohli", n=100)#to find the time
tweets[1:5]
n.tweet <- length(tweets)#length of tweets
n.tweet
tweets.df = twListToDF(tweets) 
head(tweets.df)
summary(tweets.df)
#Remove hashtags & unnecessary characters
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)

head(tweets.df2)

library("syuzhet") #library for sentiment analysis - comparison
word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets.df2, emotion.df) 
head(emotion.df2)
emotion.df2
word.df
#combining a word- engrams  two words-bigrams (update dictionary or use engrams to better the analysis)

#-----
sent.value <- get_sentiment(word.df)#get sentiments out of particular things
sent.value
tweets[c(16,62)]
most.positive <- word.df[sent.value == max(sent.value)]#== checks equality
most.positive
most.negative<- word.df[sent.value <= min(sent.value)] 
most.negative
sent.value

#-----
positive.tweets <- word.df[sent.value > 0]
head(positive.tweets)
negative.tweets <- word.df[sent.value < 0] 
head(negative.tweets)
neutral.tweets <- word.df[sent.value == 0]
head(neutral.tweets)

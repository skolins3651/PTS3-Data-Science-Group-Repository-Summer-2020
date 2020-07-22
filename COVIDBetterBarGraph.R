# Importing the Data ----
# source: https://www.kaggle.com/imdevskp/corona-virus-report
corona <- read.csv("country_wise_latest.csv")
head(corona)
tail(corona)

# Libraries ----
library(ggplot2) # 3.3.2
library(dplyr) # 0.8.3, for Different Approach

# Visualizations ----
# bar graph of confirmed cases for each country/region
# use geom_bar(stat = 'identity') for continuous Y-axis data
# theme() makes text smaller, angles it, and aligns the end of it along x-axis
ggplot(corona, aes(x = Country.Region, y = Confirmed)) + 
  geom_bar(stat = 'identity') + 
  theme(axis.text.x = element_text(size = 5, angle = 45, vjust=1, hjust=1))

# Improving the Graph #1 ----
# this graph is bad! hard to interpret or read anything!
# let's make a new one that only has the countries with 100K+ cases
corona.100K <- corona[corona$Confirmed >= 100000, 1:2]
head(corona.100K)
tail(corona.100K)

# new graph
ggplot(corona.100K, aes(x = Country.Region, y = Confirmed)) + 
  geom_bar(stat = 'identity') + 
  theme(axis.text.x = element_text(angle = 45, vjust=1, hjust=1))

# Improving the Graph #2 ----
# can do better by ordering data and changing y-axis to remove sci notation
# new graph for this variant
ggplot(corona.100K, aes(x = reorder(Country.Region, -Confirmed), y = Confirmed)) + 
  geom_bar(stat = 'identity') + 
  theme(axis.text.x = element_text(angle = 45, vjust=1, hjust=1)) +
  scale_y_continuous(labels = scales::comma) +
  xlab("Country") + ylab("Confirmed case count") +
  ggtitle("Countries with at least 100,000 confirmed COVID-19 cases (July 14, 2020)")

# optional reordering of data frame
corona.100K.ordered <- corona.100K[order(corona.100K$Confirmed, decreasing = TRUE), ]
head(corona.100K.ordered)
tail(corona.100K.ordered)

# Improving the Graph #3 ----
# add new observation The Rest for sum of all countries < 100K
corona.100K.rest.ordered.countries <- c(as.character(corona.100K.ordered$Country.Region), "The Rest")
corona.100K.rest.ordered.cases <- c(corona.100K.ordered$Confirmed, sum(corona$Confirmed[corona$Confirmed < 100000]))
corona.100K.rest.ordered <- data.frame(corona.100K.rest.ordered.countries, corona.100K.rest.ordered.cases)
colnames(corona.100K.rest.ordered) <- c("Country", "Cases")
tail(corona.100K.rest.ordered)

# plot, but with The Rest in red
rest.red <- c(rep(NA, 22), "withcolor" = "red")
ggplot(corona.100K.rest.ordered, aes(x = reorder(Country, -Cases), y = Cases, fill = rest.red)) + 
  geom_bar(stat = 'identity') + 
  theme(axis.text.x = element_text(angle = 45, vjust=1, hjust=1)) +
  scale_y_continuous(labels = scales::comma) +
  xlab("Country") + ylab("Confirmed case count") +
  ggtitle("Countries with at least 100,000 confirmed COVID-19 cases (July 14, 2020)") +
  theme(legend.position = "none")

# Different Approach #1 ----
# group countries/cases by WHO region using dplyr
corona.who <- dplyr::group_by(corona, WHO.Region)
who.summary <- dplyr::summarize(corona.who, count = n(), total_cases = sum(Confirmed))
who.summary

# convert to data frame
who.summary <- as.data.frame(who.summary)
who.summary

# plot
ggplot(who.summary, aes(x = WHO.Region, y = total_cases)) + 
  geom_bar(stat = 'identity') +
  scale_y_continuous(labels = scales::comma) +
  xlab("WHO Region") + ylab("Total case count in region") +
  ggtitle("COVID-19 case counts by WHO region (July 14, 2020)")

# Different Approach #2 ----
# pie chart with minimalist theme
ggplot(who.summary, aes(x = "", y = total_cases, fill = WHO.Region)) +
  geom_bar(width = 1, stat = 'identity') +
  coord_polar("y", start = 0) +
  theme_minimal() +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
  ggtitle("Proportion of COVID-19 cases by WHO region (July 14, 2020)")

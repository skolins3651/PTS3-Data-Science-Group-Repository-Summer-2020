library(swirl)
swirl()

# type Shift+3 hashtag "#" to add a comment!

# Lesson 4: Starting with Data
4
borough <- c('Bronx', 'Manhattan', 'Queens', 'Brooklyn', 'Staten Island')
has.baseball.team <- c('Yes', 'No', 'Yes', 'No', 'No')

# I() = declare nominal, as.factor() = declare factor
borough <- I(borough)
has.baseball.team <- as.factor(has.baseball.team)

# new is.mainland variable
is.mainland <- c('Yes', 'No', 'No', 'No', 'No')
is.mainland <- as.factor(is.mainland)

# new baseball.team variable
baseball.team <- c('Yankees', NA, 'Mets', NA, NA)
baseball.team <- I(baseball.team)

# new size variable (ordinal variable)
size <- c('Medium', 'Small', 'Large', 'Medium', 'Medium')
size <- as.factor(size)
sizeOrder <- c('Small', 'Medium', 'Large')
size <- ordered(size, levels = sizeOrder)

# create data frame: nycdata
nycdata <- data.frame(borough, has.baseball.team, is.mainland, baseball.team, 
                      population, square.miles, size)
nycdata
row.names(nycdata) <- borough # reassigns row names
nycdata
nycdata['Queens', 'population'] # population of Queens (via subsetting)
nycdata['Brooklyn', 'square.miles'] # area of Brooklyn
nycdata[4,6]
# subsetting: dataframename[row, column]. can use row/col names as well
# omit column to get entire row; omit row to get entire column
nycdata['Staten Island',]
nycdata[,'baseball.team']

# Lesson 5: More About Data Frames

# more useful data frame functions
colnames(nycdata)
str(nycdata)
summary(nycdata)
nrow(nycdata)
ncol(nycdata)
head(nycdata, 2)
tail(nycdata, 2)

# using $ for column notation
# == compares elements while identical() compares vectors
nycdata$square.miles == nycdata[, 'square.miles']
identical(nycdata$square.miles, nycdata[, 'square.miles'])
nycdata$has.baseball.team == nycdata[, 'has.baseball.team']
identical(nycdata$has.baseball.team, nycdata[, 'has.baseball.team'])

sqrt(nycdata$population)
sum(nycdata$population)

# using dplyr::rename() to rename columns
nycdata <- dplyr::rename(nycdata, geographic.size = size)
nycdata

# population.density variable
nycdata$population.density <- nycdata$population / nycdata$square.miles
nycdata

# Lesson 6: Start with Plots

library(ggplot2)

str(diamonds)
?diamonds

# plotting scatterplot: carat vs. price
ggplot(diamonds, aes(x=carat, y=price)) + geom_point()
myggplot <- ggplot(diamonds, aes(x=carat, y=price))
myggplot # notice that we need geom_point() to graph the actual data
myggplot + geom_point()

# behold the true power of ggplot2
mytitle <- ggtitle("Diamond Prices and Carats")
myggplot + geom_point() + mytitle
myggplot + geom_point(color="red") + mytitle
myggplot + geom_point(shape = 5) + mytitle
myggplot + geom_point(color = "blue", shape = 5) + mytitle

# facetting: create multiple plots that stratify by a third variable (e.g. clarity)
myggplot + geom_point(shape = 5, color = "blue") + mytitle + facet_wrap(~clarity)
mytitle <- ggtitle("Diamond Prices and Carats by Clarity")
myggplot + geom_point(shape = 5, color = "blue") + mytitle + facet_wrap(~clarity)

# alternative form of facetting
myggplot_clarity <- ggplot(diamonds, aes(x=carat, y=price, color=clarity))
myggplot_clarity + geom_point(shape = 5) + mytitle

# Lesson 7: Graphs of One Variable

library(ggplot2)

str(diamonds)

# an example of a graph of one variable is a histogram
ggplot_carat <- ggplot(diamonds, aes(carat))
carat_title <- ggtitle('Distribution of Diamond Weights in Carats')
ggplot_carat + geom_histogram() + carat_title
ggplot_carat + geom_histogram(binwidth = .1) + carat_title
ggplot_carat + geom_histogram(binwidth = .5) + carat_title
ggplot_carat + geom_histogram(binwidth = .2) + carat_title

# relative frequency histogram
ggplot_carat + geom_histogram(binwidth = .1, aes(y=..count../sum(..count..))) + carat_title

# alternative graphs of one variable
ggplot_carat + geom_freqpoly(binwidth = .1) + carat_title
ggplot_carat + geom_density() + carat_title

# overlaying two plots
ggplot_carat + geom_density() + geom_histogram(binwidth = .1, aes(y = ..density..)) + carat_title
ggplot_carat + geom_density(color="green") + geom_histogram(binwidth = .1, aes(y = ..density..)) + carat_title

# the graph that appears on top will be the last one written in the line
ggplot_carat + geom_histogram(binwidth = .1, aes(y = ..density..)) + geom_density(color="green")  + carat_title

# empirical cumulative distribution function: ECDF
ggplot_carat + stat_ecdf() + carat_title
summary(diamonds$carat)

# Lesson 8: Bar Graphs and Bar Charts

library(ggplot2)

# bar graph for color variable
ggplot(diamonds, aes(x=color)) + geom_bar() + ggtitle("Diamond Colors")
ggplot(diamonds, aes(x=color)) + geom_bar(color='blue', fill='purple') + ggtitle("Diamond Colors")
bar <- ggplot(diamonds, aes(x=color)) + ggtitle("Diamond Colors")

# relative frequency bar graph
bar + geom_bar(aes(y = ((..count..)/sum(..count..))))
bar + geom_bar(aes(y = ((..count..)/sum(..count..)))) + scale_y_continuous(labels=scales::percent)
bar + geom_bar(color="blue", fill="purple", aes(y = (..count..)/sum(..count..))) + scale_y_continuous(labels=scales::percent)
bar + geom_bar(color="blue", fill="purple", aes(y = (..count..)/sum(..count..))) + scale_y_continuous(labels=scales::percent) + ylab("Percent")

# data summary using dplyr package
by_color <- dplyr::group_by(diamonds, color)
color_summary <- dplyr::summarize(by_color, count=n(), mean_price = mean(price), median_price = median(price))
color_summary

# creating bar chart using summary data
ggplot(color_summary, aes(x=color, y=count)) + geom_bar(stat='identity', color='blue', fill='purple') + ggtitle('Diamond Colors')
ggplot(color_summary, aes(x=color, y=mean_price)) + geom_bar(stat='identity', color='blue', fill='purple') + ggtitle('Diamond Colors')
ggplot(color_summary, aes(x=color, y=median_price)) + geom_bar(stat='identity', color='blue', fill='purple') + ggtitle('Diamond Colors') + coord_flip()

# widths don't matter
ggplot(color_summary, aes(x=color, y=median_price)) + geom_point(stat='identity', color='blue', fill='purple') + ggtitle('Diamond Colors')
ggplot(color_summary, aes(x=color, y=median_price)) + geom_point(stat='identity', color='blue', fill='purple', size = 5) + ggtitle('Diamond Colors')

# Lesson 9: Starting Statistics

# using the (controversial) iris data set
head(iris)
?iris
str(iris)

# measures of central tendency: mean, median
mean(iris$Sepal.Length, na.rm=TRUE)
mean(iris$Petal.Length, na.rm=TRUE)
median(iris$Sepal.Length, na.rm=TRUE)
median(iris$Sepal.Width, na.rm=TRUE)

# quantiles
quantile(iris$Sepal.Length, .5, na.rm=TRUE)
quantile(iris$Sepal.Width, .5, na.rm=TRUE)
quantile(iris$Sepal.Length, 0, na.rm=TRUE)
min(iris$Sepal.Length, na.rm=TRUE)
max(iris$Sepal.Length, na.rm=TRUE)
quantile(iris$Sepal.Length, 1, na.rm=TRUE)

# measures of variation: range
quantile(iris$Sepal.Length, 1, na.rm=TRUE) - quantile(iris$Sepal.Length, 0, na.rm=TRUE)
quantile(iris$Sepal.Width, 1, na.rm=TRUE) - quantile(iris$Sepal.Width, 0, na.rm=TRUE)
range(iris$Sepal.Length, na.rm = TRUE)

# custom range function (if desired)
my.range <- function(vec) {return(max(vec, na.rm = TRUE) - min(vec, na.rm = TRUE))}

# multiple quantiles
quantile(iris$Sepal.Length, probs = c(.25, .5, .75, 1), na.rm = TRUE)

# interquartile range (IQR)
quantile(iris$Sepal.Width, .75, na.rm=TRUE) - quantile(iris$Sepal.Width, .25, na.rm=TRUE)
IQR(iris$Sepal.Width, na.rm=TRUE)
IQR(iris$Sepal.Length, na.rm=TRUE)

# measure of central tendency: mode
table(iris$Sepal.Length)
mode(iris$Sepal.Length) # unexpected output!
MODE(iris$Sepal.Length) # uses lehmansociology package

# Lesson 10: Dichotomizing Variables

nycdata
str(nycdata$has.baseball.team)
table(nycdata$has.baseball.team)
prop.table(table(nycdata$has.baseball.team))

# mean doesn't work!
mean(nycdata$has.baseball.team)

# dichotomizing the variable
nycdata$has.baseball.team.logical <- nycdata$has.baseball.team == 'Yes'
nycdata$has.baseball.team.logical
table(nycdata$has.baseball.team.logical)
prop.table(table(nycdata$has.baseball.team.logical))
mean(nycdata$has.baseball.team.logical)
nycdata$has.baseball.team.numeric <- as.numeric(nycdata$has.baseball.team.logical)
nycdata$has.baseball.team.numeric
mean(nycdata$has.baseball.team.numeric)

# TRUE = 1, FALSE = 0
nycdata$has.baseball.team.logical == nycdata$has.baseball.team.numeric
identical(nycdata$has.baseball.team.logical, nycdata$has.baseball.team.numeric)

# can reverse the roles of TRUE and FALSE
nycdata$no.baseball.team <- nycdata$has.baseball.team == 'No'
mean(nycdata$no.baseball.team)

# Lesson 11: More on Dichotomizing

# we can dichotomize quantitative data as well
nycdata$population.2millionplus <- nycdata$population >= 2000000
nycdata$population.2millionplus

# a more complex example
table(nycdata$baseball.team)
table(nycdata$baseball.team, useNA = 'always')
prop.table(table(nycdata$baseball.team))
nycdata$yankees <- nycdata$baseball.team == 'Yankees'
nycdata$yankees # not ideal! how to fix?
is.na(nycdata$baseball.team)
nycdata$yankees <- nycdata$baseball.team == "Yankees" & is.na(nycdata$baseball.team) == FALSE
nycdata$yankees # got it!
nycdata$mets <- nycdata$baseball.team == "Mets" & is.na(nycdata$baseball.team) == FALSE
nycdata$mets
nycdata$no.team <- is.na(nycdata$baseball.team)
nycdata[, c('yankees', 'mets', 'no.team')]

# Lesson 12: Boxplots

library(ggplot2)

# using diamond data
fivenum(diamonds$carat)
carat.5num <- fivenum(diamonds$carat)
carat.5num[1] # minimum
carat.5num[5] # maximum

# univariate plot
carat.plot <- ggplot(diamonds, aes(x = carat))
carat.plot + geom_histogram(binwidth = .1)
carat.plot + stat_ecdf()

# adding 5 line geoms to indicate 5 num summary
vline1 <- geom_vline(xintercept = carat.5num[1])
vline2 <- geom_vline(xintercept = carat.5num[2])
# vlineX <- geom_vline(xintercept = carat.5num[X]) for X = 3, 4, 5
carat.plot + geom_histogram(binwidth = .1) + vline1 + vline2 + vline3 + vline4 + vline5
carat.plot + stat_ecdf() + vline1 + vline2 + vline3 + vline4 + vline5

# the actual boxplot
ggplot(diamonds, aes(x=factor(0), y=carat)) + geom_boxplot()
ggplot(diamonds, aes(x=factor(0), y=carat)) + geom_boxplot() + coord_flip()
ggplot(diamonds, aes(x=clarity, y=carat)) + geom_boxplot() + coord_flip()


# Lesson 13: The Mean

?chickwts
mean(chickwts$weight, na.rm = TRUE)
mean(chickwts$feed) # doesn't work because feed is not logical or numeric
sum(chickwts$weight) / nrow(chickwts)
chickwts$mean_weight <- mean(chickwts$weight)
summary(chickwts)
sum(chickwts$mean_weight)
sum(chickwts$weight)

30 * 42
(15*24 + 15*60)/30

chickwts$weight_deviation <- chickwts$weight - chickwts$mean_weight
tail(chickwts)
summary(chickwts)
IQR(chickwts$weight) == IQR(chickwts$weight_deviation)
sum(chickwts$weight_deviation)

# the sum is not quite zero due to rounding error
round(sum(chickwts$weight_deviation), 11)

# sum of all deviations ABOVE zero
sum(chickwts$weight_deviation[chickwts$weight_deviation > 0])
sum(chickwts$weight_deviation[chickwts$weight_deviation < 0])

# Lesson 14: The Mean and the Variance

# some motivation for the concept of variance
sum(chickwts$weight_deviation_median)
mean(chickwts$weight_deviation_median)
mean(abs(chickwts$weight_deviation))
mean(abs(chickwts$weight_deviation_median))

# variance using mean()
mean(chickwts$weight_deviation^2)
mean(chickwts$weight_deviation_median^2)

# standard deviation
sqrt(mean(chickwts$weight_deviation^2))

# the functions var() and sd() are different because they assume sample
var(chickwts$weight_deviation)
?var
var(chickwts$weight_deviation) * (nrow(chickwts)-1)/nrow(chickwts)
var(chickwts$weight)

sd(chickwts$weight) # compare to std dev above

# Lesson 15: Group Means and Variances

mean(chickwts$weight)
var(chickwts$weight)

# custom total sum of squares function
TSS
TSS(chickwts$weight)
TSS(chickwts$weight_deviation)

frequency(chickwts$feed) # creates freq and rel freq table
ggplot(chickwts, aes(x=feed, y=weight)) + geom_boxplot()

# is feed related to weight?
feedgroups <- dplyr::group_by(chickwts, feed)
dplyr::summarize(feedgroups, n(), mean(weight), mean(weight_deviation))
dplyr::summarize(feedgroups, "Mean weight" = mean(weight),  "Mean weight dev " =   mean(weight_deviation ), "Difference" = mean(weight) - mean(weight_deviation))
dplyr::summarize(feedgroups, "Mean weight" = mean(weight),  "Mean weight dev " =   mean(weight_deviation ), "Overall mean" = mean(weight) - mean(weight_deviation))
dplyr::summarize(feedgroups, "Within Group SS"= TSS(weight))
# piping!
library(dplyr)
dplyr::summarize(feedgroups, "Within Group SS" = TSS(weight))  %>% summarize("Total Within Group SS" =sum(`Within Group SS`))
WGSS <- dplyr::summarize(feedgroups, "Within Group SS" = TSS(weight))  %>% summarize("Total Within Group SS" =sum(`Within Group SS`))
# remaining variation in the WGSS:
WGSS / TSS(chickwts$weight)

# doing above calculations but easier
weightlm <- lm(weight ~ feed, chickwts)
summary(weightlm)$r.squared
anova(weightlm)
# note that feed Sum Sq + WGSS = TSS!
231129 + 195556
231129 / TSS(chickwts$weight)

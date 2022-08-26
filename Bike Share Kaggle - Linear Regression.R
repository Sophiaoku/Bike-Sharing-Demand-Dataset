library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)
library(caTools)

bike <- read.csv('bikeshare.csv')

ggplot(bike,aes(temp,count))+ geom_point(alpha=0.2,aes(color=(temp))) + theme_bw()+ 
  theme(legend.position = "bottom")+
  ggtitle("EDA - Count against Temp ")+
  scale_color_continuous(low='blue',high='orange')

#1 Create a Hypothesis

#create a hypothesis independent of the trends presented in the data sets.

#2 Understanding the data set 

#light Feature Engineering 

bike$hour <- (format(as.POSIXlt(bike$datetime), format = "%H"))
bike$month <- (format(as.POSIXlt(bike$datetime), format = "%m"))

#dropped atemp and split datetime colomn to month and hour. 

bike <- data.frame(bike$season, as.numeric(bike$month), as.numeric(bike$hour), bike$workingday , bike$holiday, bike$weather, bike$temp, bike$humidity, bike$windspeed, bike$count)

names(bike) <- c("season", "month", "hour", "workingday", "holiday", "weather", "temperature", "humidity", "windspeed", "count")

#3 Data Exploration 

head(bike)
summary(bike)
str(bike)

#check for any missing data
is.na.data.frame(bike)

par(mfrow=c(4,2))
par(mar = rep(2, 4))
hist(bike$season)
hist(bike$weather)
hist(bike$humidity)
hist(bike$holiday)
hist(bike$workingday)
hist(bike$temp)
hist(bike$windspeed)

#From the histogram, Season,weather, holiday and working day are the only variables that are not normally distributed as per our hypothesis. 


#4 Data Visualization and EDA

#map count against datetime based on temperature as color gradient
ggplot(bike,aes(datetime,count))+ geom_point(alpha=0.2,aes(color=(temp))) + theme_bw()+
  scale_color_continuous(low='blue',high='orange')


#Trends between season and count
ggplot(bike,aes(factor(season),count)) + geom_boxplot(aes(color=factor(season))) +theme_bw()

head(bike)

#count vs hour using temp as color scale for working days
pl <- ggplot(filter(bike,workingday==1),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.5)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()

#count vs hour using temp as color scale for non-working days

pl <- ggplot(filter(bike,workingday==0),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.5)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()

#Correlation matrix

bikecorr <- sapply(bike, is.numeric)
str(bike)
cor.data <- cor(bike[,bikecorr])
cor.data
corrplot(cor.data,method='color')

#Based off my correlation matrix, my independent variables that will be used my model are month, hour, and temperature.
#These variables will be used to predict the count.

#** Missing a plot for independent and dependent variable relationships.


#5 Hypothesis testing 

#Although we know that linear regression will be the best model, I will still apply the lm() function for RMSE comparison sake. 


#Linear regression 
bike.lm <- lm(data = bike, count ~ month + hour + temperature)
summary(bike.lm)
bike.lm.step <- step(bike.lm)
summary(bike.lm.step)

#run you test model
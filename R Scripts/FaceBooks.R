Face = read.csv("C:/Users/Administrator/Desktop/cloud/project/train.csv")
Final = read.csv("C:/Users/Administrator/Desktop/cloud/project/final.csv")
nrow(Face)
ncol(Face)
summary(Face)

install.packages("rattle")
install.packages("rpart.plot")
install.packages("RColorBrewer")
install.packages("sqldf")
install.packages("ggplot2")
install.packages("dplyr")
library(rpart)
library(rattle)
library(rpart.plot)
library("ggplot2")
library(RColorBrewer)
library(sqldf)
library(dplyr)


quantile(Face$place_id)

plot(x ~ y, data=Final)

#create a subset of data - anything greater than 200
subset <- subset(Final, Final$avg_accuracy < 200 & Final$place_id != 0)
 ### Final[ which(Final$avg_accuracy < 200)]

#cut the training data in half - by setting the size to 14000000ish 
mysample <-Face[sample(1:nrow(Face),14559010,replace=FALSE),]

#cut a the data into smaller data. 
Face %>% sample_frac(0.01) -> fb_1pcent
write.csv(fb_1pcent,"1percent.csv")
#to change col names in the new write.csv file
#names(fb_1pcent) <- c("new_name", "another")
count(fb_1pcent)
glimpse(Face)
#Order <- Final[order(avg_time)]

#######################library(dplyr)###################################################
############## Plots ###########################


plot(x_coords ~ y_coords, data=subset)

plot(x_coords ~ avg_accuracy, data=Final)

plot(place_id ~ avg_accuracy, data =subset)

plot(avg_time ~ place_id, data = subset)

plot(time ~ place_id, data=TimeOrder)

boxplot(TimeOrder$place_id ~ TimeOrder$time)

ggplot(data=Final, aes(x = avg_time, y = place_id, group = 1)) +geom_point()

ggplot(data=subset, aes(x = avg_time, y=place_id, group = 1)) + geom_point()

ggplot(data=Final, aes(x = place_id, y = avg_accuracy, group = 1)) + geom_point()

ggplot(data=subset, aes(x = place_id, y = avg_accuracy, group = 1)) + geom_point()

qplot(subset$avg_accuracy, geom = "histogram", binwidth = 0.5)

## density plots - for frequency 

ggplot(Face, aes(x=place_id)) + geom_density()
ggplot(Face,aes(x=time)) + geom_density()
ggplot(Final,aes(x=x_coords)) + geom_density()
ggplot(Face,aes(x=accuracy)) + geom_density()

#################################################
#################################################
#################################################
################################################# 

place_counts = Final["place_id"].value_counts()

Time_hour <- mysample$time %% 60
Time_Day <- (trunc(mysample$time / 60) %% 24)
Time_Days <- (trunc(mysample$time /1440) %% 7)

Face %<% filter(place_id, group_by(place_id))


##### SQL queries ######

countPlace <- sqldf("Select count(place_id)from Face")
avgaccuracy <- sqldf("Select avg(accuracy) from Face")
distinct <- sqldf("Select distinct(place_id from Face")

## how many check in in certain time period?
Time <- sqldf("Select * from mysample where time between 27303 and 77751")
TimeOrder <- sqldf("Select * from Time ORDER BY time ASC")

place_ranking <- sqldf("Select place_id from Final ORDER BY place_id DESC")

#################################################

#### Decsion Trees #####

fit <- rpart(place_id ~ avg_time + avg_accuracy, data = subset, method = 'class')
#fit <- rpart(place_id ~ accuracy + time, data = fb_1pcent, method = 'class')

### PART 2 IN ANALYSIS.R, #### 


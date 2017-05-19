#R <-------------------------------------------------------

setwd("C:/Users/Administrator/Desktop/Scrum/")
train <- read.csv("train.csv", header = TRUE)
test <- read.csv("test.csv", header = TRUE)
View(train)
View(test)

train_part <- sample(2, nrow(train), replace = TRUE, prob = c(0.8, 0.2 ))
train80 <- train[train_part == 1 ,]
train_validation <- train[train_part == 2 ,]​

train_part <- sample(2, nrow(trainAccuracy), replace = TRUE, prob = c(0.8, 0.2 ))
train80 <- trainAccuracy[train_part == 1 ,]
train20 <- trainAccuracy[train_part == 2 ,]​

train20No <- train20



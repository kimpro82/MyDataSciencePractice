# Decision Tree(`rpart`) Practice with *Used Car Prices* in R
# 2022.12.07


# 0. Given codes from Kaggle

# This R environment comes with many helpful analytics packages installed
# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats
# For example, here's a helpful package to load

library(tidyverse) # metapackage of all tidyverse packages

# Input data files are available in the read-only "../input/" directory
# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory

# list.files(path = "../input")

# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using "Save & Run All" 
# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session



# 1. Read Data

setwd("{Working Directory}")

x <- read.csv("./Input/X_train.csv")
y <- read.csv("./Input/y_train.csv")
x_test <- read.csv("./Input/X_test.csv")
y_test <- read.csv("./Input/y_test.csv")


# 1.1 Skim Data

head(x)
str(x)
str(y)
summary(x)
summary(y)

# ※ Made sure there's no missing data.


# 1.2 Divide into Trainning and Valid Data

n <- nrow(x)
idx <- sample(n, n * 0.8)

x["price"] <- y["price"]

x_train <- x[idx,-c(1:3)]                                                       # remove carID, brand, model
x_valid <- x[-idx,-c(1:3)]
x_test <- x_test[,-c(1:3)]

dim(x_train)
dim(x_valid)

head(x_train)



# 2. Fit Model


# 2.1 Fit Model

# 2.1 Fit Model

library(rpart)
model <- rpart(x_train$price ~ ., data = x_train)

model
plot(model, compress = TRUE)
text(model, use.n = TRUE)

# summary(model)                                                                # too much results ……
model$cptable
plotcp(model)

# There's no point that the xerror rises again, but I feel I should do something ……


# 2.2 Improve Model

# I decided cutting cp at 0.025

model2 <- rpart(x_train$price ~ ., data = x_train, cp = 0.025)

plot(model2, compress = TRUE)
text(model2, use.n = TRUE)

model2$cptable
plotcp(model2)


# 2.21 Compare 2 Models

pred1 <- predict(model, newdata = x_test)
pred2 <- predict(model2, newdata = x_test)

summary(pred1); cor(pred1, y_test$price); sqrt(mean((pred1 - y_test$price)^2))
summary(pred2); cor(pred2, y_test$price); sqrt(mean((pred2 - y_test$price)^2))

# Worse performance???


# 2.3 Improve Model 2

model3 <- rpart(x_train$price ~ ., data = x_train, cp = 0.001)

plot(model3, compress = TRUE)
text(model3, use.n = TRUE)

model3$cptable                                                                # skip because it has even 44 lines
plotcp(model3)


# 2.31 Compare 3 Models

pred1 <- predict(model, newdata = x_test)
pred2 <- predict(model2, newdata = x_test)
pred3 <- predict(model3, newdata = x_test)

summary(pred1); cor(pred1, y_test$price); sqrt(mean((pred1 - y_test$price)^2))
summary(pred2); cor(pred2, y_test$price); sqrt(mean((pred2 - y_test$price)^2))
summary(pred3); cor(pred3, y_test$price); sqrt(mean((pred3 - y_test$price)^2))

# Model 3 is not overfitting yet!


windows(width=12, height=13)                                                    # not suitable with kaggle platform
par(mfrow=c(3,3))

plotcp(model)
plotcp(model3)
plotcp(model3)

plot(model, compress = TRUE)
plot(model2, compress = TRUE)
plot(model3, compress = TRUE)

plot(y_test$price, pred1)
abline(0, 1, col = "red")
plot(y_test$price, pred2)
abline(0, 1, col = "red")
plot(y_test$price, pred3)
abline(0, 1, col = "red")


# 3. Note
 
# Hmm …… the result from `rpart` is not a regression formula,  
# but it just outputs some "countable" kinds of values.  
# If I knew it, I wouldn't try cutting cp hastly.
# Random Forest in Titanic
# 2023.12.02
# https://www.kaggle.com/code/kangrokkim/random-forest-in-titanic


# 0. Given codes from Kaggle

# This R environment comes with many helpful analytics packages installed
# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats
# For example, here's a helpful package to load

library(tidyverse) # metapackage of all tidyverse packages

# Input data files are available in the read-only "../input/" directory
# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory

list.files(path = "./Data/titanic")

# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using "Save & Run All" 
# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session


# 1. Read Data

df <- read.csv("./Data/train.csv", stringsAsFactors=TRUE)


# 1.1 Skim Data

head(df)

str(df)

summary(df)

# To remove : Name, Ticket, Cabin
# To replace : Age, Embarked


# 1.2 Pre-processing

# df <- df[, -c("Name", "Ticket", "Cabin")] # Why not work?
df <- subset(df, select = -c(Name, Ticket, Cabin))
summary(df)

Age.mean <- mean(df$Age, na.rm=TRUE)
df$Age <- ifelse(is.na(df$Age), Age.mean, df$Age)
df$Embarked <- replace(df$Embarked, df$Embarked=="", "S")
summary(df)

str(df)

# Label Encoding
df$Sex <- as.numeric(factor(df$Sex), level=levels(df$Sex))
df$Embarked <- as.numeric(factor(df$Embarked), level=levels(df$Embarked))

# Dependent variable should be a factor
df$Survived <- as.factor(df$Survived)

str(df)


# 1.3 Divide into Trainning and Valid Data

n <- nrow(df)
set.seed(20231202)
idx <- sample(n, n * 0.8)

df_train <- df[idx, -1] # remove PassengerId
df_valid <- df[-idx, -1]

dim(df_train)
dim(df_valid)

head(df_train)
str(df_train)


# 2. Model Fitting : Random Forest

library(randomForest)

md <- randomForest(Survived ~ ., data = df_train)
pred <- predict(md, newdata = df_valid, type = "class")


# if not classification

# help(randomForest)
pred.reg <- predict(md, newdata = df_valid, type = "prob")
head(pred.reg)
head(pred.reg[,1])


# 3. Evaluation

# Confusion Matrix
summary(pred)
cm <- table(pred, df[-idx, ]$Survived)
print(cm)

# Accuracy
acc <- (cm[1,1] + cm[2,2]) / nrow(df_valid)
print(acc)

# More elegant way

library(caret)
confusionMatrix(cm)


# It seems to be performing better than the previous HGB I ran …… Crazy  
# https://www.kaggle.com/code/kangrokkim/hgb-histogram-based-gradient-boosting-in-titanic


# 4. Test

test <- read.csv("./Data/test.csv", stringsAsFactors=TRUE)
head(test)
str(test)

test <- subset(test, select = -c(Name, Ticket, Cabin))
test$Age <- ifelse(is.na(test$Age), Age.mean, test$Age)
test$Embarked <- replace(test$Embarked, test$Embarked=="", "S")

# Label Encoding
test$Sex <- as.numeric(factor(test$Sex), level=levels(test$Sex))
test$Embarked <- as.numeric(factor(test$Embarked), level=levels(test$Embarked))

str(test)
summary(test)


# There's a new NA in Fare

Fare.mean <- mean(df$Fare, na.rm=TRUE)
test$Fare <- ifelse(is.na(test$Fare), Fare.mean, test$Fare)

pred2 <- predict(md, newdata = test, type = "class")
summary(pred2)


# 5. Submit

submission.sample <- read.csv("./Submission/gender_submission.csv", stringsAsFactors=TRUE)
nrow(submission.sample)
submission.sample$Survived <- pred2

head(submission.sample)
summary(submission.sample)

# Save a submission file
write.csv(submission.sample, file = "./Submission/Submission_RandomForest.csv", row.names = FALSE)

# No problem?
submission <- read.csv("./Submission/Submission_RandomForest.csv")
head(submission)
str(submission)

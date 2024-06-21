# 빅데이터분석기사(실기) 예시문제 : 작업형 제2유형
# 2nd Trial - Random Forest
# 2024.06.21


# 출력을 원할 경우 print() 함수 활용
# 예시) print(df.head())

# setwd(), getwd() 등 작업 폴더 설정 불필요
# 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

train = read.csv("data/customer_train.csv")
test = read.csv("data/customer_test.csv")

# 사용자 코딩


# 0. Import Libraries

library(randomForest)
library(caret)


# 1. Data Skimming

# str(train[,-11])
# summary(train[,-11])
# str(test)
# summary(test)


# 2. Data Pre-processing

data <- merge(train, test, all=TRUE)                            # all=TRUE : Outer Join
# str(data)
# summary(data)

data$주구매상품 <- as.numeric(data$주구매상품)
data$주구매지점 <- as.numeric(data$주구매지점)
data <- subset(data, select = -환불금액)                        # do not need ''
data$성별 <- as.factor(data$성별)                               # Y should be a factor
# str(data)
# summary(data)

train <- data[1:3500,]
test <- data[3501:5982,-10]
# str(train)
# str(test)

# help(sample)
idx <- sample(0:3500, 3500 * 0.7)                           # 0:3500 should be a sequence
# str(idx)
# summary(idx)

train_x <- train[idx, -10]
train_y <- train[idx, 10]
valid_x <- train[-idx, -10]
valid_y <- train[-idx, 10]
# str(train_x)
# str(train_y)
# str(valid_x)
# str(valid_y)


# 3. Model Fitting

# help(randomForest)
mf <- randomForest(train_x, train_y, mtry=2, ntree=150)
print(mf)


# 4. Validation

# help(predict.randomForest)
pred <- predict(mf, valid_x)                                # not predict.randomForest
# str(pred)
# summary(pred)
cm <- table(pred, valid_y)

print(confusionMatrix(cm))                                  # from caret


# 5. Submission

ans <- predict(mf, test)
ans <- data.frame(pred=ans)
# print(head(ans))
# str(ans)
# summary(ans)

# 답안 제출 참고
# 아래 코드는 예시이며 변수명 등 개인별로 변경하여 활용
write.csv(ans, "result.csv", row.names = FALSE)

# 5.1 답안 확인
result = read.csv("result.csv")
head(result)

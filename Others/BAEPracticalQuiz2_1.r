# 빅데이터분석기사(실기) 예시문제 : 작업형 제2유형
# 2023.06.23



# 출력을 원할 경우 print() 함수 활용
# 예시) print(df.head())

# setwd(), getwd() 등 작업 폴더 설정 불필요
# 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

X_test = read.csv('data/X_test.csv') 
X_train = read.csv('data/X_train.csv') 
y_train = read.csv('data/y_train.csv')

# 사용자 코딩
library(rpart)

# 1. Data Skimming

# print(str(X_train))
# print(str(y_train))
# print(str(X_test))
# print(summary(X_train))
# print(summary(y_train))
# table(y_train[2])

# 2. Data Pre-processing
# print(head(X_train[order(X_train$총구매액, decreasing=T),]))		# don't remove outliers in 최대구매액
# print(head(X_train[is.na(X_train$환불금액),]))									# remove or replace as 0 when 환불금액 == 0?
X_train[is.na(X_train$환불금액),]$환불금액 <- 0									  # replace as 0
# print(summary(X_train))

# print(help(sample))
n <- nrow(X_train)
set.seed(230623)
idx <- sample(n, n * 0.7, replace=F)
X_train_new <- X_train[idx, -c(1, 4)]																	# remove cust_id, 환불금액
y_train_new <- y_train[idx, 2]
X_valid <- X_train[-idx, -1]
y_valid <- y_train[-idx, 2]

print(str(X_train_new))
print(summary(X_train_new))
print(str(y_train_new))

# 3. Model Fitting
# print(summary(train_new[, 1]))													# idx doesn't start from 0!
model <- rpart(y_train_new ~ ., data = X_train_new, method = "class", cp = 0.025)
# summary(model)
printcp(model)

# 4. Validation
pred <- predict(model, newdata = X_valid, method = "class")
pred_new <- pred[, 2]
# print(summary(pred))
# print(summary(pred_new))
pred_new[pred_new>=0.5] <- 1
pred_new[pred_new<0.5] <- 0
print(summary(pred_new))
print(summary(y_valid))

print(cor(pred[, 2], y_valid))															# 0.2347942
print(cor(pred_new, y_valid))																# 0.2313989
print(table(pred_new, y_valid))
# pred_new   0   1
#        0 463 176
#        1 204 207
# Not good

# 5. Submission
# 답안 제출 참고
# 아래 코드 변수명과 수험번호를 개인별로 변경하여 활용
# write.csv(변수명,'003000000.csv',row.names=F) 
pred2 <- predict(model, newdata = X_test, method = "class")
ans <- data.frame(X_test[, 1], pred2[, 2])
colnames(ans) <- c("custid", "gender")
print(head(ans))
# print(summary(ans))
write.csv(ans,'data/003000000.csv',row.names=F)
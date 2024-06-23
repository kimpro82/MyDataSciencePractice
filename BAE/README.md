## [빅데이터분석기사 (실기)](../README.md#빅데이터분석기사-실기)

https://www.dataq.or.kr/www/sub/a_07.do


### \<List>

- 예시문제
  - [작업형 제1유형 (2023.06.23)](#작업형-제1유형-20230623)
  - [작업형 제2유형](#작업형-제2유형)
    - [Trial 1 : Decision Tree (2023.06.23)](#trial-1--decision-tree-20230623)
    - [Trial 2 : Random Forest (2024.06.21)](#trial-2--random-forest-20240621)
  - [작업형 제3유형 (신유형, 2023.04.25)](#작업형-제3유형-신유형-20230425)
- 기출문제
  - [제5회 : 필답형 9번 (2022.12.03)](#제5회--필답형-9번-20221203)



## [작업형 제1유형 (2023.06.23)](#list)

- 예시문제 ☞ https://dataq.goorm.io/exam/116674/체험하기/quiz/1
- Code and Output
  <details>
    <summary>Code : BAEPracticalQuiz1.r</summary>

  ```r
  # 출력을 원할 경우 print() 함수 활용
  # 예시) print(df.head())

  # setwd(), getwd() 등 작업 폴더 설정 불필요
  # 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

  # 데이터 파일 읽기 예제
  a <- read.csv("data/mtcars.csv", header=TRUE)
  ```
  ```r
  # 사용자 코딩

  # print(head(a))                                            # need to wrap with print()
  # str(a)
  # summary(a)

  qsec <- a$qsec
  print(summary(qsec))

  qsec_cvt <- (qsec - min(qsec)) / (max(qsec) - min(qsec))
  print(summary(qsec_cvt))

  qsec_over_median <-qsec_cvt[qsec_cvt>0.5]
  print(qsec_over_median)
  ans = length(qsec_over_median)
  ```
  ```r
  # 답안 제출 예시
  # print(변수명)

  print(ans)
  ```
  </details>
  <details open="">
    <summary>Output</summary>

  ```txt
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
  14.50   16.89   17.71   17.85   18.90   22.90
  ```
  ```txt
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
  0.0000  0.2848  0.3821  0.3987  0.5238  1.0000
  ```
  ```txt
  [1] 0.5880952 0.6809524 0.6547619 1.0000000 0.5238095 0.5916667 0.6428571
  [8] 0.6559524 0.5238095
  ```
  ```txt
  [1] 9
  ```
  </details>


## [작업형 제2유형](#list)

- 예시문제 ☞ https://dataq.goorm.io/exam/116674/체험하기/quiz/2

### [Trial 1 : Decision Tree (2023.06.23)](#작업형-제2유형)

- Code and Output
  <details>
    <summary>Code : BAEPracticalQuiz2.r</summary>

  ```r
  # 출력을 원할 경우 print() 함수 활용
  # 예시) print(df.head())

  # setwd(), getwd() 등 작업 폴더 설정 불필요
  # 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

  X_test = read.csv('data/X_test.csv') 
  X_train = read.csv('data/X_train.csv') 
  y_train = read.csv('data/y_train.csv')
  ```
  ```r
  # 사용자 코딩
  library(rpart)
  library(caret)
  ```
  ```r
  # 1. Data Skimming

  # print(str(X_train))
  # print(str(y_train))
  # print(str(X_test))
  # print(summary(X_train))
  # print(summary(y_train))
  # table(y_train[2])
  ```
  ```r
  # 2. Data Pre-processing

  # print(head(X_train[order(X_train$총구매액, decreasing=T),]))                      # don't remove outliers in 최대구매액
  # print(head(X_train[is.na(X_train$환불금액),]))                                    # remove or replace as 0 when 환불금액 == 0?
  X_train[is.na(X_train$환불금액),]$환불금액 <- 0                                         # replace as 0
  # print(summary(X_train))

  # print(help(sample))
  n <- nrow(X_train)
  set.seed(230623)
  idx <- sample(n, n * 0.7, replace=F)

  X_train_new <- X_train[idx, -1]                                                 # remove cust_id
  y_train_new <- y_train[idx, 2]
  X_valid <- X_train[-idx, -1]
  y_valid <- y_train[-idx, 2]

  # print(str(X_train_new))
  # print(summary(X_train_new))
  # print(str(y_train_new))
  ```
  ```r
  # 3. Model Fitting

  # print(summary(train_new[, 1]))                                                # idx doesn't start from 0!
  model <- rpart(y_train_new ~ ., data = X_train_new, method = "class", cp = 0.023)
  printcp(model)
  ```
  ```r
  # 4. Validation

  pred <- predict(model, newdata = X_valid, method = "class")
  pred_new <- pred[, 2]
  # print(summary(pred))
  # print(summary(pred_new))
  pred_new[pred_new>=0.5] <- 1
  pred_new[pred_new<0.5] <- 0
  print(summary(pred_new))
  print(summary(y_valid))

  print(cor(pred[, 2], y_valid))                                                  # 0.2347942
  print(cor(pred_new, y_valid))                                                   # 0.2313989
  # print(table(pred_new, y_valid))
  # pred_new   0   1
  #        0 463 176
  #        1 204 207
  # Seems not good
  print(confusionMatrix(table(pred_new, y_valid)))
  #            Accuracy : 0.6381
  #              95% CI : (0.6082, 0.6672)
  # No Information Rate : 0.6352
  # P-Value [Acc > NIR] : 0.4374
  ```
  ```r
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
  ```
  </details>
  <details open="">
    <summary>Output</summary>

  ```txt
  Classification tree:
  rpart(formula = y_train_new ~ ., data = X_train_new, method = "class",
      cp = 0.023)

  Variables actually used in tree construction:
  [1] 내점일수   주구매상품

  Root node error: 933/2450 = 0.38082

  n= 2450

          CP nsplit rel error  xerror     xstd
  1 0.057342      0   1.00000 1.00000 0.025761
  2 0.023000      2   0.88532 0.94212 0.025446
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
  0.0000  0.0000  0.0000  0.3914  1.0000  1.0000
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
  0.0000  0.0000  0.0000  0.3648  1.0000  1.0000
  ```
  ```txt
  [1] 0.2347942
  [1] 0.2313989
  ```
  It seems not good
  ```txt
  Confusion Matrix and Statistics

          y_valid
  pred_new   0   1
         0 463 176
         1 204 207

                Accuracy : 0.6381
                  95% CI : (0.6082, 0.6672)
     No Information Rate : 0.6352
     P-Value [Acc > NIR] : 0.4374

                   Kappa : 0.231

  Mcnemar's Test P-Value : 0.1660

             Sensitivity : 0.6942
             Specificity : 0.5405
          Pos Pred Value : 0.7246
          Neg Pred Value : 0.5036
              Prevalence : 0.6352
          Detection Rate : 0.4410
    Detection Prevalence : 0.6086
       Balanced Accuracy : 0.6173

        'Positive' Class : 0
  ```
  Not quite there yet, but better.
  ```txt
    custid    gender
  1   3500 0.3144928
  2   3501 0.2298137
  3   3502 0.3144928
  4   3503 0.5560209
  ```
  Anyway, it meets the submission format.
  </details>

### [Trial 2 : Random Forest (2024.06.21)](#작업형-제2유형)

- Code and Output
  <details>
    <summary>Code : BAEPracticalQuiz2_2.r</summary>

  ```r
  # 출력을 원할 경우 print() 함수 활용
  # 예시) print(df.head())

  # setwd(), getwd() 등 작업 폴더 설정 불필요
  # 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

  train = read.csv("data/customer_train.csv")                 # no file in the local environment
  test = read.csv("data/customer_test.csv")
  ```
  ```r
  # 0. Import Libraries

  library(randomForest)
  library(caret)
  ```
  ```r
  # 1. Data Skimming

  str(train[,-11])
  # summary(train[,-11])
  str(test)
  # summary(test)
  ```
  ```r
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
  ```
  ```r
  # 3. Model Fitting

  # help(randomForest)
  mf <- randomForest(train_x, train_y, mtry=2, ntree=150)
  print(mf)
  ```
  ```r
  # 4. Validation

  # help(predict.randomForest)
  pred <- predict(mf, valid_x)                                # not predict.randomForest
  # str(pred)
  # summary(pred)
  cm <- table(pred, valid_y)

  print(confusionMatrix(cm))                                  # from caret
  ```
  ```r
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
  ```
  </details>
  <details open="">
    <summary>Output</summary>

  ```txt
  Call:
  randomForest(x = train_x, y = train_y, ntree = 150, mtry = 2) 
                 Type of random forest: classification
                       Number of trees: 150
  No. of variables tried at each split: 2

          OOB estimate of  error rate: 38.38%
  Confusion matrix:
       0   1 class.error
  0 1241 310   0.1998711
  1  630 268   0.7015590
  ```
  ```txt
      valid_y
  pred   0   1
     0 528 294
     1 105 124
                                            
                Accuracy : 0.6204          
                  95% CI : (0.5902, 0.6498)
     No Information Rate : 0.6023          
     P-Value [Acc > NIR] : 0.1217          
                                            
                   Kappa : 0.1417          
                                            
  Mcnemar's Test P-Value : <2e-16          
                                            
             Sensitivity : 0.8341          
             Specificity : 0.2967          
          Pos Pred Value : 0.6423          
          Neg Pred Value : 0.5415          
              Prevalence : 0.6023          
          Detection Rate : 0.5024          
    Detection Prevalence : 0.7821          
       Balanced Accuracy : 0.5654          
                                            
        'Positive' Class : 0 
  ```
  It seems (still) not good
  ```txt
    pred
  1    1
  2    0
  3    0
  4    0
  5    1
  6    1
  ```
  </details>


## [작업형 제3유형 (신유형, 2023.04.25)](#list)

- 예시문제 ☞ https://dataq.goorm.io/exam/116674/체험하기/quiz/3
- Code and Output
  <details>
    <summary>Code : BAEPracticalQuiz3.r</summary>

  ```r
  # 출력을 원할 경우 print() 함수 활용
  # 예시) print(df.head())

  # setwd(), getwd() 등 작업 폴더 설정 불필요
  # 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

  # 데이터 파일 읽기 예제
  a <- read.csv("data/blood_pressure.csv", header=TRUE)
  ```
  ```r
  # 사용자 코딩
  # str(a)
  # summary(a)

  attach(a)

  # (a)
  sample_mean = mean(bp_after - bp_before)
  ans_a = round(sample_mean, 2)

  # (b)
  result = t.test(bp_after - bp_before, mu = 0, var.equal = TRUE)
  # print(result)
  ans_b = round(as.numeric(result[1]), 2)

  # (c)
  ans_c1 = round(as.numeric(result[3]), 4)
  if (ans_c1 < 0.05) {
    ans_c2 = "기각"
  } else {
    ans_c2 = "채택"
  }
  ```
  ```r
  # 답안 제출 예시
  # print(변수명)
  print(ans_a)                                                # -5.09
  print(ans_b)                                                # t-statistic = -3.34
  print(ans_c1)                                               # p-value = 0.0011 < 0.05
  print(ans_c2)                                               # 기각

  detach(a)
  ```
  </details>
  <details open="">
    <summary>Output</summary>

  ```
  [1] -5.09
  [1] -3.34
  [1] 0.0011
  [1] "기각"
  ```
  </details>


## [제5회 : 필답형 9번 (2022.12.03)](#list)

- 가답안 전체 공유 ☞ [5회 실기(2022.12.03) 필답형 가답안 공유 (Kaggle Discussion)](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155)
- 문제 : 표준정규분포의 (-a, a) 구간은 99.7%? (☞ [Kaggle Discussion Comment](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155#2055310))
- Code and Output
  <details open="">
    <summary>Code : BAE5Q9.r</summary>

  ```r
  pnorm(2.75, 0, 1)                       # 0.9970202
  pnorm(-2.75, 0, 1)                      # 0.002979763
  pnorm(3, 0, 1)                          # 0.9986501
  pnorm(-3, 0, 1)                         # 0.001349898

  pnorm(2.75, 0, 1) - pnorm(-2.75, 0, 1)  # 0.9940405
  pnorm(3, 0, 1) - pnorm(-3, 0, 1)        # 0.9973002
  ```
  </details>
  <details open="">
    <summary>Output</summary>

  - 정답 : 3 (:sob::sob::sob:)
  </details>
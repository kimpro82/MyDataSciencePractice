# Data Splitting Practice in R
# 2023.08.05


# caret 패키지 로드
library(caret)


# 0. sample data 호출(oil)
data(oil)
ls()                                                        # "fattyAcids" "oilType"
str(fattyAcids)


# 1. createDataPartition 함수 사용

createDataPartition(oilType, 2)                             # oilType 변수를 기반으로 데이터 분할


# 2. createFolds 함수 사용

createFolds(oilType, 3)                                     # oilType 변수를 기반으로 3개의 fold 생성
createFolds(oilType, 3, list = FALSE)
createFolds(oilType, 3, returnTrain = TRUE)


# 3. createTimeSlices 함수 사용

createTimeSlices(1:9, 5, 3, fixedWindow = TRUE)             # 1부터 9까지의 값으로 5개의 시계열 분할 생성
createTimeSlices(1:9, 5, 3, fixedWindow = FALSE)
createTimeSlices(1:9, 5, 3)                                 # fixedWindow : FALSE (기본값)

createTimeSlices(1:15, 5, 3, skip = 2)                      # 1부터 15까지의 값으로 5개의 시계열 분할 생성하며, 2번째 값을 스킵
createTimeSlices(1:15, 5, 3, skip = 3)

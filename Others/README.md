## [Others](../README.md#others)

### \<List>

  - [빅데이터분석기사(실기) / 신유형 연습 : 작업형 제3유형 예시문제 (2023.04.25)](#빅데이터분석기사실기--신유형-연습--작업형-제3유형-예시문제-20230425)
  - [빅데이터분석기사(실기) / 제5회 : 필답형 9번 (2022.12.03)](#빅데이터분석기사실기--제5회--필답형-9번-20221203)


## [빅데이터분석기사(실기) / 신유형 연습 : 작업형 제3유형 예시문제 (2023.04.25)](#list)

- 예시문제 ☞ https://dataq.goorm.io/exam/116674/체험하기/quiz/3

  #### `BAEPracticalQuiz3.r`
  ```r
  # 출력을 원할 경우 print() 함수 활용
  # 예시) print(df.head())

  # setwd(), getwd() 등 작업 폴더 설정 불필요
  # 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

  # 데이터 파일 읽기 예제
  a <- read.csv("Data/blood_pressure.csv", header=TRUE)

  # 사용자 코딩
  # str(a)
  # summary(a)

  attach(a)

  # (a)
  sample_mean = mean(bp_after - bp_before)

  # (b), (c)
  ttest = t.test(bp_after - bp_before, mu = 0, var.equal=TRUE)
  # print(ttest)

  # 답안 제출 예시
  # print(변수명)
  print(round(sample_mean, 2))                                # t-statistic = -5.09
  print(round(as.numeric(ttest[1]), 2))                       # t-statistic = -5.09
  print(round(as.numeric(ttest[3]), 4))                       # p-value = 0.0011 < 0.05
  print("채택")

  detach(a)
  ```
  ```
  [1] -5.09
  [1] -3.34
  [1] 0.0011
  [1] "채택"
  ```


## [빅데이터분석기사(실기) / 제5회 : 필답형 9번 (2022.12.03)](#list)

- 가답안 전체 공유 ☞ [5회 실기(2022.12.03) 필답형 가답안 공유 (Kaggle Discussion)](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155)

- 문제 : 표준정규분포의 (-a, a) 구간은 99.7%? (☞ [Kaggle Discussion Comment](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155#2055310))

  #### `BAE5Q9.r`
  ```r
  pnorm(2.75, 0, 1)                       # 0.9970202
  pnorm(-2.75, 0, 1)                      # 0.002979763
  pnorm(3, 0, 1)                          # 0.9986501
  pnorm(-3, 0, 1)                         # 0.001349898

  pnorm(2.75, 0, 1) - pnorm(-2.75, 0, 1)  # 0.9940405
  pnorm(3, 0, 1) - pnorm(-3, 0, 1)        # 0.9973002
  ```

- 정답 : 3 (:sob::sob::sob:)
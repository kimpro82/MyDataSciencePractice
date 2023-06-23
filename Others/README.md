## [Others](../README.md#others)

### \<List>

  - [빅데이터분석기사(실기) / 예시문제 : 작업형 제1유형 (2023.06.23)](#빅데이터분석기사실기--예시문제--작업형-제1유형-20230623)
  - [빅데이터분석기사(실기) / 예시문제 : 작업형 제3유형 (신유형, 2023.04.25)](#빅데이터분석기사실기--예시문제--작업형-제3유형-신유형-20230425)
  - [빅데이터분석기사(실기) / 제5회 : 필답형 9번 (2022.12.03)](#빅데이터분석기사실기--제5회--필답형-9번-20221203)



## [빅데이터분석기사(실기) / 예시문제 : 작업형 제1유형 (2023.06.23)](#list)

- 예시문제 ☞ https://dataq.goorm.io/exam/116674/체험하기/quiz/1

  <details>
    <summary>Codes : BAEPracticalQuiz1.r</summary>

  ```r
  # 출력을 원할 경우 print() 함수 활용
  # 예시) print(df.head())

  # setwd(), getwd() 등 작업 폴더 설정 불필요
  # 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

  # 데이터 파일 읽기 예제
  a <- read.csv("data/mtcars.csv", header=TRUE)


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


## [빅데이터분석기사(실기) / 예시문제 : 작업형 제3유형 (신유형, 2023.04.25)](#list)

- 예시문제 ☞ https://dataq.goorm.io/exam/116674/체험하기/quiz/3

  <details>
    <summary>Codes : BAEPracticalQuiz3.r</summary>

  ```r
  # 출력을 원할 경우 print() 함수 활용
  # 예시) print(df.head())

  # setwd(), getwd() 등 작업 폴더 설정 불필요
  # 파일 경로 상 내부 드라이브 경로(C: 등) 접근 불가

  # 데이터 파일 읽기 예제
  a <- read.csv("data/blood_pressure.csv", header=TRUE)

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
    ans_c2 = "채택"
  } else {
    ans_c2 = "기각"
  }

  # 답안 제출 예시
  # print(변수명)
  print(ans_a)                                                # -5.09
  print(ans_b)                                                # t-statistic = -3.34
  print(ans_c1)                                               # p-value = 0.0011 < 0.05
  print(ans_c2)                                               # 채택

  detach(a)
  ```
  </details>
  <details open="">
    <summary>Output</summary>

  ```
  [1] -5.09
  [1] -3.34
  [1] 0.0011
  [1] "채택"
  ```
  </details>


## [빅데이터분석기사(실기) / 제5회 : 필답형 9번 (2022.12.03)](#list)

- 가답안 전체 공유 ☞ [5회 실기(2022.12.03) 필답형 가답안 공유 (Kaggle Discussion)](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155)

- 문제 : 표준정규분포의 (-a, a) 구간은 99.7%? (☞ [Kaggle Discussion Comment](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155#2055310))

  <details open="">
    <summary>Codes : BAE5Q9.r</summary>

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
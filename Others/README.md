## [Others](../README.md#others)

### \<List>

- [제5회 빅데이터분석기사 실기 (2022.12.03) / 필답형 9번](#제5회-빅데이터분석기사-실기-20221203--필답형-9번)


## [제5회 빅데이터분석기사 실기 (2022.12.03) / 필답형 9번](#list)

- 가답안 전체 공유 ☞ [5회 실기(2022.12.03) 필답형 가답안 공유 (Kaggle Discussion)](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155)

- 문제 : 정규분포의 (-a, a) 구간은 99.7%? (☞ [Kaggle Discussion Comment](https://www.kaggle.com/datasets/agileteam/bigdatacertificationkr/discussion/370155#2055310))

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
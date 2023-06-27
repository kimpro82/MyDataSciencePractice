# 제5회 빅데이터분석기사 실기 (2022.12.3) / 필답형 9번


# 문제 : 표준정규분포의 (-a, a) 구간은 99.7%?

pnorm(2.75, 0, 1)                       # 0.9970202
pnorm(-2.75, 0, 1)                      # 0.002979763
pnorm(3, 0, 1)                          # 0.9986501
pnorm(-3, 0, 1)                         # 0.001349898

pnorm(2.75, 0, 1) - pnorm(-2.75, 0, 1)  # 0.9940405
pnorm(3, 0, 1) - pnorm(-3, 0, 1)        # 0.9973002

# 정답 : 3
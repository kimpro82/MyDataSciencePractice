# 빅데이터분석기사(실기) 신유형 : 작업형 제3유형 예시문제 연습
# 2023.04.25


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
	ans_c2 = "기각"
} else {
	ans_c2 = "채택"
}

# 답안 제출 예시
# print(변수명)
print(ans_a)                                                # -5.09
print(ans_b)                                                # t-statistic = -3.34
print(ans_c1)                                               # p-value = 0.0011 < 0.05
print(ans_c2)                                               # 기각

detach(a)

# 빅데이터분석기사(실기) 예시문제 : 작업형 제1유형
# 2023.06.23


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
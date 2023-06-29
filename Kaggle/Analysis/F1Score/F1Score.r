# Trends of F1 Score with Changes in Precision and Recall
# by ChatGPT, 2023.06.25

# Some plots are not shown on the Kaggle notebook, but the codes actually work.


# 필요한 라이브러리를 로드합니다
library(plotly)
library(ggplot2)

# 데이터를 생성합니다
precision <- seq(0, 1, length.out = 100)
recall <- seq(0, 1, length.out = 100)
f1_score <- outer(precision, recall, FUN = function(p, r) { 2 * (p * r) / (p + r + 1e-10) })

str(f1_score)
head(f1_score)

# 등고선 그래프를 그립니다
plot_ly(x = precision, y = recall, z = f1_score, type = "contour") %>%
  layout(scene = list(
    xaxis = list(title = "정밀도"),
    yaxis = list(title = "재현율"),
    zaxis = list(title = "F1 Score")
  )) %>%
  layout(width = 500, height = 400, scene = list(aspectmode = "manual"))

# 3차원 등고선 그래프를 그립니다
fig <- plot_ly(x = precision, y = recall, z = f1_score, type = "surface")
fig <- fig %>% layout(
  scene = list(
    xaxis = list(title = "정밀도"),
    yaxis = list(title = "재현율"),
    zaxis = list(title = "F1 Score"),
    camera = list(
      eye = list(x = -1.5, y = -1.5, z = 0.8),
      center = list(x = 0, y = 0, z = 0),
      up = list(x = 0, y = 0, z = 1)
    )
  ),
  width = 650,
  height = 500
)
fig

# F1 Score 값을 벡터로 변환하고 오름차순으로 정렬합니다
f1_vector <- sort(as.vector(f1_score))

# F1 Score의 누적분포 함수 (CDF)를 계산합니다
cdf <- ecdf(f1_vector)

# CDF 그래프를 그립니다
x_values <- seq(0, 1, length.out = 500)
y_values <- cdf(x_values)
data <- data.frame(x = x_values, y = y_values)
plot <- ggplot(data, aes(x, y)) +
  geom_step() +
  labs(x = "F1 Score", y = "CDF") +
  ggtitle("F1 Score의 누적분포 함수 (CDF)")

# 보조선을 추가합니다
plot <- plot +
  scale_x_continuous(breaks = seq(0, 1, by = 0.1)) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.1))

plot

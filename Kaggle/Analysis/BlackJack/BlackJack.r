# Black Jack Simulation



# 0. Generate a Deck

# 2022.08.06


# 0.1 Make as a vector

suits <- c("S", "H", "D", "C")
num <- c(1:10, 10, 10, 10)

cards <- c()
for (s in suits) {
    for (n in num) {
        cards <- c(cards, paste(s, n, sep=""))
    }
}

cards
cards[11]                                                   # S10
substr(cards[11], 2, 3)                                     #  10
substr(cards[9], 2, 3)                                      #   9


# 0.2 Make as 2-dim dataframe

suits <- c("S", "H", "D", "C")
num <- c("A", 2:10, "J", "Q", "K")
points <- c(1:10, 10, 10, 10)

cards <- c()
for (s in suits) {
    for (n in num) {
        cards <- c(cards, paste(s, n, sep = ""))
    }
}

cards2d <- data.frame(cards, points)


# 0.3 Export to .csv

write.csv(cards2d, "Cards.csv", row.names = FALSE)



# 1. Set Initial Cards

# 2022.08.16


# 1.1 Trial 1 : Generate the entire initial cases

# loading gtools library
if (!requireNamespace("gtools")) {
  install.packages('gtools')
}
library(gtools)                                             # for using permutations() and combinations()

cards <- read.csv("Cards.csv")
nrow(cards)                                                 # 52

init <- permutations(52, 4, v = cards[,1], repeats.allowed = FALSE)
head(init)
nrow(init)                                                  # 6,497,400 cases, 198.3 Mb
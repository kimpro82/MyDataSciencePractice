## My Black Jack Project

![21](Images/21.jpg)

The movie <21>(2008) has accidentally nspired me to dream the king of *Las Vegas*.


## \<List>

- [1. Set Initial Cards](#)
    - [1.1 Trial 1 - Generate the Entire Initial Cases (2022.08.16)](#11-generate-the-entire-initial-cases-20220816)
- [0. Generate Cards' Data (2022.08.06)](#0-generate-cards-data-20220806)


## [1. Set Initial Cards](#list)

### [1.1 Trial 1 - Generate the Entire Initial Cases (2022.08.16)](#list)

- I tried generating the initial cases that each of the player and dealer has 2 cards respectively.
- But the number of cases are over 6 million …… and the data size is about 200 Mb. It may seem not so large, but I was going to adopt some additional data structure to calculate the probability table for each case, so I think it is needed to find more efficient data structure & algorithm …… For example, a *Monte Carlo simulation* with *recursive search*?

#### `BlackJack.r`

```r
……

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
```
> [1] 52

> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[,1]  [,2] [,3] [,4]  
> [1,] "C10" "C2" "C3" "C4"  
> [2,] "C10" "C2" "C3" "C5"  
> [3,] "C10" "C2" "C3" "C6"  
> [4,] "C10" "C2" "C3" "C7"  
> [5,] "C10" "C2" "C3" "C8"  
> [6,] "C10" "C2" "C3" "C9"  

> [1] 6497400


## [0. Generate Cards' Data (2022.08.06)](#list)

- Why I chose **R** for doing it? Because …… I love `a:b` syntax for generating continuous integers.
- After made `Cards.csv`, maybe it will be better to use **Python** for operating **GAN** and so on.

#### `BlackJack.r`

```r
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
```
> [1] "S1"  "S2"  "S3"  "S4"  "S5"  "S6"  "S7"  "S8"  "S9"  "S10" "S10"  
> [12] "S10" "S10" "H1"  "H2"  "H3"  "H4"  "H5"  "H6"  "H7"  "H8"  "H9"  
> ……  
> [45] "C6"  "C7"  "C8"  "C9"  "C10" "C10" "C10" "C10"

> [1] "S10"  
> [1] "10"  
> [1] "9"

```r
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
```

```r
# 0.3 Export to .csv

write.csv(cards2d, "Cards.csv", row.names = FALSE)
```

#### `Cards.csv`
> "cards","points"  
> "SA",1  
> "S2",2  
> "S3",3  
> ……
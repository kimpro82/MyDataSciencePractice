## My Black Jack Project

![21](Images/21.jpg)

The movie <21> has accidentally nspired me to dream the king of *Las Vegas*.


## \<List>

- [0. Generate Cards' Data (2022.08.06)](#0-generate-cards-data-20220806)


## [0. Generate Cards' Data (2022.08.06)](#list)

- Why I choose **R** for doing it? Because …… I love `a:b` syntax for generating continuous integers.
- After made `Cards.csv`, maybe it will be better to use **Python** for operating `GAN` and so on.

#### `BlackJack_GenCards.r`

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
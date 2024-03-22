# Factorial

factorial(4)    # 4! = 4 * 3 * 2 * 1


# Permutation

# loading gtools library
if (!requireNamespace("gtools")) {
    install.packages('gtools')
}
library(gtools)                             # for using permutations() and combinations()

# ?permutations
# permutations(n, r, v=1:n, set=TRUE, repeats.allowed=FALSE)
# n                 Size of the source vector
# r                 Size of the target vectors
# v                 Source vector. Defaults to 1:n
# set               Logical flag indicating whether duplicates should be removed from the source vector v. Defaults to TRUE.
# repeats.allowed   Logical flag indicating whether the constructed vectors may include duplicated values. Defaults to FALSE.

balls <- c("Red", "Yellow", "Blue")

permutations(3, 2, v = balls, repeats.allowed = TRUE)  # 3Π2
permutations(3, 2, v = balls, repeats.allowed = FALSE) # 3P2
permutations(3, 2, v = balls)


# Combination

combn(balls, 2)

combinations(3, 2, v = balls, repeats.allowed = TRUE)  # 3H2
combinations(3, 2, v = balls, repeats.allowed = FALSE) # 3C2


# Number of cases (faster)

prod(4, 2)                                  # 4P2
choose(4, 2)                                # 4C2
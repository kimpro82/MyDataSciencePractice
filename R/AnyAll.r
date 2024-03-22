# any() & all() Practice
# 2024.02.19

# This script is a practice session for understanding 
#   the usage of `any()` and `all()` functions in R.


# 0. Declare a vector
vec <- c(1:10)

# 1. Understanding the error
# - code          : length(nums) == 6 && !(luckyNum %in% nums)
# - error message : 'length = 6' in coercion to 'logical(1)'
length(vec)                             # Output the length of the vector
length(vec) == 10                       # Check if the length is equal to 10
3 %in% vec                              # Check if 3 is present in the vector
!(3 %in% vec)                           # Check if 3 is not present in the vector
length(vec) == 10 && !(3 %in% vec)      # Combine length check and presence check
# Explanation:
#   The error occurred because `luckyNum` was a vector, not a scalar value.

cat('\n')

# 2. any() & all()
vec > 5                                 # Check which elements are greater than 5
any(vec > 5)                            # Check if any element is greater than 5
all(vec > 5)                            # Check if all elements are greater than 5

cat('\n')

# 3. duplicated() with any() & all()
vec2 <- c(vec, 9:12)
duplicated(vec2)                        # Check for duplicated elements in the vector
any(duplicated(vec2))                   # Check if any element is duplicated
all(duplicated(vec2))                   # Check if all elements are duplicated

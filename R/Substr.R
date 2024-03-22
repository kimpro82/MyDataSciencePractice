# R : Slicing String with substr()
# 2023.06.26

str <- "R도 명색이 프로그래밍 언어인데, 문자열 슬라이싱이 안 될 리가 없잖아. 근데 왜 안 돼? 왜 나 괴롭혀?"


# Trial 1 : Do like other general languages

str[1:3]
# The entire string is considered as the 1st element of a vector.
# The 2nd and 3rd elements of the vector are regarded as empty.


# Trial 2 : Use substr()

substr(str, 1, 19)
substr(str, 20, 41)
substr(str, 42, 100)


# Trial 2-1 : For loop with substr()

for (i in 1:nchar(str)) {                                                       # not length()
    cat(substr(str, i, i), seq = " ")
}


# Trial 3 : Use strsplit()

strsplit1 <- strsplit(str, split = "[,] |[.] ", fixed = FALSE)
strsplit2 <- strsplit(str, split = "[,.] ", fixed = FALSE)
strsplit1
strsplit2

strsplit2[1]
strsplit2[[1]]
strsplit2[[1]][1]

cat(strsplit2[[1]])
cat(strsplit2[[1]][1])

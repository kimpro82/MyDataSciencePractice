# A practice for List data structure in R
# 2022.11.22

# It's not the linked list, but the data strurture that consists of key & value!


# 0. Set a sample data

Chuhan <- list(
    "ruler" = "Liu Bei",
    "general" = c("Guan Yu", "Zhang Fei"),
    "advisor" = "Zhuge Liang"
)
Chuhan

# 1. Read by key

Chuhan["ruler"]
Chuhan[1]                                       # the same with Chuhan["ruler"]
Chuhan[[1]]

Chuhan[2]
Chuhan[2][1]
Chuhan[[2]][1]

print(Chuhan[[2]][1])
cat(Chuhan[[2]][1])


# 2. Read by value

match("Zhuge Liang", Chuhan)                    # get the index of the value
Chuhan[match("Zhuge Liang", Chuhan)]            # the key & value from the index
names(Chuhan[match("Zhuge Liang", Chuhan)])     # read only the key
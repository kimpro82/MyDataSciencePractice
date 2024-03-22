# generating array and variables by for loop


# 1. generating array by for loop
mylist = c()

for (i in 1:10) {
  mylist[i] = i
}

mylist


# 1.1 generating array more efficiently
mylist2 = c(1:10)

mylist2


# 2. generating variable names
for (i in 1:10) { 
  name <- paste("mylist_", i, sep = "")
  assign(name, c())
}

ls()


# 2.1 generating variable names with considering sort
for (i in 1:10) { 
  if (i < 10) {
    name <- paste("mylist_0", i, sep = "")
  } else {
    name <- paste("mylist_", i, sep = "")
  }
  assign(name, c())
}

ls()


# 2.1.1 code improvement trial of 2.1

name_head_original = "mylist_"

for (i in 1:10) { 
  if (i < 10) {
    name_head = paste(name_head_original, "0", sep = "")
  } else {
    name_head = name_head_original
  }
  name <- paste(name_head, i, sep = "")
  assign(name, c())
}

ls()
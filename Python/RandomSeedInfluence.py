# make sure the range og random.seed()'s influence

import random

# case 1
print(random.random())
print(random.random())
print(random.random())

# case 2
random.seed(105)
print(random.random())
print(random.random())
print(random.random())

# case 2-1
random.seed(105); print(random.random())
random.seed(105); print(random.random())
random.seed(105); print(random.random())

# case 3
random.seed(105)
for i in range(0,3) :
    print(random.random())

# case 3-1
for i in range(0,3) :
    random.seed(105); print(random.random())
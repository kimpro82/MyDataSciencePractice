# algorithm to find n's square root

import random
import math
import matplotlib.pyplot as plt

n = 2 # should be larger than 1
k = 20 # run loop k times

squareroot = []
lowerlimit, upperlimit = 1, n

for i in range(k) :

    random.seed(20200104) # can be removed
    squareroot.append(random.uniform(lowerlimit, upperlimit))
    square = squareroot[i] ** 2
    print(i+1, squareroot[i], square, square-n)

    if square == n :
        break;
    elif square < n :
        # print("smaller")
        lowerlimit = max(squareroot[i], lowerlimit)
    else :
        # print("larger")
        upperlimit = min(squareroot[i], upperlimit)

myplot = plt.plot(range(k), squareroot)
# myplot.hlines(math.sqrt(n), color="red", linestyle="--") # doesn't work


# practice
random.random()
random.randrange(1,n) # output only integer
random.uniform(1,n) # output float
list(range(10))
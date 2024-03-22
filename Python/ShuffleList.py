import random


# Trial 1 : Use random.randint()

shufflelist1 = []

for i in range(0,20) :
    random.seed(330 + i)
    shufflelist1.append(random.randint(1, 20))

print(shufflelist1) # There are overlapping values.


# Trial 2 : Use random.sample()

random.seed(330)
shufflelist2 = random.sample(range(1, 21), 20)

print(shufflelist2) # random.sample() offers values without overlapping.


# Trial 3 : Use while Statement

shufflelist3 = []
loopnum = 0

while len(shufflelist3) < 20 :
    random.seed(330 + loopnum)
    r = random.randint(1,20)
    if r not in shufflelist3 : shufflelist3.append(r)
    loopnum += 1

print(shufflelist3)
# It seems similar with Trial 1's sequence but there's no overlapping values.

print(loopnum) # It shows how many times overlapping numbers are rejected.
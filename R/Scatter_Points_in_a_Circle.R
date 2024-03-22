##############################
# Scatter Points in a Circle #
# (2021.08.16)               #
##############################


# 0. Call "plotrix" library (install if not exist)

if(!requireNamespace("plotrix")) install.packages("plotrix")
library("plotrix")


# 1. Monte Carlo method 1

r     = 10
n     = 30000

rr    = runif(n, 0, r)                    # rr    : randomly sampled radius
rrad  = runif(n, 0, 2 * pi)               # rrad  : randomly sampled radian

x     = rr * cos(rrad)                    # yes, I am a math genius!
y     = rr * sin(rrad)

windows(width = 7, height = 7)
plot(x, y, pch = '.', col = "red",
  main = "1. Monte Carlo method 1")
abline(v = -round(r*1.3):round(r*1.3), h = -r:r, col = "gray")
draw.circle(0, 0, r)                      # not exact drawing, crazy


# 1.1 Fit the circle on the coordinates

windows(width = 7, height = 7)
plot(x, y, pch = '.', col = "red", asp = 1, # modify asp(aspect ratio) option as 1
  main = "1.1 Monte Carlo method (with modified asp ratio)")
abline(v = -round(r*1.3):round(r*1.3), h = -r:r, col = "gray")
draw.circle(0, 0, r)


# 2. Monte Carlo method 2 (disperse the crowded central population)

x   = c(); y = c()
cnt = 0

while (cnt < n)                           # insert points only in the circle
{
  temp = runif(2, -r, r)
  if (temp[1]^2 + temp[2]^2 < r^2)
  {
    x   = c(x, temp[1])
    y   = c(y, temp[2])
    cnt = cnt + 1                         # I miss ++ operator ……
  }
}

windows(width = 7, height = 7)
plot(x, y, pch = '.', col = "red", asp = 1,
  main = "2. Monte Carlo method 2 (disperse the crowded central pop.)")
abline(v = -round(r*1.3):round(r*1.3), h = -r:r, col = "gray")
draw.circle(0, 0, r)


# 3. Points with lattice spacing

x         = c(); y = c()
area      = pi * r^2
interval  = sqrt(area / n)
num       = as.integer(floor(2 * r / interval))
temp      = c(-r, -r)

for (i in 1:num)
{
  temp[1] = temp[1] + interval

  for (j in 1:num)
  {
    temp[2] = temp[2] + interval

    if (temp[1]^2 + temp[2]^2 < r^2)
    {
      x = c(x, temp[1])
      y = c(y, temp[2])
    }
  }

  temp[2] = -r
}

length(x); length(y)

windows(width = 7, height = 7)
plot(x, y, pch = '.', col = "red", asp = 1,
  main = "3. Points with lattice spacing")
abline(v = -round(r*1.3):round(r*1.3), h = -r:r, col = "gray")
draw.circle(0, 0, r)


# 3.1 Points with lattice spacing including outside the circle

x     = c(); y = c(); xyCol = c()
temp  = c(-r, -r)

for (i in 1:num)
{
  temp[1] = temp[1] + interval
  
  for (j in 1:num)
  {
    temp[2] = temp[2] + interval

    x = c(x, temp[1])
    y = c(y, temp[2])

    if (temp[1]^2 + temp[2]^2 < r^2) xyCol = c(xyCol,"red")
    else xyCol = c(xyCol,"blue")
  }

  temp[2] = -r
}

length(x); length(y)
length(xyCol); length(xyCol[xyCol=="red"]); length(xyCol[xyCol=="blue"])

windows(width = 7, height = 7)
plot(x, y, pch = '.', col = xyCol, asp = 1,
  main = "3.1 Points with lattice spacing 2")
abline(v = -round(r*1.3):round(r*1.3), h = -r:r, col = "gray")
draw.circle(0, 0, r)
# Julia / Initial Practice
# 2024.05.28


# 1. Calculation

println(1 + 20 + 4)
println(+(1, 20, 4))
println()

x = 2
println(2x)
println()

for i ∈ 0:0.2:2
    println("sin^2($i π) + cos^2($i π) = ", sin(i * π)^2 + cos(i * π)^2)
end
# What is the difference between sin() and sin.()?


# 2. Macro : @time @threads

using Base.Threads


# 2.1 @time

x = zeros(3)

@time for i ∈ 1:10_000
    x += rand(3)
end
println()


# 2.2 @threads

Threads.nthreads() = 16                                     # no physical multi-core
println(Threads.nthreads())
println()

@time for i ∈ 1:20
    print(i, " ")
end
println()

@time @threads for i ∈ 1:20
    print(i, " ")
end
println()


# 3. Merge strings
println(join(["Hello", "World"], ""))
println("Hello" * "World")


# 4. K-means Clustering
# https://freshrimpsushi.github.io/ko/posts/3572/

using RDatasets, Clustering, Plots

# RDatasets.datasets()                                      # list datasets in RDatasets
data = dataset("datasets", "iris")[:, 1:4]
data = Array(data)'

results = kmeans(data, 3, display=:iter)
println()
println(results.centers)
println()
println(results.counts)
println()

names = ["sepallength", "sepalwidth"]                       # hope to call them from the dataset but ……
markers = [:circle, :utriangle, :xcross]

p = plot(dpi = 300, legend = :none)
for i in 1:3
    i_cluster = findall(x -> x == i, results.assignments)
    scatter!(
        p, data[1, i_cluster], data[2, i_cluster],
        marker = markers[i],
        ms = 6,
        xlabel = names[1],
        ylabel = names[2]
    )
end
display(p)

png(p, "iris_kmeans.png")


# 5. Regression
# https://freshrimpsushi.github.io/ko/posts/2493/#fn:1

using GLM, RDatasets

faithful = dataset("datasets", "faithful")

out1 = lm(@formula(Waiting ~ Eruptions), faithful)


# 6. Animated Plotting
# https://freshrimpsushi.github.io/ko/posts/3556/

using Plots

θ = range(0, 2π, length=100)
x = sin.(2θ * 2)
y = cos.(2θ * 2)
z = θ

anim = @animate for i ∈ 0:3:360
    plot(x, y, z, xlabel="x", ylabel="y", zlabel="z", camera=(i,30), title="azimuth = $i")
end
gif(anim, "helix.gif", fps=50)

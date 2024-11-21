"""
Monte Carlo Simulation of Price Index Random Walks

Author: kimpro82
Date  : 2024.11.20

This script performs a Monte Carlo simulation of price index random walks,
generating multiple paths and visualizing them on a chart.
"""

import Pkg

# List of necessary packages
packages = [
    "Distributions",
    "Plots"
]

# Function to install a package if it's not already installed
function install_if_needed(pkg::String)
    if !haskey(Pkg.project().dependencies, pkg)
        println("Installing package $(pkg)...")
        Pkg.add(pkg)
    end
end

# Install any missing packages from the list
for pkg in packages
    install_if_needed(pkg)
end

@time using Distributions, Plots
println("Packages loaded successfully.")

# Set simulation parameters
n_steps = 1000       # Number of simulation steps
n_simulations = 30   # Number of simulations
initial_value = 100  # Initial price index
μ = 0.0              # Mean of daily returns (log returns)
σ = 0.03             # Standard deviation of daily returns (log returns)

# Function to simulate price index random walks
function generate_random_walk(n_steps, initial_value, μ, σ)
    returns = rand(Normal(μ, σ), n_steps)
    price_changes = exp.(cumsum(returns))
    return initial_value * price_changes
end

# Generate multiple random walks
all_prices = [generate_random_walk(n_steps, initial_value, μ, σ) for _ in 1:n_simulations]

# Create the chart
p = plot(title="Monte Carlo Simulation of Price Index Random Walks",
         xlabel="Time Step",
         ylabel="Price Index",
         legend=false,
         titlefont=font(16))

# Plot each random walk
for prices in all_prices
    plot!(p, 1:n_steps, prices, alpha=0.5, linewidth=1.5)
end

# Add a horizontal line for the initial price index
hline!([initial_value], color=:red, linestyle=:dash, label="Initial Index", linewidth=2)

# Customize the appearance
plot!(p, size=(800, 600))
plot!(p, ylims=(0, maximum([maximum(prices) for prices in all_prices]) * 1.1))

# Save the chart
file_name = "random_walk.png"
savefig(p, "./Images/$(file_name)")
println("Chart saved as $(file_name).")

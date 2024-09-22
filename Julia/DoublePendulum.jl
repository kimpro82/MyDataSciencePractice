# Double Pendulum Simulation
# 2024.09.22

using Pkg

# List of packages to check and install
packages = [
    "Plots",
    "DifferentialEquations",
    "StaticArrays"
]

# Function to install packages if they are not already installed
function install_if_needed(pkg::String)
    if !haskey(Pkg.project().dependencies, pkg)
        println("Installing package: $pkg...")
        Pkg.add(pkg)
    end
end

# Install missing packages
for pkg in packages
    install_if_needed(pkg)
end

@time using Plots, DifferentialEquations, StaticArrays
println("Packages loaded successfully.")

# Physical constants
g = 9.81    # Acceleration due to gravity (m/s^2)
L1 = 1.0    # Length of the first rod (m)
L2 = 1.0    # Length of the second rod (m)
m1 = 1.0    # Mass of the first pendulum bob (kg)
m2 = 1.0    # Mass of the second pendulum bob (kg)

# Equations of motion for the double pendulum
function double_pendulum!(du, u, p, t)
    θ1, θ2, ω1, ω2 = u
    Δθ = θ2 - θ1
    denominator1 = (m1 + m2) * L1 - m2 * L1 * cos(Δθ)^2
    denominator2 = (L2 / L1) * denominator1

    du[1] = ω1
    du[2] = ω2
    du[3] = (m2 * L1 * ω1^2 * sin(Δθ) * cos(Δθ) + m2 * g * sin(θ2) * cos(Δθ) + 
              m2 * L2 * ω2^2 * sin(Δθ) - (m1 + m2) * g * sin(θ1)) / denominator1
    du[4] = (-m2 * L2 * ω2^2 * sin(Δθ) * cos(Δθ) + (m1 + m2) * (g * sin(θ1) * cos(Δθ) - 
              L1 * ω1^2 * sin(Δθ) - g * sin(θ2))) / denominator2
end

# Initial conditions: [θ1, θ2, ω1, ω2] (angles in radians, angular velocities)
u0 = [π/2, π/4, 0.0, 0.0]

# Time span for simulation (extended time)
tspan = (0.0, 40.0)  # Increased duration

# Define the problem
prob = ODEProblem(double_pendulum!, u0, tspan)

# Solve the problem with time step control
sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8, saveat=0.05)

# Store the trajectory of the second pendulum bob
x2_traj = []
y2_traj = []

# Create an animation
fps = 30  # Frames per second
frame_skip = max(Int(floor(length(sol.t) / (fps * (tspan[2] - tspan[1])))), 1)

println("Creating animation...")

# Measure the time taken to create the animation
@time begin
    anim = @animate for i in 1:frame_skip:length(sol.t)
        θ1 = sol[i][1]
        θ2 = sol[i][2]

        # Coordinates of the pendulum bobs
        x1 = L1 * sin(θ1)
        y1 = -L1 * cos(θ1)
        x2 = x1 + L2 * sin(θ2)
        y2 = y1 - L2 * cos(θ2)

        # Save second pendulum's position
        push!(x2_traj, x2)
        push!(y2_traj, y2)

        # Plot the double pendulum with fixed range, no grid, and axis
        plot(legend=false, aspect_ratio=:equal, xlims=(-2.2, 2.2), ylims=(-2.2, 0.7), grid=false, framestyle=:none)
        plot!([0, x1, x2], [0, y1, y2], linewidth=2, label="")
        scatter!([x1, x2], [y1, y2], markercolor=:red, markersize=12)
        scatter!([0], [0], markercolor=:blue, markersize=15)

        # Plot the solid line trajectory of the second pendulum
        plot!(x2_traj, y2_traj, linewidth=1, color=:grey)

        # Title and axis customization
        title!("Double Pendulum")
        plot!(titlefont = font(20))  # Set title font size

        plot!(xlabel="", ylabel="", xticks=:none, yticks=:none)  # Hide axis labels but keep axes
    end
end

# Save the animation as a gif
filename = "double_pendulum.gif"
gif(anim, filename, fps=fps)

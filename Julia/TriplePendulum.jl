# Triple Pendulum Simulation in Julia
# 2024.09.23

using Pkg

# List of necessary packages
packages = [
    "Plots",               # For plotting the pendulum and animation
    "DifferentialEquations",# To solve the differential equations of motion
    "StaticArrays"          # For efficient small array operations
]

# Function to install a package if it's not already installed
function install_if_needed(pkg::String)
    if !haskey(Pkg.project().dependencies, pkg)
        println("Installing package $pkg...")
        Pkg.add(pkg)
    end
end

# Install any missing packages from the list
for pkg in packages
    install_if_needed(pkg)
end

@time using Plots, DifferentialEquations, StaticArrays
println("Packages loaded successfully.")

# Physical constants for the triple pendulum system
g = 9.81   # Gravitational acceleration (m/s^2)
L1, L2, L3 = 1.0, 1.0, 1.0   # Lengths of the rods (meters)
m1, m2, m3 = 0.8, 1.0, 1.2   # Masses of the bobs (kg)

# Equations of motion for the triple pendulum system
function triple_pendulum!(du, u, p, t)
    θ1, θ2, θ3, ω1, ω2, ω3 = u   # Unpack current state variables
    Δθ12 = θ2 - θ1               # Angle difference between pendulums 1 and 2
    Δθ23 = θ3 - θ2               # Angle difference between pendulums 2 and 3

    # Denominators in the equations of motion, ensuring no division by zero
    denominator1 = (m1 + m2 + m3) * L1 - m2 * L1 * cos(Δθ12)^2 - m3 * L1 * cos(Δθ12)^2
    denominator2 = (m2 + m3) * L2 - m3 * L2 * cos(Δθ23)^2
    denominator3 = m3 * L3

    # First three components: angular velocities
    du[1] = ω1
    du[2] = ω2
    du[3] = ω3

    # Next three components: angular accelerations based on the equations of motion
    du[4] = (-g * (m1 + m2 + m3) * sin(θ1) - m2 * L2 * ω2^2 * sin(Δθ12) - m3 * L2 * ω2^2 * sin(Δθ12)) / denominator1
    du[5] = (-g * (m2 + m3) * sin(θ2) - m3 * L3 * ω3^2 * sin(Δθ23)) / denominator2
    du[6] = (-g * m3 * sin(θ3)) / denominator3
end

# Initial conditions: [θ1, θ2, θ3, ω1, ω2, ω3]
# Pendulum angles are π/4 radians, and angular velocities are 0.
u0 = [π/4, π/4, π/4, 0.0, 0.0, 0.0]

# Time span for the simulation (0 to 40 seconds)
tspan = (0.0, 40.0)

# Define the ODE problem using the triple_pendulum! function
prob = ODEProblem(triple_pendulum!, u0, tspan)

# Solve the ODE with time step control, adjusting for small errors
sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8, saveat=0.05)

# Lists to store the trajectory of the third pendulum bob
x3_traj = []
y3_traj = []

# Frame rate for the animation
fps = 30  # frames per second
# Determine how many solution steps to skip to achieve desired fps
frame_skip = max(Int(floor(length(sol.t) / (fps * (tspan[2] - tspan[1])))), 1)

println("Creating the animation...")

# Measure the time taken to create the animation
@time begin
    anim = @animate for i in 1:frame_skip:length(sol.t)
        # Unpack the angles at the i-th time step
        θ1 = sol[i][1]
        θ2 = sol[i][2]
        θ3 = sol[i][3]

        # Calculate the positions of the pendulum bobs
        x1 = L1 * sin(θ1)
        y1 = -L1 * cos(θ1)
        x2 = x1 + L2 * sin(θ2)
        y2 = y1 - L2 * cos(θ2)
        x3 = x2 + L3 * sin(θ3)
        y3 = y2 - L3 * cos(θ3)

        # Save the position of the third pendulum bob for plotting its trajectory
        push!(x3_traj, x3)
        push!(y3_traj, y3)

        # Plot the pendulum configuration
        plot(legend=false, aspect_ratio=:equal, xlims=(-3.2, 3.2), ylims=(-3.2, 2.2), grid=false, framestyle=:none)
        plot!([0, x1, x2, x3], [0, y1, y2, y3], linewidth=2, label="")
        scatter!([x1, x2, x3], [y1, y2, y3], markercolor=:red, markersize=12)
        scatter!([0], [0], markercolor=:blue, markersize=15)

        # Plot the trajectory of the third pendulum bob
        plot!(x3_traj, y3_traj, linewidth=1, color=:grey)

        # Add title and adjust font size
        title!("Triple Pendulum like My Wife")
        plot!(titlefont = font(20))

        # Hide axis labels but keep the axes visible
        plot!(xlabel="", ylabel="", xticks=:none, yticks=:none)
    end
end

# Save the animation as a gif file
filename = "triple_pendulum.gif"
gif(anim, filename, fps=fps)

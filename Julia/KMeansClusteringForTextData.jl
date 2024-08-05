# K-Means Clustering For Text Data
# 2024.08.05

using Pkg

# Check and install required packages if not already installed
function install_if_needed(pkg::String)
    """
    Checks if a package is installed. If not, installs it.
    
    # Arguments
    - `pkg::String`: The name of the package to check and install.
    """
    if !haskey(Pkg.project().dependencies, pkg)
        println("Installing package $pkg...")
        Pkg.add(pkg)
    else
        println("Package $pkg is already installed.")
    end
end

# List of packages to check and install
packages = [
    "JSON",
    "Random",
    "StatsBase",
    "Clustering",
    "Plots",
    "Distances",
    "LinearAlgebra",
    "Colors"
]

# Install missing packages
for pkg in packages
    install_if_needed(pkg)
end

using JSON
using Random
using StatsBase
using Clustering
using Plots
using Distances
using LinearAlgebra
using Colors

# Load texts from a JSON file
function load_texts_from_json(file_path::String)
    """
    Loads text data from a JSON file.
    
    # Arguments
    - `file_path::String`: The path to the JSON file.
    
    # Returns
    - A list of text data from the JSON file.
    """
    data = JSON.parsefile(file_path)
    return data["texts"]
end

texts_data = load_texts_from_json("texts.json")
println("Successfully loaded $(length(texts_data)) texts from the JSON file.")

# Extract contents and categories from the text data
indices = [item["index"] for item in texts_data]
contents = [item["content"] for item in texts_data]
categories = [item["category"] for item in texts_data]

# Function to filter outliers
function filter_outliers(X, indices_to_exclude)
    """
    Filters out specified outlier indices from the dataset.

    # Arguments
    - `X::Matrix{Float64}`: The dataset matrix.
    - `indices_to_exclude::Vector{Int}`: Indices of outliers to exclude.

    # Returns
    - A matrix with outliers filtered out.
    """
    return hcat([X[:, i] for i in 1:size(X, 2) if i ∉ indices_to_exclude]...)
end

# User-defined outlier indices (for further adjustments)
user_outlier_indices = []

# Filter contents and categories based on filtered_indices
filtered_indices = vec(filter_outliers(reshape(indices, 1, length(indices)), user_outlier_indices))
filtered_contents = [contents[i] for i in filtered_indices]
filtered_categories = [categories[i] for i in filtered_indices]
println("Filtered out $(length(user_outlier_indices)) user-defined outliers. Remaining data points: $(length(filtered_indices)).")

# Preprocess text by tokenizing and lowercasing
function preprocess(text)
    """
    Preprocesses text by splitting into words and converting to lowercase.
    
    # Arguments
    - `text::String`: The text to preprocess.
    
    # Returns
    - A list of words from the preprocessed text.
    """
    words = split(lowercase(text), r"[^\w]+")
    filter!(word -> word != "", words)
    return words
end

# Create a corpus from the contents
corpus = [preprocess(text) for text in filtered_contents]
vocab = unique(reduce(vcat, corpus))
println("Finished preprocessing texts.")

# Convert text to vectors based on vocabulary
function vectorize(text, vocab)
    """
    Converts a list of words to a vector based on the given vocabulary.

    # Arguments
    - `text::Vector{String}`: The list of words to vectorize.
    - `vocab::Vector{String}`: The vocabulary to use for vectorization.

    # Returns
    - A vector representing the frequency of each word in the vocabulary.
    """
    counts = countmap(text)
    return [get(counts, word, 0) for word in vocab]
end

# Vectorize all texts
vectors = [vectorize(text, vocab) for text in corpus]
X = hcat(vectors...)
println("Finished vectorizing texts.")

# Perform PCA for dimensionality reduction
function pca(X; k=2)
    """
    Applies Principal Component Analysis (PCA) for dimensionality reduction.

    # Arguments
    - `X::Matrix{Float64}`: The data matrix to reduce.
    - `k::Int`: The number of principal components to keep (default is 2).

    # Returns
    - A matrix with reduced dimensions based on PCA.
    """
    X_centered = X .- mean(X, dims=2)
    cov_matrix = X_centered * X_centered' / (size(X, 2) - 1)
    eigenvalues, eigenvectors = eigen(cov_matrix)
    sorted_indices = sortperm(eigenvalues, rev=true)
    top_indices = sorted_indices[1:k]
    return eigenvectors[:, top_indices]' * X_centered
end

# Perform PCA
X_reduced = pca(X; k=2)
println("Finished PCA.")

# Detect outliers from PCA results
function detect_outliers_pca(X_reduced; iqr_multiplier=1.5)
    """
    Detects outliers based on the PCA results using IQR.

    # Arguments
    - `X_reduced::Matrix{Float64}`: The PCA-reduced data matrix.
    - `iqr_multiplier::Float64`: The multiplier for IQR to determine outliers.

    # Returns
    - Indices of the detected outliers.
    """
    n = size(X_reduced, 2)
    outlier_indices = Int[]

    for j in 1:size(X_reduced, 1)
        pc_values = X_reduced[j, :]
        q1 = quantile(pc_values, 0.25)
        q3 = quantile(pc_values, 0.75)
        iqr = q3 - q1
        lower_bound = q1 - iqr_multiplier * iqr
        upper_bound = q3 + iqr_multiplier * iqr
        outlier_indices_for_pc = findall(x -> x < lower_bound || x > upper_bound, pc_values)
        append!(outlier_indices, outlier_indices_for_pc)
    end

    return unique(outlier_indices)
end

# Function to print outlier texts
function print_outlier_texts(texts, indices)
    """
    Prints the indices and truncated contents of texts that are considered outliers.

    # Arguments
    - `texts::Vector{String}`: The list of text contents.
    - `indices::Vector{Int}`: Indices of texts that are considered outliers.
    """
    if length(indices) > 0
        println("Detected outliers based on PCA:")
        for index in indices
            text = texts[index]
            truncated_text = length(text) > 50 ? text[1:50] * " ……" : text
            println("  Index $(filtered_indices[index]): $truncated_text")
        end
    else
        println("No outliers detected based on PCA.")
    end
end

# Detect outliers from PCA results
outlier_indices = detect_outliers_pca(X_reduced)

# Print detected outliers
print_outlier_texts(filtered_contents, outlier_indices)

# Perform K-means clustering
function perform_kmeans(X, k; distance=Euclidean())
    """
    Performs K-means clustering on the data matrix.

    # Arguments
    - `X::Matrix{Float64}`: The data matrix to cluster.
    - `k::Int`: The number of clusters.
    - `distance::Function`: The distance function to use (default is Euclidean).

    # Returns
    - A Clustering.KMeans result.
    """
    return kmeans(X, k; distance=distance)
end

k = 3  # Set the desired number of clusters
result = perform_kmeans(X, k)
labels = result.assignments
println("Finished K-means clustering with k=$k, n=$(length(filtered_indices)).")

# Map categories to marker initials
category_to_initial = Dict(
    "politics" => "P",
    "economics" => "E",
    "culture" => "C",
    "technology" => "T",
    "random" => "R"
)
marker_initials = [category_to_initial[category] for category in filtered_categories]

# Plot clusters with category initials
function save_clusters_plot(X_reduced, labels, marker_initials, k, filename="text_kmeans.png")
    """
    Saves a scatter plot of clustered data with category initials.

    # Arguments
    - `X_reduced::Matrix{Float64}`: The data matrix with reduced dimensions.
    - `labels::Vector{Int}`: Cluster labels for each data point.
    - `marker_initials::Vector{String}`: Initials representing categories.
    - `k::Int`: The number of clusters.
    - `filename::String`: The file name to save the plot (default is "text_kmeans.png").
    """
    p = scatter(X_reduced[1, :], X_reduced[2, :], group=labels, color=labels, 
                legend=false, marker=:o, markersize=10,  # Adjust marker size here
                title="K-Means Clustering Results for Text Data with k=$k, n=$(length(filtered_indices))",
                xlabel="PC1", ylabel="PC2", size=(800, 600))

    # Add text annotations for category initials
    scatter!(X_reduced[1, :], X_reduced[2, :], marker=:o, markersize=15, color=labels)
    for i in 1:size(X_reduced, 2)
        annotate!(
            X_reduced[1, i],
            X_reduced[2, i],
            text(marker_initials[i])
        )
    end

    savefig(filename)
end

# Plot clusters with category initials
save_clusters_plot(X_reduced, labels, marker_initials, k)
println("Cluster plot saved to file.")

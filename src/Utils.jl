module Utils

using Plots
using ..Fitness

gr() # set gr backend

"""
    visualize_results(fitness_function, best_chromosomes)

Generates a visualization of the optimization process based on the provided fitness function and best chromosomes.

# Arguments
- `fitness_function::Function`: The fitness function used.
- `best_chromosomes`: A sequence of optimization results for visualizing the optimization path.

# Example
```
julia
visualize_results(Fitness.rosenbrock_fitness, [(0.0, 0.0), (1.0, 1.0)])
```

"""
function visualize_results(fitness_function::Function, best_chromosomes)
    if fitness_function == Fitness.rosenbrock_fitness
        f(x, y) = fitness_function([x, y])
        
        # Automatically center result
        x_center, y_center = best_chromosomes[end]
        x_range = (x_center - 2.0, x_center + 2.0)
        y_range = (y_center - 2.0, y_center + 2.0)
        plt = visualize_function_with_contours(f, x_range=x_range, y_range=y_range, path=best_chromosomes)
        savefig(plt, "result.png")
    else
        # TODO sudoku fitness visualization
    end
end

"""
Plots a contour of a 2D function over the specified x and y ranges.

# Arguments
- `f::Function`: The function to visualize.
- `x_range`: Range of x-values (default: (-2.0, 2.0)).
- `y_range`: Range of y-values (default: (-2.0, 2.0)).
- `path`: Optimization path points (default: []).

# Returns
A contour plot of the function with optional highlighted points.
"""
function visualize_function_with_contours(
    f::Function;
    x_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    y_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    path::Vector{Tuple{Float64, Float64}} = []
)
    x = range(x_range[1], x_range[2], length=100)
    y = range(y_range[1], y_range[2], length=100)
    z = [f(xi, yi) for yi in y, xi in x]

    plt = contour(x, y, z, color=:viridis, linewidth=2)

    if !isempty(path)
        x_points = [p[1] for p in path]
        y_points = [p[2] for p in path]

        plot!(plt, x_points, y_points, color=:red, label="optimization path", linewidth=2)
        scatter!(plt, x_points[2:end], y_points[2:end], color=:red, marker=:circle, markersize=3, label="")
        scatter!(plt, [x_points[end]], [y_points[end]], color=:green, marker=:circle, markersize=5, label="optimization result")
    end

    return plt
end

export visualize_function_with_contours

end
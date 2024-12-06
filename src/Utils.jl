module Utils

using Plots

gr() # set gr backend

# TODO remove this when fitness pr is merged
function rosenbrock_fitness(values::Vector{Float64})::Float64 
    m = length(values)
    if m < 2
        throw(ArgumentError("Rosenbrock function requires at least two dimensions."))
    end

     # negative to maximize the function
    return - sum(
        100 * (values[i+1] - values[i]^2)^2 + (1 - values[i])^2
        for i in 1:m-1
    )
end

function visualize_function_with_contours(
    f::Function;
    x_range::Tuple{Float64, Float64} = (1.0, 1.0),
    y_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    points::Vector{Tuple{Float64, Float64}} = []
)
    # generate function grid
    x = range(x_range[1], x_range[2], length=100)
    y = range(y_range[1], y_range[2], length=100)
    z = [f(xi, yi) for xi in x, yi in y]

    plt = contour(x, y, z, color=:viridis, linewidth=2)

    # add points
    if !isempty(points)
        scatter!(plt, [p[1] for p in points], [p[2] for p in points], color=:red, marker=:circle, label="provided points")
    end

    return plt
end

# TODO move this to test_utils somehow without errors
f(x, y) = rosenbrock_fitness([x, y])
points = [(1.0, 0.0), (-1.0, -1.0)]
plt = visualize_function_with_contours(f, x_range=(-2.0, 2.0), y_range=(-1.0, 3.0), points=points)
savefig(plt, "contour_plot.png")

export visualize_function_with_contours

end
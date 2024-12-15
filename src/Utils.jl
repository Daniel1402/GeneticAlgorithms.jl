module Utils

using Plots

gr() # set gr backend

function visualize_function_with_contours(
    f::Function;
    x_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    y_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    points::Vector{Tuple{Float64, Float64}} = []
)
    # generate function grid
    x = range(x_range[1], x_range[2], length=100)
    y = range(y_range[1], y_range[2], length=100)
    z = [f(xi, yi) for yi in y, xi in x]

    plt = contour(x, y, z, color=:viridis, linewidth=2)

    # add points
    if !isempty(points)
        scatter!(plt, [p[1] for p in points], [p[2] for p in points], color=:red, marker=:circle, label="provided points")
    end

    return plt
end

export visualize_function_with_contours

end
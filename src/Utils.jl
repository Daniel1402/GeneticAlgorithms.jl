module Utils

using Plots

gr() # set gr backend

"""
Plots a contour of the function `f(x, y)` over the specified x and y ranges, with optional points highlighted.

# Arguments
- `f::Function`: The function to visualize.
- `x_range`: Range of x-values (default: (-2.0, 2.0)).
- `y_range`: Range of y-values (default: (-2.0, 2.0)).
- `points`: List of points to highlight (default: []).

# Returns
A contour plot of the function with optional highlighted points.
"""
function visualize_function_with_contours(
    f::Function;
    x_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    y_range::Tuple{Float64, Float64} = (-2.0, 2.0),
    points::Vector{Tuple{Float64, Float64}} = []
)
    x = range(x_range[1], x_range[2], length=100)
    y = range(y_range[1], y_range[2], length=100)
    z = [f(xi, yi) for yi in y, xi in x]

    plt = contour(x, y, z, color=:viridis, linewidth=2)

    if !isempty(points)
        x_points = [p[1] for p in points]
        y_points = [p[2] for p in points]

        plot!(plt, x_points, y_points, color=:red, label="optimization path", linewidth=2)
        scatter!(plt, x_points[2:end], y_points[2:end], color=:red, marker=:circle, markersize=3, label="")
        scatter!(plt, [x_points[end]], [y_points[end]], color=:green, marker=:circle, markersize=5, label="optimization result")
    end

    return plt
end

export visualize_function_with_contours

end
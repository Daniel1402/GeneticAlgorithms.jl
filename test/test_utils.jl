using Test

include("../src/GeneticAlgorithms.jl")

using Plots
using GeneticAlgorithms.Utils
using GeneticAlgorithms.Fitness

@testset "Utils Visualization Tests" begin
    # f(x, y) = rosenbrock_fitness([x, y])
    # points = [(1.0, 0.0), (-1.0, -1.0)]
    # plt = visualize_function_with_contours(f, x_range=(-2.0, 2.0), y_range=(-1.0, 3.0), points=points)
    # savefig(plt, "contour_plot.png")
end
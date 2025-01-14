using Test
using Plots

using GeneticAlgorithms.Utils
using GeneticAlgorithms.Fitness

@testset "Visualization Tests" begin
    try
        # Sample test
        f(x, y) = sin(x) * cos(y)
        path = [(-π/2, 0.0), (π/2, 0.0)]
        plt = visualize_function_with_contours(f, x_range=(-1π, 1π), y_range=(-1π, 1π), path=path)
        savefig(plt, "sin*cos.png")

        # Rosenbrock
        f(x, y) = rosenbrock_fitness([x, y])
        path = [(1.0, 1.0)]
        plt = visualize_function_with_contours(f, x_range=(-2.0, 2.0), y_range=(-1.0, 3.0), path=path)
        savefig(plt, "rosenbrock.png")
        @test true
    catch e
        @error "Test failed with error" exception=e
        @test false
    end
end
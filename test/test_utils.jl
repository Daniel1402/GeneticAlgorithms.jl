using Test
using Plots

using GeneticAlgorithms.Utils
using GeneticAlgorithms.Fitness

@testset "Visualization Tests" begin
    # Sample test
    f(x, y) = sin(x) * cos(y)
    path = [(-π / 2, 0.0), (π / 2, 0.0)]
    plt = visualize_function_with_contours(f, x_range=(-1π, 1π), y_range=(-1π, 1π), path=path)
    savefig(plt, "sin_times_cos.png")

    # Rosenbrock
    f(x, y) = rosenbrock_fitness(Chromosome([x, y]))
    path = [(1.0, 1.0)]
    plt = visualize_function_with_contours(f, x_range=(-2.0, 2.0), y_range=(-1.0, 3.0), path=path)
    savefig(plt, "rosenbrock.png")

    path = [Chromosome([0.0, 0.0]), Chromosome([0.5, 0.5]), Chromosome([1.0, 1.0])]
    visualize_rosenbrock_results(path, "rosenbrock_path.png")


end
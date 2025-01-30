using Plots: savefig
using GeneticAlgorithms.Visualization

@testset "Visualization Tests" begin
    # Sample test
    f(x::Float64, y::Float64) = sin(x) * cos(y)
    path = [(-π / 2, 0.0), (π / 2, 0.0)]
    plt = visualize_function_with_contours(
        f,
        x_range = (-1π, 1π),
        y_range = (-1π, 1π),
        path = path,
    )
    savefig(plt, "sin_times_cos.png")

    # Rosenbrock
    g(x::Float64, y::Float64) = rosenbrock_fitness(Chromosome([x, y]))
    path = [(1.0, 1.0)]
    plt = visualize_function_with_contours(
        g,
        x_range = (-2.0, 2.0),
        y_range = (-1.0, 3.0),
        path = path,
    )
    savefig(plt, "rosenbrock.png")

    path = [Chromosome([0.0, 0.0]), Chromosome([0.5, 0.5]), Chromosome([1.0, 1.0])]
    visualize_rosenbrock_results(path, "rosenbrock_path.png")
end


using Suppressor
@testset "PrintSudoku Tests" begin
    # Since there was no feasible way to test the output of the function, we just test if it throws an error
    sudoku = [
        [5, 3, 0, 0, 7, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9],
    ]
    chromosome = Chromosome(sudoku)
    output = @capture_out print_sudoku(chromosome)

    expected_output = " 5  3  0  |  0  7  0  |  0  0  0 \n 6  0  0  |  1  9  5  |  0  0  0 \n 0  9  8  |  0  0  0  |  0  6  0 \n----------+-----------+----------\n 8  0  0  |  0  6  0  |  0  0  3 \n 4  0  0  |  8  0  3  |  0  0  1 \n 7  0  0  |  0  2  0  |  0  0  6 \n----------+-----------+----------\n 0  6  0  |  0  0  0  |  2  8  0 \n 0  0  0  |  4  1  9  |  0  0  5 \n 0  0  0  |  0  8  0  |  0  7  9 \n"
    @test output == expected_output
end

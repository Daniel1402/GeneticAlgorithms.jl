using Test

using GeneticAlgorithms.PopulationInitialization

@testset "RealUniformInitialization" begin
    population_initialization = RealUniformInitialization(60, 5, (0.0, 1.0))
    population = population_initialization()
    @test length(population.chromosomes) == 60
    @test all([length(population.chromosomes[i].genes) == 5 for i in 1:60])
    @test all([all([chromosome.genes[i] <= 1 for i in 1:length(chromosome.genes)]) for chromosome in population.chromosomes])

    population_initialization = RealUniformInitialization(20, 50, (-14.3, 18.2))
    population = population_initialization()
    @test length(population.chromosomes) == 20
    @test all([length(population.chromosomes[i].genes) == 50 for i in 1:20])
    @test all([all([chromosome.genes[i] <= 18.2 && chromosome.genes[i] >= -14.3 for i in 1:length(chromosome.genes)]) for chromosome in population.chromosomes])

    @test_throws ArgumentError RealUniformInitialization(0, 0, (0.0, 1.0))
    @test_throws ArgumentError RealUniformInitialization(-1, 0, (0.0, 1.0))
    @test_throws ArgumentError RealUniformInitialization(0, -1, (0.0, 1.0))
    @test_throws ArgumentError RealUniformInitialization(3, 1, (2, 1))
    @test_throws ArgumentError RealUniformInitialization(3, 1, (1, 1))
    @test_throws ArgumentError RealUniformInitialization(10, 3, [(0.0, 1.0), (-10.0, 10.0)])
    @test_throws ArgumentError RealUniformInitialization(10, 2, (1.0, 1.0))
    @test_throws ArgumentError RealUniformInitialization(10, 3, [(0.0, 1.0), (-10.0, 10.0), (5.0, 5.0)])
end

@testset "AsymmetricPopulationInitialization" begin
    population_initialization = RealUniformInitialization(10, 3, [(0.0, 1.0), (-10.0, 10.0), (5.0, 15.0)])
    population = population_initialization()
    @test length(population.chromosomes) == 10
    @test all([length(population.chromosomes[i].genes) == 3 for i in 1:10])
    @test all([chromosome.genes[1] >= 0.0 && chromosome.genes[1] <= 1.0 &&
            chromosome.genes[2] >= -10.0 && chromosome.genes[2] <= 10.0 &&
            chromosome.genes[3] >= 5.0 && chromosome.genes[3] <= 15.0 for chromosome in population.chromosomes])

    @test_throws ArgumentError RealUniformInitialization(10, 3, [(0.0, 1.0), (-10.0, 10.0)])
    @test_throws ArgumentError RealUniformInitialization(10, 2, (1.0, 1.0))

end

@testset "SudokuInitialization" begin
    test_sudoku = [
        [5, 3, 0, 0, 7, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ]
    
    @test_throws ArgumentError SudokuInitialization(-1, test_sudoku)
    @test_throws ArgumentError SudokuInitialization(10, [[0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]])
    @test_throws ArgumentError SudokuInitialization(10, [
        [5, 0, 0, 7, 0, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7]
    ])

    population_initialization = SudokuInitialization(30, test_sudoku)
    population = population_initialization()
    # The initial cell values should be contained in each chromosome.
    cells_initialized = true
    for chromosome in population.chromosomes
        for i in eachindex(chromosome.genes)
            bool_vec = chromosome.genes[i] .== test_sudoku[i]
            bool_vec = bool_vec .|| test_sudoku[i] .== 0
            cells_initialized &= reduce(|, bool_vec)
        end
    end
    @test cells_initialized

    # Each column should contain a permutation of [1, 2, 3, 4, 5, 6, 7, 8, 9]
    no_duplicates_in_columns = true
    sudoku_values = Set(1:9)
    for chromosome in population.chromosomes
        for column in chromosome.genes
            no_duplicates_in_columns &= length(setdiff(sudoku_values, Set(column))) == 0
        end
    end
    @test no_duplicates_in_columns
end
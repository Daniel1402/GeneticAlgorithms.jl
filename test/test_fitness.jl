using Test

using GeneticAlgorithms.Fitness

@testset "Rosenbrock Fitness Tests" begin

    @test rosenbrock_fitness(Chromosome([1.0, 1.0])) ≈ 100
    @test rosenbrock_fitness(Chromosome([0.0, 0.0])) ≈ 50

    @test rosenbrock_fitness(Chromosome([1.0, 1.0, 1.0])) ≈ 100
    @test rosenbrock_fitness(Chromosome([0.0, 0.0, 0.0])) ≈ 100 / 3
    
    @test rosenbrock_fitness(Chromosome(ones(5))) ≈ 100
    

    # Test with invalid input
    @test_throws ArgumentError rosenbrock_fitness(Chromosome([1.0]))    
end

@testset "sudoku_fitness" begin
    @test sudoku_fitness(Chromosome([Vector(1:9) for _ in 1:9])) == 36
    
    # Maximal fitness value is 162 (Sudoku is solved!)
    solved_sudoku = [
        [7, 4, 8, 5, 9, 6, 3, 2, 1], 
        [6, 9, 3, 1, 2, 8, 4, 7, 5], 
        [2, 5, 1, 3, 7, 4, 8, 6, 9], 
        [1, 7, 9, 6, 3, 5, 2, 8, 4], 
        [4, 8, 6, 2, 1, 7, 5, 9, 3], 
        [3, 2, 5, 8, 4, 9, 6, 1, 7], 
        [8, 1, 4, 7, 6, 3, 9, 5, 2], 
        [9, 6, 7, 4, 5, 2, 1, 3, 8], 
        [5, 3, 2, 9, 8, 1, 7, 4, 6] 
    ]
    @test sudoku_fitness(Chromosome(solved_sudoku)) == 162

    # Duplicates in rows (Sudoku is saved transposed)
    partially_solved_sudoku_1 = [
        [7, 4, 8, 5, 9, 6, 3, 2, 1], 
        [6, 9, 3, 1, 2, 8, 4, 7, 5], 
        [1, 5, 2, 3, 7, 4, 8, 6, 9], 
        [1, 7, 9, 6, 3, 5, 2, 8, 4], 
        [4, 8, 6, 2, 1, 7, 5, 9, 3], 
        [3, 2, 5, 8, 4, 9, 6, 1, 7], 
        [8, 1, 4, 7, 6, 3, 9, 5, 2], 
        [9, 6, 7, 4, 5, 2, 3, 1, 8], 
        [5, 3, 2, 9, 8, 1, 7, 4, 6] 
    ]

    @test sudoku_fitness(Chromosome(partially_solved_sudoku_1)) == 158

    # Duplicates in 3x3 subgrids and rows
    partially_solved_sudoku_2 = [
        [7, 6, 8, 5, 9, 4, 3, 2, 1], 
        [6, 9, 3, 1, 2, 8, 4, 7, 5], 
        [2, 5, 1, 3, 7, 4, 8, 6, 9], 
        [1, 7, 9, 6, 3, 5, 2, 8, 4], 
        [4, 8, 6, 2, 1, 7, 5, 9, 3], 
        [3, 2, 5, 8, 4, 9, 6, 1, 7], 
        [8, 1, 4, 7, 6, 3, 9, 5, 2], 
        [9, 6, 7, 4, 5, 2, 1, 3, 8], 
        [5, 3, 2, 9, 8, 1, 7, 4, 6] 
    ]
    @test sudoku_fitness(Chromosome(partially_solved_sudoku_2)) == 158 # 160
end
using Test
using GeneticAlgorithms.Selection

population = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]
fitness_scores = [10.0, 20.0, 30.0, 40.0]


@testset "Roulette Wheel Selection" begin
    # Test: ArgumentErrors
    @test_throws ArgumentError rouletteWheelSelection(population, [10.0, 20.0]) # Different lengths
    @test_throws ArgumentError rouletteWheelSelection([[1, 2, 3]], [10.0]) # less than 2 individuals
    @test_throws ArgumentError rouletteWheelSelection(population, [-10.0, 20.0, 30.0, 40.0]) # Negative fitness scores

    parent1, parent2 = rouletteWheelSelection(population, fitness_scores)
    @test parent1 in population
    @test parent2 in population
    @test parent1 != parent2 

    parent1, parent2 = rouletteWheelSelection(population, fitness_scores, () -> 0.25)
    @test parent1 == [4, 5, 6]
    @test parent2 == [7, 8, 9]

    parent1, parent2 = rouletteWheelSelection(population, fitness_scores, () -> 0.75)
    @test parent1 == [10, 11, 12] 
    @test parent2 == [7, 8, 9] 

    parent1, parent2 = rouletteWheelSelection(population, fitness_scores, () -> 0.3)
    @test parent1 == [4, 5, 6]
    @test parent2 == [7, 8, 9]


    # Test: Fitness scores with zero values
    zero_fitness_population = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    zero_fitness_scores = [10.0, 0.0, 30.0]
    parent1, parent2 = rouletteWheelSelection(zero_fitness_population, zero_fitness_scores)

    if parent1 == [1, 2, 3]
        @test parent2 == [7, 8, 9]
    else
        @test parent1 == [7, 8, 9]
        @test parent2 == [1, 2, 3]
    end
end

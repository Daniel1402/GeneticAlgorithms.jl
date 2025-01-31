@testset "RouletteWheelSelection" begin

    population = Population([
    Chromosome([1, 2, 3]),
    Chromosome([4, 5, 6]),
    Chromosome([7, 8, 9]),
    Chromosome([10, 11, 12]),
    ])
    fitness_scores = [10.0, 20.0, 30.0, 40.0]

    rouletteWheelSelection = RouletteWheelSelection()
    # Test: ArgumentErrors
    @test_throws ArgumentError rouletteWheelSelection(population, [10.0, 20.0]) # Different lengths
    @test_throws ArgumentError rouletteWheelSelection(
        Population([Chromosome([1, 2, 3])]),
        [10.0],
    ) # less than 2 individuals
    @test_throws ArgumentError rouletteWheelSelection(population, [-10.0, 20.0, 30.0, 40.0]) # Negative fitness scores
    @test_throws ArgumentError rouletteWheelSelection(population, [0.0, 0.0, 0.0, 0.0]) # All zero fitness scores

    test1_parent1, test1_parent2 = rouletteWheelSelection(population, fitness_scores)
    @test test1_parent1 in population.chromosomes
    @test test1_parent2 in population.chromosomes
    @test test1_parent1 != test1_parent2

    test2_parent1, test2_parent2 =
        rouletteWheelSelection(population, fitness_scores, () -> 0.25)
    @test test2_parent1.genes == [4, 5, 6]
    @test test2_parent2.genes == [7, 8, 9]

    test3_parent1, test3_parent2 =
        rouletteWheelSelection(population, fitness_scores, () -> 0.75)
    @test test3_parent1.genes == [10, 11, 12]
    @test test3_parent2.genes == [7, 8, 9]

    test5_parent1, test5_parent2 =
        rouletteWheelSelection(population, fitness_scores, () -> 0.3)
    @test test5_parent1.genes == [4, 5, 6]
    @test test5_parent2.genes == [7, 8, 9]

    # Test: Fitness scores with zero values
    zero_fitness_population =
        Population([Chromosome([1, 2, 3]), Chromosome([4, 5, 6]), Chromosome([7, 8, 9])])
    zero_fitness_scores = [10.0, 0.0, 30.0]
    test6_parent1, test6_parent2 =
        rouletteWheelSelection(zero_fitness_population, zero_fitness_scores)

    if test6_parent1.genes == [1, 2, 3]
        @test test6_parent2.genes == [7, 8, 9]
    else
        @test test6_parent1.genes == [7, 8, 9]
        @test test6_parent2.genes == [1, 2, 3]
    end

    # Test: Population with exactly 2 individuals
    two_individuals_population = Population([Chromosome([1, 2, 3]), Chromosome([4, 5, 6])])
    two_individuals_fitness_scores = [10.0, 20.0]
    test7_parent1, test7_parent2 =
        rouletteWheelSelection(two_individuals_population, two_individuals_fitness_scores)
    @test test7_parent1.genes == [1, 2, 3]
    @test test7_parent2.genes == [4, 5, 6]
end

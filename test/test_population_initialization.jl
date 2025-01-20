using Test

using GeneticAlgorithms.PopulationInitialization

@testset "PopulationInitialization.jl" begin
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
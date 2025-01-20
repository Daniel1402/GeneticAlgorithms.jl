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

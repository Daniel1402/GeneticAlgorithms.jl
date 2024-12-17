using Test

using GeneticAlgorithms.Fitness

@testset "Rosenbrock Fitness Tests" begin
    @test rosenbrock_fitness([1.0, 1.0]) ≈ 100
    @test rosenbrock_fitness([0.0, 0.0]) ≈ 50

    @test rosenbrock_fitness([1.0, 1.0, 1.0]) ≈ 100
    @test rosenbrock_fitness([0.0, 0.0, 0.0]) ≈ 100 / 3

    @test rosenbrock_fitness(ones(5)) ≈ 100

    @test_throws ArgumentError rosenbrock_fitness([1.0])
end

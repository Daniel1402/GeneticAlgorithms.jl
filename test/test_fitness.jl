using Test

include("../src/GeneticAlgorithms.jl")

using .GeneticAlgorithms.Fitness

@testset "Rosenbrock Fitness Tests" begin
    @test rosenbrock_fitness([1.0, 1.0]) ≈ 0.0
    @test rosenbrock_fitness([0.0, 0.0]) < 0.0

    @test rosenbrock_fitness([1.0, 1.0, 1.0]) ≈ 0.0
    @test rosenbrock_fitness([0.0, 0.0, 0.0]) < 0.0

    @test rosenbrock_fitness(ones(5)) ≈ 0.0
    
    @test_throws ArgumentError rosenbrock_fitness([1.0])
end
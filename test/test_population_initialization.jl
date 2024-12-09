using Test

using GeneticAlgorithms.PopulationInitialization

@testset "PopulationInitialization.jl" begin
    population = uniform(60, 5)
    @test size(population) == (60, 5)
    @test ~reduce(|, population .> 1 .|| population .< 0)
    
    population = uniform(20, 50, (-14.3, 18.2))
    @test size(population) == (20, 50)
    @test ~reduce(|, population .> 18.2 .|| population .< -14.3)

    @test_throws ArgumentError uniform(0, 0)
    @test_throws ArgumentError uniform(-1, 0)
    @test_throws ArgumentError uniform(0, -1)
    @test_throws ArgumentError uniform(3, 1, (2, 1))
    @test_throws ArgumentError uniform(3, 1, (1, 1))

end
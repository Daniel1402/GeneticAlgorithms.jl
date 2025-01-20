using Test

using GeneticAlgorithms
using GeneticAlgorithms.Selection
using GeneticAlgorithms.Crossover
using GeneticAlgorithms.Mutation
using GeneticAlgorithms.Fitness
using GeneticAlgorithms.PopulationInitialization

@testset "GeneticAlgorithms.jl" begin
    uniform = RealUniformInitialization(10, 5, (-0.5, 0.5))
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
    sum_abs = (genes) -> sum(abs.(genes))
    ga = GeneticAlgorithm(uniform, sum_abs, rouletteWheelSelection, singlePointCrossover, geneMutation)
    optimize(ga)

    uniform = RealUniformInitialization(100, 2, (-2.0, 2.0))
    ga_rosenbrock = GeneticAlgorithm(uniform, rosenbrock_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, true, 100, 0.5, true)
    println(optimize(ga_rosenbrock))
    fitness_pre = ga_rosenbrock.best_fitness[1]
    i = 1
    for fitness_score in ga_rosenbrock.best_fitness
        @test fitness_score >= fitness_pre
        fitness_pre = fitness_score
        @test fitness_score ≈ rosenbrock_fitness(ga_rosenbrock.best_chromosomes[i])
        i += 1
    end
    @test length(ga_rosenbrock.best_chromosomes) == 101 # 100 generations + initial population
    @test length(ga_rosenbrock.best_fitness) == 101
end
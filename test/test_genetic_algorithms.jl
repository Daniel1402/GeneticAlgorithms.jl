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

    uniform = RealUniformInitialization(1000, 2, (-1.0, 1.0))
    ga_rosenbrock = GeneticAlgorithm(uniform, rosenbrock_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, true, 100, 0.5)
    println(optimize(ga_rosenbrock))
end
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
    geneMutation = RealGeneMutation(0.1, (-0.5, 0.5))
    ga = GeneticAlgorithm(uniform, sumFitness, rouletteWheelSelection, singlePointCrossover, geneMutation)
    optimize(ga)
end
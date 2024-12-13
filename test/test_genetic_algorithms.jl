using Test

using GeneticAlgorithms
using GeneticAlgorithms.Selection
using GeneticAlgorithms.Crossover
using GeneticAlgorithms.Mutation
using GeneticAlgorithms.Fitness
using GeneticAlgorithms.PopulationInitialization

@testset "GeneticAlgorithms.jl" begin

    ga =  GeneticAlgorithm(uniform, sum, rouletteWheelSelection, singlePointCrossover, RealGeneMutation(0.1, (-0.5, 0.5)))
    optimize(ga)
end
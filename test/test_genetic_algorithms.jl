using Test

using GeneticAlgorithms
using GeneticAlgorithms.Selection
using GeneticAlgorithms.Crossover
using GeneticAlgorithms.Mutation
using GeneticAlgorithms.Fitness
using GeneticAlgorithms.PopulationInitialization

@testset "GeneticAlgorithms.jl" begin
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


@testset "GeneticAlgorithms.jl" begin
    initial = [
        [5, 3, 0, 0, 7, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ]
    initStrategy = SudokuInitialization(10, initial)
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = SudokuMutation(0.1, initial)
    fitness_fn = (genes) -> sum(abs.(genes))
    ga = GeneticAlgorithm(initStrategy, sudoku_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, true, 500)
    optimize(ga)
end
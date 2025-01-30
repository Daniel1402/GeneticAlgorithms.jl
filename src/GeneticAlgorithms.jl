module GeneticAlgorithms

using Distributions: Uniform
using Random: shuffle


include("Types.jl")
export PopulationInitializationMethod, SelectionMethod, CrossoverMethod, MutationMethod, Population, Chromosome

include("PopulationInitialization.jl")
export RealUniformInitialization, SudokuInitialization

include("Selection.jl")
export RouletteWheelSelection

include("Crossover.jl")
export SinglePointCrossover

include("Mutation.jl")
export RealGeneMutation, SudokuMutation

include("Fitness.jl")
export rosenbrock_fitness, sudoku_fitness

include("Optimization.jl")
export optimize, GeneticAlgorithm

include("Visualization.jl")
export Visualization

end
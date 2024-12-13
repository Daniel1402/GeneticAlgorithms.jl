using Test

#include("../src/GeneticAlgorithms.jl")
using GeneticAlgorithms

include("test_crossover.jl")
include("test_population_initialization.jl")
# include("test_selection.jl")
# include("test_mutation.jl")
# include("test_fitness.jl")
# include("test_genetic_algorithms.jl")
# include("test_utils.jl")

@testset "GeneticAlgorithms.jl" begin
    # Write your tests here.
end

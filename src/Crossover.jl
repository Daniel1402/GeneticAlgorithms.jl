module Crossover

using ..Types

"""
    SinglePointCrossover

    Defines the single point crossover method for two chromosomes.
"""
struct SinglePointCrossover <: CrossoverMethod end

function (c::SinglePointCrossover)(parent1::C, parent2::C)::Tuple{C,C} where {C<:Chromosome}
    crossover_point = rand(1:length(parent1.genes))
    offspring1 = vcat(parent1[1:crossover_point], parent2[crossover_point+1:end])
    offspring2 = vcat(parent2[1:crossover_point], parent1[crossover_point+1:end])
    return offspring1, offspring2
end


export SinglePointCrossover
end
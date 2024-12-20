module Crossover

using ..Types

"""
    SinglePointCrossover

    Defines the single point crossover method for two chromosomes.
"""
struct SinglePointCrossover <: CrossoverMethod end

function (c::SinglePointCrossover)(parent1::C, parent2::C)::Tuple{C,C} where {C<:Chromosome}
    crossover_point = rand(1:length(parent1.genes))
    offspring1 = C(vcat(parent1.genes[1:crossover_point], parent2.genes[crossover_point+1:end]))
    offspring2 = C(vcat(parent2.genes[1:crossover_point], parent1.genes[crossover_point+1:end]))
    return offspring1, offspring2
end


export SinglePointCrossover
end
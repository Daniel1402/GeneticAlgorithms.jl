"""
    SinglePointCrossover()

Callable type for the single point crossover method. 
The single point crossover method selects a random point in the chromosome and swaps all genes after that point.
"""
struct SinglePointCrossover <: CrossoverMethod end

"""
    (c::SinglePointCrossover)(parent1::C, parent2::C)::Tuple{C,C} where {C<:Chromosome}

Performs single point crossover on two parent chromosomes, returning two offspring chromosomes.
"""
function (c::SinglePointCrossover)(parent1::C, parent2::C)::Tuple{C,C} where {C<:Chromosome}
    crossover_point = rand(1:length(parent1.genes))
    offspring1 =
        C(vcat(parent1.genes[1:crossover_point], parent2.genes[crossover_point+1:end]))
    offspring2 =
        C(vcat(parent2.genes[1:crossover_point], parent1.genes[crossover_point+1:end]))
    return offspring1, offspring2
end

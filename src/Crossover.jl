module Crossover

abstract type CrossoverMethod end

struct SinglePointCrossover <: CrossoverMethod end


function (c::SinglePointCrossover)(parent1::Chromosome, parent2::Chromosome)::Tuple{Chromosome, Chromosome}
    crossover_point = rand(1:length(parent1.genes))
    offspring1 = vcat(parent1.genes[1:crossover_point], parent2.genes[crossover_point+1:end])
    offspring2 = vcat(parent2.genes[1:crossover_point], parent1.genes[crossover_point+1:end])
    return offspring1, offspring2
end


export singlePointCrossover
end
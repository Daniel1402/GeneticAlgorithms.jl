module Types

abstract type PopulationInitializationMethod end
abstract type SelectionMethod end
abstract type CrossoverMethod end
abstract type MutationMethod end

const Chromosome = Array{T,1} where {T}

const Population = Array{Chromosome,1}

export PopulationInitializationMethod, SelectionMethod, CrossoverMethod, MutationMethod, Population, Chromosome
end
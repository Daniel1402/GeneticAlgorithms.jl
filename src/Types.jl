module Types

abstract type PopulationInitializationMethod end
abstract type SelectionMethod end
abstract type CrossoverMethod end
abstract type MutationMethod end


struct Chromosome{T}
    genes::Vector{T}
end

struct Population{T<:Chromosome}
    chromosomes::Vector{T}
end

export PopulationInitializationMethod, SelectionMethod, CrossoverMethod, MutationMethod, Population, Chromosome

end
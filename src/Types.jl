module Types

abstract type PopulationInitializationMethod end
abstract type SelectionMethod end
abstract type CrossoverMethod end
abstract type MutationMethod end


struct Chromosome{T}
    genes::Vector{T}
end

Base.length(c::Chromosome) = length(c.genes)
Base.iterate(c::Chromosome) = iterate(c.genes)
Base.iterate(c::Chromosome, state) = iterate(c.genes, state)

struct Population{T<:Chromosome}
    chromosomes::Vector{T}
end

export PopulationInitializationMethod, SelectionMethod, CrossoverMethod, MutationMethod, Population, Chromosome

end
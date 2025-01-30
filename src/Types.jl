module Types


"""
    PopulationInitializationMethod

Abstract type for population initialization methods.
"""
abstract type PopulationInitializationMethod end

"""
    SelectionMethod

Abstract type for selection methods.
"""
abstract type SelectionMethod end

"""
    CrossoverMethod

Abstract type for crossover methods.
"""
abstract type CrossoverMethod end

"""
    MutationMethod

Abstract type for mutation methods.
"""
abstract type MutationMethod end


"""
    Chromosome{T}

A chromosome consists of a vector of genes of type `T`.
"""
struct Chromosome{T}
    genes::Vector{T}
end

Base.length(c::Chromosome) = length(c.genes)
Base.iterate(c::Chromosome) = iterate(c.genes)
Base.iterate(c::Chromosome, state) = iterate(c.genes, state)


"""
    Population{T}

A population consists of a vector of chromosomes of type `T`.
"""
struct Population{T<:Chromosome}
    chromosomes::Vector{T}
end

export PopulationInitializationMethod, SelectionMethod, CrossoverMethod, MutationMethod, Population, Chromosome

end
module Types

abstract type PopulationInitializationMethod end
abstract type SelectionMethod end
abstract type CrossoverMethod end
abstract type MutationMethod end

abstract type Chromosome end

struct Float64Chromosome <: Chromosome
    genes::Vector{Float64}
end

struct IntegerChromosome <: Chromosome
    genes::Vector{Integer}
end

struct BoolChromosome <: Chromosome
    genes::Vector{Float64}
end

struct Population{T<:Chromosome}
    chromosomes::Vector{T}
end

export PopulationInitializationMethod, SelectionMethod, CrossoverMethod, MutationMethod, Population, Chromosome, Float64Chromosome, IntegerChromosome, BoolChromosome
end
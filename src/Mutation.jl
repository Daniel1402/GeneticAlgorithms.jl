module Mutation

using ..Types
using Distributions
using Population


abstract type MutationMethod end

"""
    Defines the mutation of genes of real values (currently only `Float64` and `Integer` types (including `Bool`))
    Mutation is applied for each gene on its own with probability `mutation_rate` with values from the uniform
    distribution in the interval `mutation_interval`.
"""
struct RealGeneMutation{T<:Real}<:MutationMethod
    mutation_rate::Float64
    mutation_interval::Tuple{T, T}

    function RealGeneMutation(mutation_rate::Float64, mutation_interval::Tuple{T, T}) where T <: Real
        if mutation_rate < 0 || mutation_rate > 1
            throw(ArgumentError("Mutation rate must be between 0 and 1"))
        end
        if mutation_interval[1] > mutation_interval[2]
            throw(ArgumentError("Mutation interval must be in the form (min, max)"))
        end
        if mutation_interval[1] == mutation_interval[2]
            throw(ArgumentError("Mutation interval must have a range"))
        end
        new{eltype(mutation_interval)}(mutation_rate, mutation_interval)
    end

end


"""
    Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.
"""
function (c::RealGeneMutation{T})(chromosome::Float64Chromosome)::Float64Chromosome where T<:Float64
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    random_additions = rand(Uniform(c.mutation_interval[1], c.mutation_interval[2]), size(chromosome.genes))
    return chromosome.genes .+ (mask .&& random_additions)
end

"""
    Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.
"""
function (c::RealGeneMutation{T})(chromosome::IntegerChromosome)::IntegerChromosome where T<:Integer
    if eltype(mutation_interval) != Integer
        throw(ArgumentError("Mutation interval must be of type Integer"))
    end
    mask = rand(Uniform(0,1), size(chromosome.genes)) .< c.mutation_rate
    random_additions = rand(range(c.mutation_interval[1], c.mutation_interval[2]), size(chromosome.genes))
    return chromosome.genes .+ (mask .&& random_additions)
end

"""
    Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.
"""
function (c::RealGeneMutation{T})(chromosome::BoolChromosome)::BoolChromosome where T<:Bool
    mask = rand(Uniform(0,1), size(chromosome.genes)) .< c.mutation_rate
    return chromosome.genes .⊻ mask # bitwise XOR
end

export RealGeneMutation
end
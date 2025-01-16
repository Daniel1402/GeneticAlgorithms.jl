module Mutation

using ..Types
using Distributions


"""
    Defines the mutation of genes of real values (currently only `Float64` and `Integer` types (including `Bool`))
    Mutation is applied for each gene on its own with probability `mutation_rate` with values from the uniform
    distribution in the interval `mutation_interval`.
"""
struct RealGeneMutation{T<:Real} <: MutationMethod
    mutation_rate::Float64
    mutation_interval::Tuple{T,T}

    function RealGeneMutation(mutation_rate::Float64, mutation_interval::Tuple{T,T}) where {T<:Real}
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
function (c::RealGeneMutation{T})(chromosome::Chromosome{T})::Chromosome{T} where {T<:Float64}
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    random_additions = rand(Uniform(c.mutation_interval[1], c.mutation_interval[2]), size(chromosome.genes))
    return Chromosome(chromosome.genes .+ (mask .&& random_additions))
end

"""
    Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.
"""
function (c::RealGeneMutation{T})(chromosome::Chromosome{T})::Chromosome{T} where {T<:Integer}
    if !all(c.mutation_interval[i] isa Integer for i in 1:2)
        throw(ArgumentError("Mutation interval must be of type Integer"))
    end
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    random_additions = rand(range(c.mutation_interval[1], c.mutation_interval[2]), size(chromosome.genes))
    return Chromosome(chromosome.genes .+ (mask .&& random_additions))
end

"""
    Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.
"""
function (c::RealGeneMutation{T})(chromosome::Chromosome{T})::Chromosome{T} where {T<:Bool}
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    a = [gene ⊻ m for (gene, m) in zip(chromosome.genes, mask)]
    return Chromosome(a) 
end

struct SudokuMutation <: MutationMethod
    mutation_rate::Float64
    initial::Vector{Vector{Int64}} #9x9 initial grid

    function SudokuMutation(mutation_rate::Float64)
        if mutation_rate < 0 || mutation_rate > 1
            throw(ArgumentError("Mutation rate must be between 0 and 1"))
        end
        new(mutation_rate, mutation_interval)
    end
end

function (c::SudokuMutation)(chromosome::Chromosome{Vector{Int64}})::Chromosome{Vector{Int64}}
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate

    chromosome = deepcopy(c.initial)
    for column in chromosome
        if mask[i]
            initial_values = Set(column)
            new_values = setdiff(values, initial_values, 0)
            new_values = collect(new_values)
            new_values = shuffle(new_values)
            for i in eachindex(column)
                if column[i] == 0
                    column[i] = pop!(new_values)
                end
            end
        end
    end
   
    return chromosome
end


export RealGeneMutation, SudokuMutation
end
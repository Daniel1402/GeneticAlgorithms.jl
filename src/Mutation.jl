module Mutation

using ..Types

struct RealGeneMutation{T<:Real}
    mutation_rate::Float64
    mutation_interval::Tuple{T, T}

    function RealGeneMutation(mutation_rate::Float64, mutation_interval::Tuple{T, T}) where T<:Real
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

function (c::RealGeneMutation)(genes::Vector{<:Real})::Vector{<:Real}
    """
    Mutates the genes with a probability of c.mutation_rate and values in the interval c.mutation_interval
    """
    return [gene + (rand() < c.mutation_rate ? rand(c.mutation_interval) : 0) for gene in genes]
end

export RealGeneMutation
end
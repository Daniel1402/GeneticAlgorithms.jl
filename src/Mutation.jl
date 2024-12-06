module Mutation

using ..Types

struct RealGeneMutation{T<:Real}
    mutation_rate::Float64 = 0.1
    mutation_interval::Tuple{T, T} = (-0.5, 0.5)

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
        new(mutation_rate, mutation_interval)
    end

end

function (c::RealGeneMutation)(genes::AbractVector{Real})::AbstractVector{Real}
    return [gene + (rand() < c.mutation_rate ? rand(c.mutation_interval) : 0) for gene in genes]
end

end
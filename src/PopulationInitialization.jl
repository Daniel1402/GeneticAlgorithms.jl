module PopulationInitialization

using Distributions
using ..Types

"""
    RealUniformInitialization(population_size::Int64, chromosome_size::Int64, interval::Tuple{T,T})

Creates a population of `population_size` including chromosomes of `chromosome_size`. 
The chromosome-values are drawn from a uniform distribution over `interval`. 
The current implementation supports `Float64` and `Integer` types. 
The type is determined by the `interval`.
"""
struct RealUniformInitialization{T<:Real} <: PopulationInitializationMethod
    population_size::Int64
    chromosome_size::Int64
    interval::Tuple{T,T}

    function RealUniformInitialization(population_size::Int64, chromosome_size::Int64, interval::Tuple{T,T}) where {T<:Real}
        if interval[1] >= interval[2]
            throw(ArgumentError("Upper bound must be greater than lower bound of the interval."))
        end
        if population_size <= 0
            throw(ArgumentError("Population size must be greater zero."))
        end
        if chromosome_size <= 0
            throw(ArgumentError("Chromosome size must be greater zero."))
        end
        new{eltype(interval)}(population_size, chromosome_size, interval)
    end
end

function (c::RealUniformInitialization{T})()::Population{Float64Chromosome} where {T<:Float64}
    return Population([Float64Chromosome(rand(Uniform(c.interval[1], c.interval[2]), c.chromosome_size)) for _ in 1:c.population_size])
end

function (c::RealUniformInitialization{T})()::Population{IntegerChromosome} where {T<:Integer}
    return Population([IntegerChromosome(rand((c.interval[1], c.interval[2]), c.chromosome_size)) for _ in 1:c.population_size])
end


export RealUniformInitialization

end
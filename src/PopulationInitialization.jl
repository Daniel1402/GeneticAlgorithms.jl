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
    intervals::Vector{Tuple{T, T}}

    function validate_inputs(population_size::Int64, chromosome_size::Int64, intervals::Vector{Tuple{T, T}}) where {T<:Real}
        if population_size <= 0
            throw(ArgumentError("Population size must be greater than zero."))
        end
        if chromosome_size <= 0
            throw(ArgumentError("Chromosome size must be greater than zero."))
        end
        if length(intervals) != chromosome_size
            throw(ArgumentError("Number of intervals must match the chromosome size."))
        end
        for interval in intervals
            if interval[1] >= interval[2]
                throw(ArgumentError("Upper bound must be greater than lower bound of the interval."))
            end
        end
    end

    function RealUniformInitialization(population_size::Int64, chromosome_size::Int64, interval::Tuple{T, T}) where {T<:Real}
        if interval[1] >= interval[2]
            throw(ArgumentError("Upper bound must be greater than lower bound of the interval."))
        end
        intervals = fill(interval, chromosome_size)
        validate_inputs(population_size, chromosome_size, intervals)
        new{T}(population_size, chromosome_size, intervals)
    end

    function RealUniformInitialization(population_size::Int64, chromosome_size::Int64, intervals::Vector{Tuple{T, T}}) where {T<:Real}
        validate_inputs(population_size, chromosome_size, intervals)
        new{T}(population_size, chromosome_size, intervals)
    end
end

function (c::RealUniformInitialization{T})()::Population{Chromosome{T}} where {T<:Float64}
    return Population([Chromosome([rand(Uniform(c.intervals[i][1], c.intervals[i][2])) for i in 1:c.chromosome_size]) for _ in 1:c.population_size])
end

function (c::RealUniformInitialization{T})()::Population{Chromosome{T}} where {T<:Integer}
    return Population([Chromosome([rand(c.intervals[i][1]:c.intervals[i][2]) for i in 1:c.chromosome_size]) for _ in 1:c.population_size])
end

export RealUniformInitialization

end

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
    intervals::Vector{Tuple{T,T}}

    function RealUniformInitialization(population_size::Int64, chromosome_size::Int64, intervals::Union{Tuple{T,T}, Vector{Tuple{T,T}}}) where {T<:Real}
        if typeof(intervals) <: Tuple
            intervals = fill(intervals, chromosome_size)
        elseif length(intervals) != chromosome_size
            throw(ArgumentError("Number of intervals must match the chromosome size."))
        end

        for interval in intervals
            if interval[1] >= interval[2]
                throw(ArgumentError("Upper bound must be greater than lower bound of the interval."))
            end
        end
        if population_size <= 0
            throw(ArgumentError("Population size must be greater than zero."))
        end
        if chromosome_size <= 0
            throw(ArgumentError("Chromosome size must be greater than zero."))
        end

        new{eltype(intervals[1])}(population_size, chromosome_size, intervals)
    end
end

function (c::RealUniformInitialization{T})()::Population{Float64Chromosome} where {T<:Float64}
    return Population([Float64Chromosome([rand(Uniform(c.intervals[i][1], c.intervals[i][2])) for i in 1:c.chromosome_size]) for _ in 1:c.population_size])
end

function (c::RealUniformInitialization{T})()::Population{IntegerChromosome} where {T<:Integer}
    return Population([IntegerChromosome([rand(c.intervals[i][1]:c.intervals[i][2]) for i in 1:c.chromosome_size]) for _ in 1:c.population_size])
end



export RealUniformInitialization

end
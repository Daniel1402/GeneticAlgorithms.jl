module PopulationInitialization

using Distributions

"""
    uniform(population_size, chromosome_size, interval)

Creates a population of `population_size` including chromosomes of `chromosome_size`. 
The chromosome-values are drawn from a uniform distribution over `interval`.
"""
function uniform(population_size::Int64, chromosome_size::Int64, interval=(0, 1))
    if interval[1] >= interval[2]
        throw(ArgumentError("Upper bound must be greater than lower bound of the interval."))
    end
    if population_size <= 0
        throw(ArgumentError("Population size must be greater zero."))
    end
    if chromosome_size <= 0
        throw(ArgumentError("Chromosome size must be greater zero."))
    end

    return rand(Uniform(interval[1], interval[2]), (population_size, chromosome_size))
end

export uniform

end
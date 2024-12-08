module PopulationInitialization

using Types
using Distributions
function uniform(population_size::Int64, chromosome_size::Int64, interval=(0, 1))
    if interval[0] >= interval[1]
        throw(ArgumentError("Upper bound must be greater than lower bound of the interval."))
    end
    if population_size < 0
        throw(ArgumentError("Population size must be greater zero."))
    end
    if chromosome_size < 0
        throw(ArgumentError("Chromosome size must be greater zero."))
    end

    return rand(Uniform(interval[0], interval[1]), (population_size, chromosome_size))
end

end
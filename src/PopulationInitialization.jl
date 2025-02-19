"""
    RealUniformInitialization(population_size::Int64, chromosome_size::Int64, interval::Tuple{T,T})

    RealUniformInitialization(population_size::Int64, chromosome_size::Int64, intervals::Vector{Tuple{T,T}})

Creates a population of `population_size` including chromosomes of `chromosome_size`. 
The chromosome-values are drawn from a uniform distribution over `interval`.
In the second constructor, the `intervals` vector specifies the interval for each gene.
The current implementation supports `Float64` and `Integer` types. 
The type is determined by the `interval`.
The struct must be called to create a population.
"""
struct RealUniformInitialization{T<:Real} <: PopulationInitializationMethod
    population_size::Int64
    chromosome_size::Int64
    intervals::Vector{Tuple{T,T}}

    function validate_inputs(
        population_size::Int64,
        chromosome_size::Int64,
        intervals::Vector{Tuple{T,T}},
    ) where {T<:Real}
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
                throw(
                    ArgumentError(
                        "Upper bound must be greater than lower bound of the interval.",
                    ),
                )
            end
        end
    end

    function RealUniformInitialization(
        population_size::Int64,
        chromosome_size::Int64,
        interval::Tuple{T,T},
    ) where {T<:Real}
        if interval[1] >= interval[2]
            throw(
                ArgumentError(
                    "Upper bound must be greater than lower bound of the interval.",
                ),
            )
        end
        intervals = fill(interval, chromosome_size)
        validate_inputs(population_size, chromosome_size, intervals)
        new{T}(population_size, chromosome_size, intervals)
    end

    function RealUniformInitialization(
        population_size::Int64,
        chromosome_size::Int64,
        intervals::Vector{Tuple{T,T}},
    ) where {T<:Real}
        validate_inputs(population_size, chromosome_size, intervals)
        new{T}(population_size, chromosome_size, intervals)
    end
end

"""
    (c::RealUniformInitialization{T})()::Population{Chromosome{T}} where {T<:Float64}

Creates a population with Float genes.
"""
function (c::RealUniformInitialization{T})()::Population{Chromosome{T}} where {T<:Float64}
    return Population([
        Chromosome([
            rand(Uniform(c.intervals[i][1], c.intervals[i][2])) for i = 1:c.chromosome_size
        ]) for _ = 1:c.population_size
    ])
end

"""
    (c::RealUniformInitialization{T})()::Population{Chromosome{T}} where {T<:Integer}

Creates a population with Integer genes.
"""
function (c::RealUniformInitialization{T})()::Population{Chromosome{T}} where {T<:Integer}
    return Population([
        Chromosome([
            rand(c.intervals[i][1]:c.intervals[i][2]) for i = 1:c.chromosome_size
        ]) for _ = 1:c.population_size
    ])
end

"""
    SudokuInitialization(population_size::Int64, initial::Vector{Vector{Int64}})

Creates a population of `population_size` including chromosomes of `9x9` size. 
Each gene resembles a column in a Sudoku puzzle. The initial values are taken from the `initial` grid. 
`initial` must be of size 9x9.
The remaining values are filled with the missing random values. 
The initialization ensure that each column contains the values `1-9` exactly once.
"""
struct SudokuInitialization <: PopulationInitializationMethod
    population_size::Int64
    initial::Vector{Vector{Int64}} #9x9 initial grid

    function SudokuInitialization(population_size::Int64, initial::Vector{Vector{Int64}})
        if population_size <= 0
            throw(ArgumentError("Population size must be greater zero."))
        end
        if size(initial, 1) != 9 || ~all(size.(initial, 1) .== 9)
            throw(ArgumentError("Initial Sudoku grid must be 9x9"))
        end
        new(population_size, initial)
    end
end


"""
    (c::SudokuInitialization)()::Population{Chromosome{Vector{Int64}}}

The population is created by calling the `SudokuInitialization` object.
"""
function (c::SudokuInitialization)()::Population{Chromosome{Vector{Int64}}}
    function new_chromosome()
        values = Set(1:9)
        chromosome = deepcopy(c.initial)
        for column in chromosome
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
        return Chromosome(chromosome)
    end

    return Population([new_chromosome() for _ = 1:c.population_size])

end

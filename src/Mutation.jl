"""
    RealGeneMutation(mutation_rate::Float64, mutation_interval::Tuple{T,T})

Defines the mutation of genes of real values.

Currently only `Float64` and `Integer` types (including `Bool`) are supported.
Mutation is applied for each gene on its own with probability `mutation_rate`.
On mutation a value from the uniform distribution in the interval `mutation_interval` is drawn 
and added to the gene. Boolian genes are inverted. 
"""
struct RealGeneMutation{T<:Real} <: MutationMethod
    mutation_rate::Float64
    mutation_interval::Tuple{T,T}

    function RealGeneMutation(
        mutation_rate::Float64,
        mutation_interval::Tuple{T,T},
    ) where {T<:Real}
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
    (c::RealGeneMutation{T})(chromosome::Chromosome{T})::Chromosome{T} where {T<:Float64}

Applies the mutation to the given `chromosome` if the chromosome is of type `Float64`.
"""
function (c::RealGeneMutation{T})(
    chromosome::Chromosome{T},
)::Chromosome{T} where {T<:Float64}
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    random_additions = rand(
        Uniform(c.mutation_interval[1], c.mutation_interval[2]),
        size(chromosome.genes),
    )
    return Chromosome(chromosome.genes .+ (mask .&& random_additions))
end

"""
    (c::RealGeneMutation{T})(chromosome::Chromosome{T})::Chromosome{T} where {T<:Integer}

Applies the mutation to the given `chromosome` if the chromosome is of type `Integer`.
"""
function (c::RealGeneMutation{T})(
    chromosome::Chromosome{T},
)::Chromosome{T} where {T<:Integer}
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    random_additions =
        rand(range(c.mutation_interval[1], c.mutation_interval[2]), size(chromosome.genes))
    return Chromosome(chromosome.genes .+ (mask .&& random_additions))
end

"""
    (c::RealGeneMutation{T})(chromosome::Chromosome{T})::Chromosome{T} where {T<:Bool}

Applies the mutation to the given `chromosome` if the chromosome is of type `Bool`.
"""
function (c::RealGeneMutation{T})(chromosome::Chromosome{T})::Chromosome{T} where {T<:Bool}
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    a = [gene ⊻ m for (gene, m) in zip(chromosome.genes, mask)]
    return Chromosome(a)
end

"""
    SudokuMutation(mutation_rate::Float64, initial::Vector{Vector{Int64}})

Mutation method for Sudoku puzzles. 
    
The mutation is applied column-wise with probability `mutation_rate`.
`initial` contains the initial sudoku grid and must be of size 9x9.
The mutation ensures that the initial cells of `initial` are not changed and the remaining values are shuffled.
"""
struct SudokuMutation <: MutationMethod
    mutation_rate::Float64
    initial::Vector{Vector{Int64}} #9x9 initial grid

    function SudokuMutation(mutation_rate::Float64, initial::Vector{Vector{Int64}})
        if mutation_rate < 0 || mutation_rate > 1
            throw(ArgumentError("Mutation rate must be between 0 and 1"))
        end
        if size(initial, 1) != 9 || ~all(size.(initial, 1) .== 9)
            throw(ArgumentError("Initial Sudoku grid must be 9x9"))
        end
        new(mutation_rate, initial)
    end
end

"""
    (c::SudokuMutation)(chromosome::Chromosome{Vector{Int64}})::Chromosome{Vector{Int64}}

Applies the Sudoku mutation to the given `chromosome`.
"""
function (c::SudokuMutation)(
    chromosome::Chromosome{Vector{Int64}},
)::Chromosome{Vector{Int64}}
    mask = rand(Uniform(0, 1), size(chromosome.genes)) .< c.mutation_rate
    new_chromosome = deepcopy(chromosome)
    values = Set(1:9)
    for (i, column) in enumerate(c.initial)
        if mask[i]
            initial_values = Set(column)
            new_values = setdiff(values, initial_values, 0)
            new_values = collect(new_values)
            new_values = shuffle(new_values)
            for j in eachindex(column)
                if column[j] == 0
                    new_chromosome.genes[i][j] = pop!(new_values)
                end
            end
        end
    end

    return new_chromosome
end

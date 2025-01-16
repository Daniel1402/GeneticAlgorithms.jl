module Fitness

using ..Types

"""
    rosenbrock_fitness(values::Chromosome{Float64})::Float64

Calculates 100 divided by the Rosenbrock function value for a given vector.

# Arguments
- `chromosome`: A chromosome containing the genes to evaluate.

# Returns
- 100 divided by the Rosenbrock function value as a Float64.
"""
function rosenbrock_fitness(chromosome::Chromosome{Float64})::Float64
    genes = chromosome.genes
    m = length(genes)
    if m < 2
        throw(ArgumentError("Rosenbrock function requires at least two dimensions."))
    end

    result = sum(
        100 * (genes[i+1] - genes[i]^2)^2 + (1 - genes[i])^2
        for i in 1:m-1
    )
    # negative to maximize the function
    return 100 / (result + 1)
end

function sudoku_fitness(chromosome::Chromosome{Vector{Int64}})::Float64
    fitness = 0
    # Transpose the chromosome to get the columns
    sudoku_matrix = reduce(hcat, chromosome.genes)
    transposed_sudoku = sudoku_matrix'
    for row in transposed_sudoku
        fitness += length(Set(row))
    end

    for i in 1:3:9
        for j in 1:3:9
            fitness += length(Set(sudoku_matrix[i:i+2, j:j+2]))
        end
    end

end

export rosenbrock_fitness, sumFitness

end
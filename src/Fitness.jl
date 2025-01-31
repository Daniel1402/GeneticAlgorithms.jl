
"""
    rosenbrock_fitness(chromosome::Chromosome{Float64})::Float64

Calculates the fitness of the `chromosome` regarding the Rosenbrock function.

The Rosenbrock function gets the genes of the chromosome as input. The result of the function 
is transformed to a fitness value by dividing 100 by the result plus 1. 
Throws an `ArgumentError` if the number of genes is less than 2.
"""
function rosenbrock_fitness(chromosome::Chromosome{Float64})::Float64
    genes = chromosome.genes
    m = length(genes)
    if m < 2
        throw(ArgumentError("Rosenbrock function requires at least two dimensions."))
    end

    result = sum(100 * (genes[i+1] - genes[i]^2)^2 + (1 - genes[i])^2 for i = 1:m-1)
    # negative to maximize the function
    return 100 / (result + 1)
end

"""
    sudoku_fitness(chromosome::Chromosome{Vector{Int64}})::Float64

Calculates the fitness of a Sudoku puzzle represented by the `chromosome`.

The fitness value is the sum of the number of distinct values in each row and each 3x3 subgrid.
This results in a maximal fitness value of 162. 
The function expects a chromosome with 9 genes, each representing a row in the Sudoku puzzle.
The genes are expected to have no duplicates and values between 1 and 9.
"""
function sudoku_fitness(chromosome::Chromosome{Vector{Int64}})::Float64
    fitness = 0
    sudoku_matrix = reduce(hcat, chromosome.genes)
    for row in eachrow(sudoku_matrix)
        fitness += length(Set(row))
    end

    for i = 1:3:9
        for j = 1:3:9
            fitness += length(Set(sudoku_matrix[i:i+2, j:j+2]))
        end
    end
    return fitness
end

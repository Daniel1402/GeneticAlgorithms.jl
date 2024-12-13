module GeneticAlgorithms

include("PopulationInitialization.jl")
include("Types.jl")
include("Population.jl")
include("Selection.jl")
include("Crossover.jl")
include("Mutation.jl")
include("Fitness.jl")
include("Utils.jl")

using .Types

struct GeneticAlgorithm
    initialization_strategy::Function #InitializationStrategy
    fitness_function::Function
    max_generations::Int
    selection_strategy::Function
    crossover_method::Function
    mutation_method::Mutation.RealGeneMutation
    mutation_rate::Float64
    elitism::Bool

    GeneticAlgorithm(
        initialization_strategy::Function, #InitializationStrategy, 
        fitness_function::Function, 
        selection_strategy::Function, 
        crossover_method::Function, 
        mutation_method::Mutation.RealGeneMutation,
        
        elitism::Bool=true,
        max_generations::Int=5,
        mutation_rate::Float64=0.1, 
    ) = new(initialization_strategy, fitness_function, max_generations, selection_strategy, crossover_method, mutation_method, mutation_rate, elitism)
end


function optimize(
    genetic_algorithm::GeneticAlgorithm
)
    population = initialize_population(genetic_algorithm.initialization_strategy)

    fitness_scores = [evaluate_fitness(individual, genetic_algorithm.fitness_function) for individual in eachrow(population)]
    
    for generation in 1:genetic_algorithm.max_generations
        # Sort population by fitness
        sorted_population = sortperm(fitness_scores, by=fitness_score-> -fitness_score)
        population = population[sorted_population, :]
        fitness_scores = fitness_scores[sorted_population]

        println("Generation $generation | Best Fitness: $(fitness_scores[1])")

        # Elitism (Use the best individual for next generation)
        new_population = genetic_algorithm.elitism ? [population[1, :]] : []
        @info new_population
        # Generate new generation
        while length(new_population) < length(population)
            parent1, parent2 = select(genetic_algorithm.selection_strategy, population, fitness_scores)
            offspring1, offspring2 = crossover(genetic_algorithm.crossover_method, parent1, parent2)

            if rand() < genetic_algorithm.mutation_rate
                offspring1 = mutate(genetic_algorithm.mutation_method, offspring1)
            end
            if rand() < genetic_algorithm.mutation_rate
                offspring2 = mutate(genetic_algorithm.mutation_method, offspring2)
            end


            push!(new_population, offspring1)
            push!(new_population, offspring2)
        end

        new_population = new_population[1:length(population)] # Trim excess individuals
        population = new_population

        # Recalculate fitness scores for the new population
        fitness_scores = [evaluate_fitness(individual, genetic_algorithm.fitness_function) for individual in population]
    end

    return population[1]
end

function initialize_population(strategy::Function)
    return strategy(10, 5)
end

function select(strategy::Function, population::Matrix{T}, fitness_scores::Vector{Float64}) where T <: Number
    return strategy(population, fitness_scores)    
end

function crossover(method::Function, parent1::Vector{T}, parent2::Vector{T}) where T <: Number
    return method(parent1, parent2)
end

function mutate(method::Mutation.RealGeneMutation, genes::Vector{T}) where T <: Number
    return method(genes)
end

function evaluate_fitness(individual::Union{Vector{T}, SubArray{T, 1, Matrix{T}}}, fitness_function::Function) where T <: Number
    individual_vector = Vector{T}(individual)
    return fitness_function(individual_vector)
end


export optimize, Crossover, PopulationInitialization, Selection, GeneticAlgorithm
end
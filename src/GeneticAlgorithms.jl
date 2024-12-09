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
    selection_strategy::SelectionStrategy
    crossover_method::CrossoverMethod
    mutation_method::MutationMethod
    mutation_rate::Float64
    elitism::Bool

    GeneticAlgorithm(
        initialization_strategy::Function, #InitializationStrategy, 
        fitness_function::Function, 
        selection_strategy::SelectionStrategy, 
        crossover_method::CrossoverMethod, 
        mutation_method::MutationMethod,
        
        elitism::Bool=true,
        max_generations::Int=5,
        mutation_rate::Float64=0.1, 
    ) = new(initialization_strategy, fitness_function, max_generations, selection_strategy, crossover_method, mutation_method, mutation_rate, elitism)
end


function optimize(
    genetic_algorithm::GeneticAlgorithm
)
    population = initialize_population(genetic_algorithm.initialization_strategy)

    fitness_scores = [evaluate_fitness(individual, genetic_algorithm.fitness_function) for individual in population]
    
    for generation in 1:genetic_algorithm.max_generations
        # Sort population by fitness
        sorted_population = sortperm(fitness_scores, by=i -> -fitness_scores[i])
        population = population[sorted_population]
        fitness_scores = fitness_scores[sorted_population]

        println("Generation $generation | Best Fitness: $(fitness_scores[1])")

        # Elitism (Use the best individual for next generation)
        new_population = elitism ? [population[1]] : []

        # Generate new generation
        while length(new_population) < length(population)
            parent1, parent2 = select(genetic_algorithm.selection_strategy, population, fitness_scores)
            offspring1, offspring2 = crossover(genetic_algorithm.crossover_method, parent1, parent2)

            if rand() < mutation_rate
                offspring1 = mutate(genetic_algorithm.mutation_method, offspring1)
            end
            if rand() < mutation_rate
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


export optimize, Crossover, PopulationInitialization, Selection
end
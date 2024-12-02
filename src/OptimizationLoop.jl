module OptimizationLoop

using ..Population
using ..Selection
using ..Crossover
using ..Mutation
using ..Fitness

function optimize(
    population::Vector{<:Genotype}, 
    fitness_function::Function, 
    max_generations::Int; 
    selection_strategy::SelectionStrategy, 
    crossover_method::CrossoverMethod, 
    mutation_method::MutationMethod, 
    mutation_rate::Float64=0.1, 
    elitism::Bool=true
)
    fitness_scores = [evaluate_fitness(individual, fitness_function) for individual in population]
    
    for generation in 1:max_generations
        # Sort population by fitness
        sorted_population = sortperm(fitness_scores, by=i -> -fitness_scores[i])
        population = population[sorted_population]
        fitness_scores = fitness_scores[sorted_population]

        println("Generation $generation | Best Fitness: $(fitness_scores[1])")

        # Elitism (Use the best individual for next generation)
        new_population = elitism ? [population[1]] : []

        # Generate new generation
        while length(new_population) < length(population)
            parent1, parent2 = select(selection_strategy, population, fitness_scores)
            offspring1, offspring2 = crossover(crossover_method, parent1, parent2)

            if rand() < mutation_rate
                offspring1 = mutate(mutation_method, offspring1)
            end
            if rand() < mutation_rate
                offspring2 = mutate(mutation_method, offspring2)
            end

            push!(new_population, offspring1)
            push!(new_population, offspring2)
        end

        new_population = new_population[1:length(population)] # Trim excess individuals
        population = new_population

        # Recalculate fitness scores for the new population
        fitness_scores = [evaluate_fitness(individual, fitness_function) for individual in population]
    end

    return population[1]
end

end
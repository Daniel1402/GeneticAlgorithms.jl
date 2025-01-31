
"""
    GeneticAlgorithm(
        initialization_strategy::P,
        fitness_function::Function,
        selection_strategy::S,
        crossover_method::C,
        mutation_method::M;
        elitism::Bool=true,
        verbose::Bool=false,
        max_generations::Int=5,
        mutation_rate::Float64=0.1,
        save_best::Bool=false,
    ) where {P<:PopulationInitializationMethod,S<:SelectionMethod,C<:CrossoverMethod,M<:MutationMethod}

Defines a genetic algorithm with the specified parameters for selection, mutation, crossover and fitness evaluation.

# Arguments
- `initialization_strategy::P`: Strategy to initialize the population.
- `fitness_function::Function`: Function to calculate the fitness of each chromosome.
- `selection_strategy::S`: Strategy to select parents for crossover.
- `crossover_method::C`: Method to generate offspring from selected parents.
- `mutation_method::M`: Method to mutate the offspring.
- `elitism::Bool=true`: If true, the best individual from the previous generation is carried over to the next generation.
- `verbose::Bool=false`: If true, additional information is printed during the execution.
- `max_generations::Int=5`: Number of generations the algorithm runs for.
- `mutation_rate::Float64=0.1`: Probability of mutation for each offspring in a generation.
- `save_best::Bool=false`: If true, the best chromosomes and their fitness scores are saved for visualization.

# Fields
- `initialization_strategy::P`: Strategy to initialize the population.
- `fitness_function::Function`: Function to calculate the fitness of each chromosome.
- `max_generations::Int`: Number of generations the algorithm runs for.
- `selection_strategy::S`: Strategy to select parents for crossover.
- `crossover_method::C`: Method to generate offspring from selected parents.
- `mutation_method::M`: Method to mutate the offspring.
- `mutation_rate::Float64`: Probability of mutation.
- `elitism::Bool`: If true, the best individual from the previous generation is carried over to the next generation.
- `verbose::Bool`: If true, additional information is printed during the execution.
- `save_best::Bool`: If true, the best chromosomes and their fitness scores are saved for visualization.
- `best_chromosomes::Vector{Chromosome}`: Stores the best chromosomes for each generation.
- `best_fitness::Vector{Float64}`: Stores the fitness scores of the best chromosomes for each generation.

Note that the `best_chromosomes` and `best_fitness` fields store `max_generations + 1` values, including the initial population.
"""
struct GeneticAlgorithm{
    P<:PopulationInitializationMethod,
    S<:SelectionMethod,
    C<:CrossoverMethod,
    M<:MutationMethod,
}
    initialization_strategy::P
    fitness_function::Function
    max_generations::Int
    selection_strategy::S
    crossover_method::C
    mutation_method::M
    mutation_rate::Float64
    elitism::Bool
    verbose::Bool
    save_best::Bool
    best_chromosomes::Vector{Chromosome}
    best_fitness::Vector{Float64}

    GeneticAlgorithm(
        initialization_strategy::P,
        fitness_function::Function,
        selection_strategy::S,
        crossover_method::C,
        mutation_method::M;
        elitism::Bool = true,
        verbose::Bool = false,
        max_generations::Int = typemax(Int),
        mutation_rate::Float64 = 0.1,
        save_best::Bool = false,
        max_no_improvement::Int=typemax(Int),
        target_fitness::Float64=typemax(Float64),
    ) where {
        P<:PopulationInitializationMethod,
        S<:SelectionMethod,
        C<:CrossoverMethod,
        M<:MutationMethod,
    } = new{P,S,C,M}(
        initialization_strategy,
        fitness_function,
        max_generations,
        selection_strategy,
        crossover_method,
        mutation_method,
        mutation_rate,
        elitism,
        verbose,
        save_best,
        max_no_improvement,
        target_fitness,
        Vector{Chromosome}(),
        Vector{Float64}(),
    )
end

"""
    optimize(genetic_algorithm::GeneticAlgorithm)

Runs the genetic algorithm with the specified parameters and returns the best individual found.

"""
function optimize(genetic_algorithm::GeneticAlgorithm)::Chromosome
    population::Population =
        initialize_population(genetic_algorithm.initialization_strategy)

    fitness_scores = [
        evaluate_fitness(individual, genetic_algorithm.fitness_function) for
        individual in population.chromosomes
    ]

    no_improvement_count = 0
    best_fitness_so_far = -Inf

    for generation = 1:genetic_algorithm.max_generations
        # Sort population by fitness
        sorted_population = sortperm(fitness_scores, by = fitness_score -> -fitness_score)
        population = Population(population.chromosomes[sorted_population])
        fitness_scores = fitness_scores[sorted_population]

        # Stop if target fitness is reached
        if fitness_scores[1] >= genetic_algorithm.target_fitness
            @info "Target fitness reached in generation $generation."
            break
        end

        # Stop if population has converged
        if fitness_scores[1] == best_fitness_so_far
            no_improvement_count += 1
        else
            no_improvement_count = 0
        end
        
        best_fitness_so_far = fitness_scores[1]

        if no_improvement_count >= genetic_algorithm.max_no_improvement
            @info "No improvement for $genetic_algorithm.max_no_improvement generations. Stopping."
            break
        end

        if genetic_algorithm.verbose
            @info "Generation $generation | Best Fitness: $(fitness_scores[1])"
        end

        # Elitism (Use the best individual for next generation)
        new_population = genetic_algorithm.elitism ? [population.chromosomes[1]] : []

        # Generate new generation
        while length(new_population) < length(population.chromosomes)
            parent1, parent2 =
                select(genetic_algorithm.selection_strategy, population, fitness_scores)
            offspring1, offspring2 =
                crossover(genetic_algorithm.crossover_method, parent1, parent2)

            if rand() < genetic_algorithm.mutation_rate
                offspring1 = mutate(genetic_algorithm.mutation_method, offspring1)
            end
            if rand() < genetic_algorithm.mutation_rate
                offspring2 = mutate(genetic_algorithm.mutation_method, offspring2)
            end

            push!(new_population, offspring1)
            push!(new_population, offspring2)
        end
        new_population = new_population[1:length(population.chromosomes)] # Trim excess individuals
        population = Population(new_population)

        # Recalculate fitness scores for the new population
        fitness_scores = [
            evaluate_fitness(individual, genetic_algorithm.fitness_function) for
            individual in population.chromosomes
        ]

        # Add best Chromosome for visualization
        if genetic_algorithm.save_best
            push!(genetic_algorithm.best_chromosomes, population.chromosomes[1])
            push!(genetic_algorithm.best_fitness, fitness_scores[1])
        end
    end

    # Final sort of the population
    sorted_population = sortperm(fitness_scores, by = fitness_score -> -fitness_score)
    population = Population(population.chromosomes[sorted_population])
    fitness_scores = fitness_scores[sorted_population]

    if genetic_algorithm.save_best
        push!(genetic_algorithm.best_chromosomes, population.chromosomes[1])
        push!(genetic_algorithm.best_fitness, fitness_scores[1])
    end
    return population.chromosomes[1]
end

function initialize_population(strategy::P) where {P<:PopulationInitializationMethod}
    return strategy()
end

function select(
    strategy::S,
    population::Population{T},
    fitness_scores::Vector{F},
) where {S<:SelectionMethod,T<:Chromosome,F<:Number}
    return strategy(population, fitness_scores)
end

function crossover(
    method::C,
    parent1::P,
    parent2::P,
) where {C<:CrossoverMethod,P<:Chromosome}
    return method(parent1, parent2)
end

function mutate(method::M, individual::P) where {M<:MutationMethod,P<:Chromosome}
    return method(individual)
end

function evaluate_fitness(individual::I, fitness_function::Function) where {I<:Chromosome}
    return fitness_function(individual)
end

module GeneticAlgorithms

include("Types.jl")
include("PopulationInitialization.jl")
include("Selection.jl")
include("Crossover.jl")
include("Mutation.jl")
include("Fitness.jl")
include("Utils.jl")

using .Types
using .Utils
using Plots

struct GeneticAlgorithm{P<:PopulationInitializationMethod,S<:SelectionMethod,C<:CrossoverMethod,M<:MutationMethod}
    initialization_strategy::P
    fitness_function::Function
    max_generations::Int
    selection_strategy::S
    crossover_method::C
    mutation_method::M
    mutation_rate::Float64
    elitism::Bool

    GeneticAlgorithm(
        initialization_strategy::P,
        fitness_function::Function,
        selection_strategy::S,
        crossover_method::C,
        mutation_method::M,
        elitism::Bool=true,
        max_generations::Int=5,
        mutation_rate::Float64=0.1,
    ) where {P<:PopulationInitializationMethod,S<:SelectionMethod,C<:CrossoverMethod,M<:MutationMethod} = new{P,S,C,M}(initialization_strategy, fitness_function, max_generations, selection_strategy, crossover_method, mutation_method, mutation_rate, elitism)
end


function optimize(
    genetic_algorithm::GeneticAlgorithm
)
    population::Population = initialize_population(genetic_algorithm.initialization_strategy)

    fitness_scores = [evaluate_fitness(individual, genetic_algorithm.fitness_function) for individual in population.chromosomes]

    for generation in 1:genetic_algorithm.max_generations
        # Sort population by fitness
        sorted_population = sortperm(fitness_scores, by=fitness_score -> -fitness_score)
        population = Population(population.chromosomes[sorted_population])
        fitness_scores = fitness_scores[sorted_population]

        println("Generation $generation | Best Fitness: $(fitness_scores[1])")

        println("Best Individual: $(population.chromosomes[1].genes)")
        # Elitism (Use the best individual for next generation)
        new_population = genetic_algorithm.elitism ? [population.chromosomes[1]] : []
        # Generate new generation
        while length(new_population) < length(population.chromosomes)
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
        new_population = new_population[1:length(population.chromosomes)] # Trim excess individuals
        population = Population(new_population)

        # Recalculate fitness scores for the new population
        fitness_scores = [evaluate_fitness(individual, genetic_algorithm.fitness_function) for individual in population.chromosomes]
    end

    # Final sort of the population
    sorted_population = sortperm(fitness_scores, by=fitness_score -> -fitness_score)
    population = Population(population.chromosomes[sorted_population])

    # Visualize the result 
    # TODO support more than 2 dimensions
    f(x, y) = genetic_algorithm.fitness_function([x, y])
    points = [Tuple(population.chromosomes[1].genes[1:2])]
    plt = Utils.visualize_function_with_contours(f, x_range=(-2.0, 2.0), y_range=(-1.0, 3.0), points=points)
    savefig(plt, "result.png")

    return population.chromosomes[1]
end

function initialize_population(strategy::P) where {P<:PopulationInitializationMethod}
    return strategy()
end

function select(strategy::S, population::Population{T}, fitness_scores::Vector{F}) where {S<:SelectionMethod,T<:Chromosome,F<:Number}
    return strategy(population, fitness_scores)
end

function crossover(method::C, parent1::P, parent2::P) where {C<:CrossoverMethod,P<:Chromosome}
    return method(parent1, parent2)
end

function mutate(method::M, individual::P) where {M<:MutationMethod,P<:Chromosome}
    return method(individual)
end

function evaluate_fitness(individual::I, fitness_function::Function) where {I<:Chromosome}
    return fitness_function(individual.genes)
end


export optimize, Crossover, PopulationInitialization, Selection, GeneticAlgorithm
end
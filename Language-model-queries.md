## Q: Give a short introduction to the optimization process gentic algorithms. Explain each operator and the optimization loop in one sentence.

### A: Genetic Algorithms (GAs) are optimization methods inspired by natural evolution, where a population of solutions evolves toward better performance through selection, crossover, and mutation in iterative loops.

- **Selection**: Chooses the best-performing individuals (solutions) based on fitness to propagate their traits to the next generation.
- **Crossover (Recombination)**: Combines pairs of selected individuals to produce new offspring by mixing their features.
- **Mutation**: Introduces random changes in offspring to maintain diversity and explore new solutions.
- **Optimization Loop**: Repeats the process of selection, crossover, and mutation over multiple generations until a stopping criterion, such as convergence or a maximum iteration count, is met.

---

## Q: refactor the tests to apply to the new format of the SinglePointCrossover beeing a struct

```
using Test
using GeneticAlgorithms.Crossover

@testset "Crossover.jl" begin
chromosome1 = [1, 2, 3, 4, 5]
chromosome2 = [6, 7, 8, 9, 10]

    crossover = SinglePointCrossover()
    offspring1, offspring2 = crossover(chromosome1, chromosome2)

    flipped = false
    isValid = true

    for i in eachindex(offspring1)
        if offspring1[i] != chromosome1[i] && !flipped
            flipped = true
            @test offspring1[i] == chromosome2[i]
            @test offspring2[i] == chromosome1[i]
            continue
        end

        if flipped && offspring1[i] != chromosome2[i]
            isValid = false
            break
        end

        if flipped && offspring2[i] != chromosome1[i]
            isValid = false
            break
        end

        if !flipped && offspring1[i] != chromosome1[i]
            isValid = false
            break
        end

        if !flipped && offspring2[i] != chromosome2[i]
            isValid = false
            break
        end
    end

    @test isValid

end
```

### A: refactor the outcommented tests in style of the not outcommented tests above

```
population_initialization = RealUniformInitialization(20, 50, (-14.3, 18.2))
population = population_initialization()
@test length(population.chromosomes) == 20
@test all([length(population.chromosomes[i].genes) == 50 for i in 1:20])
@test all([all([chromosome.genes[i] <= 18.2 && chromosome.genes[i] >= -14.3 for i in 1:length(chromosome.genes)]) for chromosome in population.chromosomes])

    @test_throws ArgumentError RealUniformInitialization(0, 0, (0.0, 1.0))
    @test_throws ArgumentError RealUniformInitialization(-1, 0, (0.0, 1.0))
    @test_throws ArgumentError RealUniformInitialization(0, -1, (0.0, 1.0))
    @test_throws ArgumentError RealUniformInitialization(3, 1, (2, 1))
    @test_throws ArgumentError RealUniformInitialization(3, 1, (1, 1))
```

## Q: Rewrite the docstring of the GenetricAlgorithms struct to contain a list of arguments
Whith having 
```
"""
    GeneticAlgorithm

Defines a genetic algorithm with the specified parameters. 
The population is initialized with the `initialization_strategy` and the fitness 
of each chromosome is calculated with the `fitness_function`. The algorithm runs
for `max_generations` generations. The `selection_strategy` is used to select
parents for the crossover. The `crossover_method` is used to generate offspring
from the selected parents. The `mutation_method` is used to mutate the offspring.
The `mutation_rate` is the probability of mutation. If `elitism` is true, the best
individual from the previous generation is carried over to the next generation.
If `save_best` is true, the best chromosomes and their fitness scores are saved
in the `best_chromosomes` and `best_fitness` fields respectively for e.G. visualization.
Note that the `best_chromosomes` and `best_fitness` fields store `max_generations + 1`
values, including the initial population.
"""
struct GeneticAlgorithm{P<:PopulationInitializationMethod,S<:SelectionMethod,C<:CrossoverMethod,M<:MutationMethod}
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
        elitism::Bool=true,
        verbose::Bool=false,
        max_generations::Int=5,
        mutation_rate::Float64=0.1,
        save_best::Bool=false,
    ) where {P<:PopulationInitializationMethod,S<:SelectionMethod,C<:CrossoverMethod,M<:MutationMethod} = new{P,S,C,M}(initialization_strategy, fitness_function, max_generations, selection_strategy, crossover_method, mutation_method, mutation_rate, elitism, verbose, save_best, Vector{Chromosome}(), Vector{Float64}())
end
```
marked in VSCode.

## A:
```
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

Defines a genetic algorithm with the specified parameters.

# Arguments
- `initialization_strategy::P`: Strategy to initialize the population.
- `fitness_function::Function`: Function to calculate the fitness of each chromosome.
- `selection_strategy::S`: Strategy to select parents for crossover.
- `crossover_method::C`: Method to generate offspring from selected parents.
- `mutation_method::M`: Method to mutate the offspring.
- `elitism::Bool=true`: If true, the best individual from the previous generation is carried over to the next generation.
- `verbose::Bool=false`: If true, additional information is printed during the execution.
- `max_generations::Int=5`: Number of generations the algorithm runs for.
- `mutation_rate::Float64=0.1`: Probability of mutation.
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
```

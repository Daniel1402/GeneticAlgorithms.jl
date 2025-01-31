var documenterSearchIndex = {"docs":
[{"location":"types/","page":"Types","title":"Types","text":"Modules = [GeneticAlgorithms]\nPages = [\"Types.jl\"]","category":"page"},{"location":"types/#GeneticAlgorithms.Chromosome","page":"Types","title":"GeneticAlgorithms.Chromosome","text":"Chromosome(genes::Vector{T})\n\nA chromosome consists of a vector of genes of type T.\n\n\n\n\n\n","category":"type"},{"location":"types/#GeneticAlgorithms.CrossoverMethod","page":"Types","title":"GeneticAlgorithms.CrossoverMethod","text":"CrossoverMethod\n\nAbstract type for crossover methods.\n\n\n\n\n\n","category":"type"},{"location":"types/#GeneticAlgorithms.MutationMethod","page":"Types","title":"GeneticAlgorithms.MutationMethod","text":"MutationMethod\n\nAbstract type for mutation methods.\n\n\n\n\n\n","category":"type"},{"location":"types/#GeneticAlgorithms.Population","page":"Types","title":"GeneticAlgorithms.Population","text":"Population(chromosomes::Vector{T})\n\nA population consists of a vector of chromosomes of type T.\n\n\n\n\n\n","category":"type"},{"location":"types/#GeneticAlgorithms.PopulationInitializationMethod","page":"Types","title":"GeneticAlgorithms.PopulationInitializationMethod","text":"PopulationInitializationMethod\n\nAbstract type for population initialization methods.\n\n\n\n\n\n","category":"type"},{"location":"types/#GeneticAlgorithms.SelectionMethod","page":"Types","title":"GeneticAlgorithms.SelectionMethod","text":"SelectionMethod\n\nAbstract type for selection methods.\n\n\n\n\n\n","category":"type"},{"location":"selection/","page":"Selection","title":"Selection","text":"Modules = [GeneticAlgorithms]\nPages = [\"Selection.jl\"]","category":"page"},{"location":"selection/#GeneticAlgorithms.RouletteWheelSelection-Union{Tuple{T}, Tuple{Population{T}, Vector{Float64}}, Tuple{Population{T}, Vector{Float64}, Function}} where T<:Chromosome","page":"Selection","title":"GeneticAlgorithms.RouletteWheelSelection","text":"RouletteWheelSelection(population::Population, fitness_scores::Vector{Float64}, rand_generator::Function=rand) -> Tuple{T,T}\n\nPerforms Roulette Wheel Selection on a population based on fitness scores, returning two selected individuals (parents).\n\nSelection is based on the cumulative probabilities of the fitness scores.\n\nArguments\n\npopulation::Population: The population of chromosomes from which to select.\nfitness_scores::Vector{Float64}: A vector of fitness scores corresponding to the population.\nrand_generator::Function=rand: A function to generate random numbers, default is rand.\n\nReturn\n\nTuple{T,T}: A tuple containing two selected chromosomes (parents).\n\n\n\n\n\n","category":"method"},{"location":"optimization/#Optimizing-Genetic-Algorithms","page":"Optimization","title":"Optimizing Genetic Algorithms","text":"","category":"section"},{"location":"optimization/","page":"Optimization","title":"Optimization","text":"The GeneticAlgorithm struct is the Core of the module.","category":"page"},{"location":"optimization/","page":"Optimization","title":"Optimization","text":"Modules = [GeneticAlgorithms]\nPages = [\"Optimization.jl\"]","category":"page"},{"location":"optimization/#GeneticAlgorithms.GeneticAlgorithm","page":"Optimization","title":"GeneticAlgorithms.GeneticAlgorithm","text":"GeneticAlgorithm(\n    initialization_strategy::P,\n    fitness_function::Function,\n    selection_strategy::S,\n    crossover_method::C,\n    mutation_method::M;\n    elitism::Bool=true,\n    verbose::Bool=false,\n    max_generations::Int=5,\n    mutation_rate::Float64=0.1,\n    save_best::Bool=false,\n) where {P<:PopulationInitializationMethod,S<:SelectionMethod,C<:CrossoverMethod,M<:MutationMethod}\n\nDefines a genetic algorithm with the specified parameters for selection, mutation, crossover and fitness evaluation.\n\nArguments\n\ninitialization_strategy::P: Strategy to initialize the population.\nfitness_function::Function: Function to calculate the fitness of each chromosome.\nselection_strategy::S: Strategy to select parents for crossover.\ncrossover_method::C: Method to generate offspring from selected parents.\nmutation_method::M: Method to mutate the offspring.\nelitism::Bool=true: If true, the best individual from the previous generation is carried over to the next generation.\nverbose::Bool=false: If true, additional information is printed during the execution.\nmax_generations::Int=5: Number of generations the algorithm runs for.\nmutation_rate::Float64=0.1: Probability of mutation for each offspring in a generation.\nsave_best::Bool=false: If true, the best chromosomes and their fitness scores are saved for visualization.\n\nFields\n\ninitialization_strategy::P: Strategy to initialize the population.\nfitness_function::Function: Function to calculate the fitness of each chromosome.\nmax_generations::Int: Number of generations the algorithm runs for.\nselection_strategy::S: Strategy to select parents for crossover.\ncrossover_method::C: Method to generate offspring from selected parents.\nmutation_method::M: Method to mutate the offspring.\nmutation_rate::Float64: Probability of mutation.\nelitism::Bool: If true, the best individual from the previous generation is carried over to the next generation.\nverbose::Bool: If true, additional information is printed during the execution.\nsave_best::Bool: If true, the best chromosomes and their fitness scores are saved for visualization.\nbest_chromosomes::Vector{Chromosome}: Stores the best chromosomes for each generation.\nbest_fitness::Vector{Float64}: Stores the fitness scores of the best chromosomes for each generation.\n\nNote that the best_chromosomes and best_fitness fields store max_generations + 1 values, including the initial population.\n\n\n\n\n\n","category":"type"},{"location":"optimization/#GeneticAlgorithms.optimize-Tuple{GeneticAlgorithm}","page":"Optimization","title":"GeneticAlgorithms.optimize","text":"optimize(genetic_algorithm::GeneticAlgorithm)\n\nRuns the genetic algorithm with the specified parameters and returns the best individual found.\n\n\n\n\n\n","category":"method"},{"location":"fitness/","page":"Fitness","title":"Fitness","text":"Modules = [GeneticAlgorithms]\nPages = [\"Fitness.jl\"]","category":"page"},{"location":"fitness/#GeneticAlgorithms.rosenbrock_fitness-Tuple{Chromosome{Float64}}","page":"Fitness","title":"GeneticAlgorithms.rosenbrock_fitness","text":"rosenbrock_fitness(values::Chromosome{Float64})::Float64\n\nCalculates 100 divided by the Rosenbrock function value for a given vector.\n\nArguments\n\nchromosome: A chromosome containing the genes to evaluate.\n\nReturns\n\n100 divided by the Rosenbrock function value as a Float64.\n\n\n\n\n\n","category":"method"},{"location":"fitness/#GeneticAlgorithms.sudoku_fitness-Tuple{Chromosome{Vector{Int64}}}","page":"Fitness","title":"GeneticAlgorithms.sudoku_fitness","text":"sudoku_fitness(chromosome::Chromosome{Vector{Int64}})::Float64\n\nCalculates the fitness of a Sudoku puzzle represented by the chromosome`. The fitness value is the sum of the number of distinct values in each row and 3x3 subgrid.\n\n\n\n\n\n","category":"method"},{"location":"mutation/","page":"Mutation","title":"Mutation","text":"Modules = [GeneticAlgorithms]\nPages = [\"Mutation.jl\"]","category":"page"},{"location":"mutation/#GeneticAlgorithms.RealGeneMutation","page":"Mutation","title":"GeneticAlgorithms.RealGeneMutation","text":"RealGeneMutation(mutation_rate::Float64, mutation_interval::Tuple{T,T})\n\nDefines the mutation of genes of real values (currently only Float64 and Integer types (including Bool)) Mutation is applied for each gene on its own with probability mutation_rate with values from the uniform distribution in the interval mutation_interval.\n\n\n\n\n\n","category":"type"},{"location":"mutation/#GeneticAlgorithms.SudokuMutation","page":"Mutation","title":"GeneticAlgorithms.SudokuMutation","text":"SudokuMutation(mutation_rate::Float64, initial::Vector{Vector{Int64}})\n\nMutation method for Sudoku puzzles. The mutation is applied column-wise with probability mutation_rate. initial must be of size 9x9. Ensures that the initial values of initial are not changed and the remaining values are shuffled.\n\n\n\n\n\n","category":"type"},{"location":"crossover/","page":"Crossover","title":"Crossover","text":"Modules = [GeneticAlgorithms]\nPages = [\"Crossover.jl\"]","category":"page"},{"location":"crossover/#GeneticAlgorithms.SinglePointCrossover-Union{Tuple{C}, Tuple{C, C}} where C<:Chromosome","page":"Crossover","title":"GeneticAlgorithms.SinglePointCrossover","text":"SinglePointCrossover(parent1::C, parent2::C)::Tuple{C,C} where {C<:Chromosome}\n\nDefines the single point crossover method for two chromosomes. Returns two offspring chromosomes.\n\n\n\n\n\n","category":"method"},{"location":"visualization/","page":"Visualization","title":"Visualization","text":"Modules = [GeneticAlgorithms.Visualization]","category":"page"},{"location":"visualization/#GeneticAlgorithms.Visualization.print_sudoku-Tuple{Chromosome}","page":"Visualization","title":"GeneticAlgorithms.Visualization.print_sudoku","text":"print_sudoku(chromosome::Chromosome)\n\nPrints the Sudoku genes of the given chromosome.\n\nArguments\n\nchromosome::Chromosome: The chromosome to print.\n\nExample\n\n\n\n\n\n","category":"method"},{"location":"visualization/#GeneticAlgorithms.Visualization.visualize_function_with_contours-Tuple{Function}","page":"Visualization","title":"GeneticAlgorithms.Visualization.visualize_function_with_contours","text":"Plots a contour of a 2D function over the specified x and y ranges.\n\nArguments\n\nf::Function: The function to visualize.\nx_range: Range of x-values (default: (-2.0, 2.0)).\ny_range: Range of y-values (default: (-2.0, 2.0)).\npath: Optimization path points (default: []).\n\nReturns\n\nA contour plot of the function with optional highlighted points.\n\n\n\n\n\n","category":"method"},{"location":"visualization/#GeneticAlgorithms.Visualization.visualize_rosenbrock_results-Union{Tuple{Vector{T}}, Tuple{T}, Tuple{Vector{T}, String}} where T<:Chromosome","page":"Visualization","title":"GeneticAlgorithms.Visualization.visualize_rosenbrock_results","text":"visualize_rosenbrock_results(best_chromosomes::Vector{Chromosome}, save_path::String=\"result.png\")\n\nGenerates a visualization of the optimization process for the Rosenbrock fitness function with given best_chromosomes. The visualization is saved to the specified save_path.\n\nExample\n\njulia\nvisualize_results([Chromosome([0.0, 0.0]), Chromosome([0.5, 0.5]), Chromosome([1.0, 1.0])], \"rosenbrock_path.png\")\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = GeneticAlgorithms","category":"page"},{"location":"#GeneticAlgorithms","page":"Home","title":"GeneticAlgorithms","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for GeneticAlgorithms.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"population_initialization/","page":"Population Initialization","title":"Population Initialization","text":"Modules = [GeneticAlgorithms]\nPages = [\"PopulationInitialization.jl\"]","category":"page"},{"location":"population_initialization/#GeneticAlgorithms.RealUniformInitialization","page":"Population Initialization","title":"GeneticAlgorithms.RealUniformInitialization","text":"RealUniformInitialization(population_size::Int64, chromosome_size::Int64, interval::Tuple{T,T})\n\nCreates a population of population_size including chromosomes of chromosome_size.  The chromosome-values are drawn from a uniform distribution over interval.  The current implementation supports Float64 and Integer types.  The type is determined by the interval.\n\n\n\n\n\n","category":"type"},{"location":"population_initialization/#GeneticAlgorithms.SudokuInitialization","page":"Population Initialization","title":"GeneticAlgorithms.SudokuInitialization","text":"SudokuInitialization(population_size::Int64, initial::Vector{Vector{Int64}})\n\nCreates a population of population_size including chromosomes of 9x9 size.  Each gene resembles a column in a Sudoku puzzle. The initial values are taken from the initial grid.  initial must be of size 9x9. The remaining values are filled with the missing random values.  The initialization ensure that each column contains the values 1-9 exactly once.\n\n\n\n\n\n","category":"type"},{"location":"example/#Simple-Example-usage-for-solvig-the-Rosenbrock-Problem","page":"Getting Started","title":"Simple Example usage for solvig the Rosenbrock Problem","text":"","category":"section"},{"location":"example/","page":"Getting Started","title":"Getting Started","text":"using GeneticAlgorithms\n\nrouletteWheelSelection = RouletteWheelSelection()\nsinglePointCrossover = SinglePointCrossover()\ngeneMutation = RealGeneMutation(0.5, (-0.5, 0.5))\nuniform = RealUniformInitialization(1000, 2, (-1.0, 1.0))\nga_rosenbrock = GeneticAlgorithm(uniform, rosenbrock_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, elitism=true, max_generations=100, mutation_rate=0.5, save_best=true)\nprintln(optimize(ga_rosenbrock))","category":"page"},{"location":"example/#Visualizing-Results-Rosenbrock-Problem","page":"Getting Started","title":"Visualizing Results - Rosenbrock Problem","text":"","category":"section"},{"location":"example/","page":"Getting Started","title":"Getting Started","text":"## Preparation\nusing GeneticAlgorithms\n\nrouletteWheelSelection = RouletteWheelSelection()\nsinglePointCrossover = SinglePointCrossover()\ngeneMutation = RealGeneMutation(0.5, (-0.5, 0.5))\nuniform = RealUniformInitialization(10, 2, (-1.0, 1.0))\nga_rosenbrock = GeneticAlgorithm(uniform, rosenbrock_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, elitism=true, max_generations=100, mutation_rate=0.5, save_best=true)\noptimize(ga_rosenbrock)\n\n## Visualization\nusing GeneticAlgorithms.Visualization\nvisualize_rosenbrock_results(ga_rosenbrock.best_chromosomes, \"rbplot.svg\")","category":"page"},{"location":"example/","page":"Getting Started","title":"Getting Started","text":"(Image: )","category":"page"},{"location":"example/#Sudoku-Solver","page":"Getting Started","title":"Sudoku Solver","text":"","category":"section"},{"location":"example/","page":"Getting Started","title":"Getting Started","text":"using GeneticAlgorithms\nusing GeneticAlgorithms.Visualization\n\ninitial = [\n    [5, 3, 0, 0, 7, 0, 0, 0, 0],\n    [6, 0, 0, 1, 9, 5, 0, 0, 0],\n    [0, 9, 8, 0, 0, 0, 0, 6, 0],\n    [8, 0, 0, 0, 6, 0, 0, 0, 3],\n    [4, 0, 0, 8, 0, 3, 0, 0, 1],\n    [7, 0, 0, 0, 2, 0, 0, 0, 6],\n    [0, 6, 0, 0, 0, 0, 2, 8, 0],\n    [0, 0, 0, 4, 1, 9, 0, 0, 5],\n    [0, 0, 0, 0, 8, 0, 0, 7, 9]\n]\nprintln(\"Initial Sudoku State:\")\nprint_sudoku(Chromosome(initial))\ninitStrategy = SudokuInitialization(20, initial)\nrouletteWheelSelection = RouletteWheelSelection()\nsinglePointCrossover = SinglePointCrossover()\ngeneMutation = SudokuMutation(0.1, initial)\nfitness_fn = (genes) -> sum(abs.(genes))\nga = GeneticAlgorithm(initStrategy, sudoku_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, elitism=true, max_generations=1000, mutation_rate=0.4, save_best=true)\nchromosome = optimize(ga)\nprintln(\"Optimized Result:\")\nprint_sudoku(chromosome)","category":"page"}]
}

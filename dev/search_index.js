var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = GeneticAlgorithms","category":"page"},{"location":"#GeneticAlgorithms","page":"Home","title":"GeneticAlgorithms","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for GeneticAlgorithms.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [GeneticAlgorithms, GeneticAlgorithms.PopulationInitialization, GeneticAlgorithms.Selection, GeneticAlgorithms.Fitness, GeneticAlgorithms.Mutation, GeneticAlgorithms.Utils, GeneticAlgorithms.Crossover]","category":"page"},{"location":"#GeneticAlgorithms.GeneticAlgorithm","page":"Home","title":"GeneticAlgorithms.GeneticAlgorithm","text":"GeneticAlgorithm\n\nDefines a genetic algorithm with the specified parameters.  The population is initialized with the initialization_strategy and the fitness  of each chromosome is calculated with the fitness_function. The algorithm runs for max_generations generations. The selection_strategy is used to select parents for the crossover. The crossover_method is used to generate offspring from the selected parents. The mutation_method is used to mutate the offspring. The mutation_rate is the probability of mutation. If elitism is true, the best individual from the previous generation is carried over to the next generation. If save_best is true, the best chromosomes and their fitness scores are saved in the best_chromosomes and best_fitness fields respectively for e.G. visualization. Note that the best_chromosomes and best_fitness fields store max_generations + 1 values, including the initial population.\n\n\n\n\n\n","category":"type"},{"location":"#GeneticAlgorithms.optimize-Tuple{GeneticAlgorithm}","page":"Home","title":"GeneticAlgorithms.optimize","text":"optimize(genetic_algorithm::GeneticAlgorithm)\n\nRuns the genetic algorithm with the specified parameters and returns the best individual found.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.PopulationInitialization.RealUniformInitialization","page":"Home","title":"GeneticAlgorithms.PopulationInitialization.RealUniformInitialization","text":"RealUniformInitialization(population_size::Int64, chromosome_size::Int64, interval::Tuple{T,T})\n\nCreates a population of population_size including chromosomes of chromosome_size.  The chromosome-values are drawn from a uniform distribution over interval.  The current implementation supports Float64 and Integer types.  The type is determined by the interval.\n\n\n\n\n\n","category":"type"},{"location":"#GeneticAlgorithms.PopulationInitialization.SudokuInitialization","page":"Home","title":"GeneticAlgorithms.PopulationInitialization.SudokuInitialization","text":"SudokuInitialization(population_size::Int64, initial::Vector{Vector{Int64}})\n\nCreates a population of population_size including chromosomes of 9x9 size.  Each gene resembles a column in a Sudoku puzzle. The initial values are taken from the initial grid.  initial must be of size 9x9. The remaining values are filled with the missing random values.  The initialization ensure that each column contains the values 1-9 exactly once.\n\n\n\n\n\n","category":"type"},{"location":"#GeneticAlgorithms.Selection.RouletteWheelSelection-Union{Tuple{T}, Tuple{GeneticAlgorithms.Types.Population{T}, Vector{Float64}}, Tuple{GeneticAlgorithms.Types.Population{T}, Vector{Float64}, Function}} where T<:GeneticAlgorithms.Types.Chromosome","page":"Home","title":"GeneticAlgorithms.Selection.RouletteWheelSelection","text":"RouletteWheelSelection(population::Population, fitness_scores::Vector{Float64}, rand_generator::Function=rand)\n\nPerforms Roulette Wheel Selection on a population based on fitness scores, returning two selected individuals (parents).\n\nSelection is based on the cumulative probabilities of the fitness scores. \n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Fitness.rosenbrock_fitness-Tuple{GeneticAlgorithms.Types.Chromosome{Float64}}","page":"Home","title":"GeneticAlgorithms.Fitness.rosenbrock_fitness","text":"rosenbrock_fitness(values::Chromosome{Float64})::Float64\n\nCalculates 100 divided by the Rosenbrock function value for a given vector.\n\nArguments\n\nchromosome: A chromosome containing the genes to evaluate.\n\nReturns\n\n100 divided by the Rosenbrock function value as a Float64.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Fitness.sudoku_fitness-Tuple{GeneticAlgorithms.Types.Chromosome{Vector{Int64}}}","page":"Home","title":"GeneticAlgorithms.Fitness.sudoku_fitness","text":"sudoku_fitness(chromosome::Chromosome{Vector{Int64}})::Float64\n\nCalculates the fitness of a Sudoku puzzle represented by the chromosome`. The fitness value is the sum of the number of distinct values in each row and 3x3 subgrid.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Mutation.RealGeneMutation","page":"Home","title":"GeneticAlgorithms.Mutation.RealGeneMutation","text":"RealGeneMutation(mutation_rate::Float64, mutation_interval::Tuple{T,T})\n\nDefines the mutation of genes of real values (currently only Float64 and Integer types (including Bool)) Mutation is applied for each gene on its own with probability mutation_rate with values from the uniform distribution in the interval mutation_interval.\n\n\n\n\n\n","category":"type"},{"location":"#GeneticAlgorithms.Mutation.SudokuMutation","page":"Home","title":"GeneticAlgorithms.Mutation.SudokuMutation","text":"SudokuMutation(mutation_rate::Float64, initial::Vector{Vector{Int64}})\n\nMutation method for Sudoku puzzles. The mutation is applied column-wise with probability mutation_rate. initial must be of size 9x9. Ensures that the initial values of initial are not changed and the remaining values are shuffled.\n\n\n\n\n\n","category":"type"},{"location":"#GeneticAlgorithms.Utils.visualize_function_with_contours-Tuple{Function}","page":"Home","title":"GeneticAlgorithms.Utils.visualize_function_with_contours","text":"Plots a contour of a 2D function over the specified x and y ranges.\n\nArguments\n\nf::Function: The function to visualize.\nx_range: Range of x-values (default: (-2.0, 2.0)).\ny_range: Range of y-values (default: (-2.0, 2.0)).\npath: Optimization path points (default: []).\n\nReturns\n\nA contour plot of the function with optional highlighted points.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Utils.visualize_rosenbrock_results","page":"Home","title":"GeneticAlgorithms.Utils.visualize_rosenbrock_results","text":"visualize_rosenbrock_results(best_chromosomes::Vector{Chromosome{Float64}}, save_path::String=\"result.png\")\n\nGenerates a visualization of the optimization process for the rosenbrock fitness function with given best chromosomes.\n\nArguments\n\nbest_chromosomes: A sequence of optimization results (chromosomes) for visualizing the optimization path.\n\nExample\n\njulia\nvisualize_results([Chromosome([0.0, 0.0]), Chromosome([0.5, 0.5]), Chromosome([1.0, 1.0])], \"rosenbrock_path.png\")\n\n\n\n\n\n","category":"function"},{"location":"#GeneticAlgorithms.Crossover.SinglePointCrossover-Union{Tuple{C}, Tuple{C, C}} where C<:GeneticAlgorithms.Types.Chromosome","page":"Home","title":"GeneticAlgorithms.Crossover.SinglePointCrossover","text":"SinglePointCrossover(parent1::C, parent2::C)::Tuple{C,C} where {C<:Chromosome}\n\nDefines the single point crossover method for two chromosomes. Returns two offspring chromosomes.\n\n\n\n\n\n","category":"method"}]
}

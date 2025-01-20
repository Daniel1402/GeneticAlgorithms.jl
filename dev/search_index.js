var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = GeneticAlgorithms","category":"page"},{"location":"#GeneticAlgorithms","page":"Home","title":"GeneticAlgorithms","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for GeneticAlgorithms.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [GeneticAlgorithms, GeneticAlgorithms.PopulationInitialization, GeneticAlgorithms.Selection, GeneticAlgorithms.Fitness, GeneticAlgorithms.Mutation, GeneticAlgorithms.Utils, GeneticAlgorithms.Crossover]","category":"page"},{"location":"#GeneticAlgorithms.optimize-Tuple{GeneticAlgorithm}","page":"Home","title":"GeneticAlgorithms.optimize","text":"optimize(genetic_algorithm::GeneticAlgorithm)\n\nRuns the genetic algorithm with the specified parameters and returns the best individual found.\n\nIn this implementation, the function has the side effect of visualizing the Rosenbrock function and  the best solutions of each generation in \"result.png\". That's only a temporary solution and will be  replaced by a more flexible visualization method in the future.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.PopulationInitialization.RealUniformInitialization","page":"Home","title":"GeneticAlgorithms.PopulationInitialization.RealUniformInitialization","text":"RealUniformInitialization(population_size::Int64, chromosome_size::Int64, interval::Tuple{T,T})\n\nCreates a population of population_size including chromosomes of chromosome_size.  The chromosome-values are drawn from a uniform distribution over interval.  The current implementation supports Float64 and Integer types.  The type is determined by the interval.\n\n\n\n\n\n","category":"type"},{"location":"#GeneticAlgorithms.Selection.RouletteWheelSelection-Union{Tuple{T}, Tuple{GeneticAlgorithms.Types.Population{T}, Vector{Float64}}, Tuple{GeneticAlgorithms.Types.Population{T}, Vector{Float64}, Function}} where T<:GeneticAlgorithms.Types.Chromosome","page":"Home","title":"GeneticAlgorithms.Selection.RouletteWheelSelection","text":"Performs Roulette Wheel Selection on a population based on fitness scores, returning two selected individuals (parents).\n\nSelection is based on the cumulative probabilities of the fitness scores. \n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Fitness.rosenbrock_fitness-Tuple{GeneticAlgorithms.Types.Chromosome{Float64}}","page":"Home","title":"GeneticAlgorithms.Fitness.rosenbrock_fitness","text":"rosenbrock_fitness(values::Chromosome{Float64})::Float64\n\nCalculates 100 divided by the Rosenbrock function value for a given vector.\n\nArguments\n\nchromosome: A chromosome containing the genes to evaluate.\n\nReturns\n\n100 divided by the Rosenbrock function value as a Float64.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Mutation.RealGeneMutation","page":"Home","title":"GeneticAlgorithms.Mutation.RealGeneMutation","text":"Defines the mutation of genes of real values (currently only `Float64` and `Integer` types (including `Bool`))\nMutation is applied for each gene on its own with probability `mutation_rate` with values from the uniform\ndistribution in the interval `mutation_interval`.\n\n\n\n\n\n","category":"type"},{"location":"#GeneticAlgorithms.Mutation.RealGeneMutation-Union{Tuple{GeneticAlgorithms.Types.Chromosome{T}}, Tuple{T}} where T<:Bool","page":"Home","title":"GeneticAlgorithms.Mutation.RealGeneMutation","text":"Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Mutation.RealGeneMutation-Union{Tuple{GeneticAlgorithms.Types.Chromosome{T}}, Tuple{T}} where T<:Float64","page":"Home","title":"GeneticAlgorithms.Mutation.RealGeneMutation","text":"Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Mutation.RealGeneMutation-Union{Tuple{GeneticAlgorithms.Types.Chromosome{T}}, Tuple{T}} where T<:Integer","page":"Home","title":"GeneticAlgorithms.Mutation.RealGeneMutation","text":"Mutates the genes with a probability of c.mutation_rate and values in the interval `c.mutation_interval`.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Utils.visualize_function_with_contours-Tuple{Function}","page":"Home","title":"GeneticAlgorithms.Utils.visualize_function_with_contours","text":"Plots a contour of a 2D function over the specified x and y ranges.\n\nArguments\n\nf::Function: The function to visualize.\nx_range: Range of x-values (default: (-2.0, 2.0)).\ny_range: Range of y-values (default: (-2.0, 2.0)).\npath: Optimization path points (default: []).\n\nReturns\n\nA contour plot of the function with optional highlighted points.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Utils.visualize_results-Tuple{Function, Any}","page":"Home","title":"GeneticAlgorithms.Utils.visualize_results","text":"visualize_results(fitness_function, best_chromosomes)\n\nGenerates a visualization of the optimization process based on the provided fitness function and best chromosomes.\n\nArguments\n\nfitness_function::Function: The fitness function used.\nbest_chromosomes: A sequence of optimization results for visualizing the optimization path.\n\nExample\n\njulia\nvisualize_results(Fitness.rosenbrock_fitness, [(0.0, 0.0), (1.0, 1.0)])\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithms.Crossover.SinglePointCrossover","page":"Home","title":"GeneticAlgorithms.Crossover.SinglePointCrossover","text":"SinglePointCrossover\n\nDefines the single point crossover method for two chromosomes.\n\n\n\n\n\n","category":"type"}]
}

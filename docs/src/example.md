### Simple Example usage for solvig the Rosenbrock Problem

```@example 
using GeneticAlgorithms
using GeneticAlgorithms.Selection
using GeneticAlgorithms.Crossover
using GeneticAlgorithms.Mutation
using GeneticAlgorithms.Fitness
using GeneticAlgorithms.PopulationInitialization

rouletteWheelSelection = RouletteWheelSelection()
singlePointCrossover = SinglePointCrossover()
geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
uniform = RealUniformInitialization(1000, 2, (-1.0, 1.0))
ga_rosenbrock = GeneticAlgorithm(uniform, rosenbrock_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, elitism=true, max_generations=100, mutation_rate=0.5, save_best=true)
println(optimize(ga_rosenbrock))
```

### Visualizing Results - Rosenbrock Problem

```@example
## Preparation
using GeneticAlgorithms
using GeneticAlgorithms.Selection
using GeneticAlgorithms.Crossover
using GeneticAlgorithms.Mutation
using GeneticAlgorithms.Fitness
using GeneticAlgorithms.PopulationInitialization

rouletteWheelSelection = RouletteWheelSelection()
singlePointCrossover = SinglePointCrossover()
geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
uniform = RealUniformInitialization(10, 2, (-1.0, 1.0))
ga_rosenbrock = GeneticAlgorithm(uniform, rosenbrock_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, elitism=true, max_generations=100, mutation_rate=0.5, save_best=true)
optimize(ga_rosenbrock)

## Visualisation
using GeneticAlgorithms.Utils
visualize_rosenbrock_results(ga_rosenbrock.best_chromosomes, "rbplot.svg")
```

![](rbplot.svg)

### Sudoku Solver

```@example
using GeneticAlgorithms
using GeneticAlgorithms.Selection
using GeneticAlgorithms.Crossover
using GeneticAlgorithms.Mutation
using GeneticAlgorithms.Fitness
using GeneticAlgorithms.PopulationInitialization
using GeneticAlgorithms.Utils
using GeneticAlgorithms.Types

initial = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
]
println("Initial Sudoku State:")
print_sudoku(Chromosome(initial))
initStrategy = SudokuInitialization(20, initial)
rouletteWheelSelection = RouletteWheelSelection()
singlePointCrossover = SinglePointCrossover()
geneMutation = SudokuMutation(0.1, initial)
fitness_fn = (genes) -> sum(abs.(genes))
ga = GeneticAlgorithm(initStrategy, sudoku_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, elitism=true, max_generations=1000, mutation_rate=0.4, save_best=true)
chromosome = optimize(ga)
println("Optimized Result:")
print_sudoku(chromosome)
```
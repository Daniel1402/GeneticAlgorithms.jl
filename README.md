> [!NOTE]
> This project is part of the Julia for Machine Learning course at **Technical University Berlin**.
> The project is expected to be submitted on **31.01.2025**. After submission, it will **no longer be actively maintained or updated**.

# GeneticAlgorithms.jl 🧬

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Daniel1402.github.io/GeneticAlgorithms.jl/dev/)
[![Build Status](https://github.com/Daniel1402/GeneticAlgorithms.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Daniel1402/GeneticAlgorithms.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/Daniel1402/GeneticAlgorithms.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/Daniel1402/GeneticAlgorithms.jl)



**GeneticAlgorithms.jl** is a powerful and flexible library for solving optimization problems using **genetic algorithms** in Julia. This package provides efficient implementations of selection, crossover, mutation, and elitism to evolve solutions to complex problems.

> [!TIP]
> Check out our [**short introduction to genetic algorithms**](#a-short-introduction-to-genetic-algorithms) if you are new to genetic algorithms.

### Key Features

✅ Easy-to-use API for defining and running genetic algorithms <br>
✅ Examples for **Rosenbrock minimization** and **sudoku solving** <br>
✅ Built-in **selection** strategies: roulette wheel<br>
✅ Built-in **crossover** strategies: single point crossover<br>
✅ Built-in **mutation** strategies for real valued genes and Sudoku solving <br>
✅ **Visualization** submodule for visualizing the optimization of the Rosenbrock function and printing Sudokus

## Installation

You will need [Julia 1.10](https://julialang.org/downloads/).

```julia
julia> ]
(@v1.10) pkg> add https://github.com/Daniel1402/GeneticAlgorithms.jl
```

Quit the package manager prompt by pressing <kbd>Ctrl+C</kbd>.

```julia
julia> using GeneticAlgorithms
```
Now you are ready to optimize!



### Project Structure

Here is an overview of the project's main components:

- **`src/`**: Contains the core modules for the genetic algorithms:
  - `GeneticAlgorithms.jl`: Main entry point for the project.
  - `Selection.jl`: Methods for selecting individuals for reproduction.
  - `Crossover.jl`: Implements crossover techniques.
  - `Mutation.jl`: Handles mutation operations.
  - `PopulationInitialization.jl`: Functions to initialize the population.
  - `Fitness.jl`: Defines fitness evaluation methods.
  - `Types.jl`: Custom types used throughout the project.
  - `Utils.jl`: Utility functions, e.G. visualization

- **`test/`**: Unit tests for verifying the functionality of various components.
- **`docs/`**: Documentation files for understanding and extending the project.

### Running the Project

1. Follow the installation steps above

3. Use the provided functions to set up and run genetic algorithm experiments. For example:

   ```julia
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

### Visualizing Results

   ```julia
   using GeneticAlgorithms.Utils
   visualize_rosenbrock_results(ga_rosenbrock.best_chromosomes, "result.png")
   ```

### A Short Introduction to Genetic Algorithms

Genetic Algorithms (GAs) are optimization methods inspired by natural evolution, where a population of solutions evolves toward better performance through selection, crossover, and mutation in iterative loops.

- **Selection**: Chooses the best-performing individuals (solutions) based on fitness to propagate their traits to the next generation.  
- **Crossover (Recombination)**: Combines pairs of selected individuals to produce new offspring by mixing their features.  
- **Mutation**: Introduces random changes in offspring to maintain diversity and explore new solutions.  
- **Optimization Loop**: Repeats the process of selection, crossover, and mutation over multiple generations until a stopping criterion, such as convergence or a maximum iteration count, is met.  

# GeneticAlgorithms

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Daniel1402.github.io/GeneticAlgorithms.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Daniel1402.github.io/GeneticAlgorithms.jl/dev/)
[![Build Status](https://github.com/Daniel1402/GeneticAlgorithms.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Daniel1402/GeneticAlgorithms.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/Daniel1402/GeneticAlgorithms.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/Daniel1402/GeneticAlgorithms.jl)

This project is part of the Julia for Machine Learning course at Technical University Berlin.

## Getting Started with the Genetic Algorithms Project

### Prerequisites

- Git
- Julia and a package manager

### Installation

1. Clone the repository to your local machine and open a Julia REPL:

   ```bash
   git clone https://github.com/Daniel1402/GeneticAlgorithms.jl
   cd GeneticAlgorithms
   julia
   ```

2. In the Julia REPL, ensure that all required dependencies are installed and activate the environment:

   ```julia
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()
   ```

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
  - `Utils.jl`: Utility functions.

- **`test/`**: Unit tests for verifying the functionality of various components.
- **`docs/`**: Documentation files for understanding and extending the project.

### Running the Project

1. Open a Julia REPL and navigate to the project directory:

   ```bash
   cd GeneticAlgorithms
   julia
   ```

2. Activate the project environment and load the main module:

   ```julia
   using Pkg
   Pkg.activate(".")
   using GeneticAlgorithms
   ```

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
   ga_rosenbrock = GeneticAlgorithm(uniform, rosenbrock_fitness, rouletteWheelSelection, singlePointCrossover, geneMutation, true, 100, 0.5)
   println(optimize(ga_rosenbrock))
   ```

### Visualizing Results

The result is automatically visualized in result.png when running the optimzation loop. Additionally, you can visualize fitness functions manually by using `visualize_function_with_contours` provided in **`test/test_utils.jl`**.


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

## Key Features

✅ Easy-to-use API for defining and running genetic algorithms <br>
✅ Examples for **Rosenbrock minimization** and **sudoku solving** <br>
✅ Built-in **selection** strategies: roulette wheel<br>
✅ Built-in **crossover** strategies: single point crossover<br>
✅ Built-in **mutation** strategies for real valued genes and Sudoku solving <br>
✅ **Visualization** submodule for visualizing the optimization of the Rosenbrock function and printing Sudokus

## Installation

You will need **Julia v1.10**.

```julia
julia> ]
(@v1.10) pkg> add https://github.com/Daniel1402/GeneticAlgorithms.jl
```

Quit the package manager prompt by pressing <kbd>Ctrl+C</kbd>.

```julia
julia> using GeneticAlgorithms
```
Now you are ready to optimize!

## Getting Started

Check out our [getting started guide](https://daniel1402.github.io/GeneticAlgorithms.jl/dev/example/) for usage examples. For more details see the [documentation](https://Daniel1402.github.io/GeneticAlgorithms.jl/dev/).

## A Short Introduction to Genetic Algorithms

Genetic Algorithms (GAs) are optimization methods inspired by natural evolution, where a population of solutions evolves toward better performance through selection, crossover, and mutation in iterative loops.

- **Selection**: Chooses the best-performing individuals (solutions) based on fitness to propagate their traits to the next generation.  
- **Crossover (Recombination)**: Combines pairs of selected individuals to produce new offspring by mixing their features.  
- **Mutation**: Introduces random changes in offspring to maintain diversity and explore new solutions.  
- **Optimization Loop**: Repeats the process of selection, crossover, and mutation over multiple generations until a stopping criterion, such as convergence or a maximum iteration count, is met.  

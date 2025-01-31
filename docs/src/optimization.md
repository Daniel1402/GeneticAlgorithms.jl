### Optimizing Genetic Algorithms

To optimize solutions using a genetic algorithm, the struct `GeneticAlgorithm` is used to configure key parameters like initialization, selection, crossover, mutation and more. By passing it to the `optimize` method, the algorithm iterates through generations until a termination condition is met (currently only `max_generations` is implemented).

```@autodocs
Modules = [GeneticAlgorithms]
Pages = ["Optimization.jl"]
```
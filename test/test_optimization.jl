using Logging: with_logger

@testset "Simple and Rosenbrock GA" begin
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
    
    # Simple sum minimization GA
    sum_abs = (genes) -> sum(abs.(genes))
    uniform = RealUniformInitialization(10, 5, (-0.5, 0.5))
    
    ga_sum = GeneticAlgorithm(
        uniform,
        sum_abs,
        rouletteWheelSelection,
        singlePointCrossover,
        geneMutation,
    )

    optimize(ga)
    fitness_pre = ga_sum.best_fitness[1]
    
    for (i, fitness_score) in enumerate(i, ga_sum.best_fitness)
        @test fitness_score >= fitness_pre
        fitness_pre = fitness_score
        @test fitness_score ≈ sum_abs(ga_sum.best_chromosomes[i])
    end

    @test length(ga_sum.best_chromosomes) == 6 # 5  generations (default) + initial population
    @test length(ga_sum.best_fitness) == 6

    # Rosenbrock function minimization GA
    uniform = RealUniformInitialization(100, 2, (-2.0, 2.0))
    ga_rosenbrock = GeneticAlgorithm(
        uniform,
        rosenbrock_fitness,
        rouletteWheelSelection,
        singlePointCrossover,
        geneMutation,
        elitism = true,
        max_generations = 100,
        mutation_rate = 0.5,
        save_best = true,
    )
    optimize(ga_rosenbrock)
    
    fitness_pre = ga_rosenbrock.best_fitness[1]
    
    for (i, fitness_score) in enumerate(i, ga_rosenbrock.best_fitness)
        @test fitness_score >= fitness_pre
        fitness_pre = fitness_score
        @test fitness_score ≈ rosenbrock_fitness(ga_rosenbrock.best_chromosomes[i])
    end

    @test length(ga_rosenbrock.best_chromosomes) == 101 # 100 generations + initial population
    @test length(ga_rosenbrock.best_fitness) == 101
end


@testset "Sudoku GA" begin
    initial = [
        [5, 3, 0, 0, 7, 0, 0, 0, 0],
        [6, 0, 0, 1, 9, 5, 0, 0, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9],
    ]
    initStrategy = SudokuInitialization(20, initial)
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = SudokuMutation(0.1, initial)
    fitness_fn = (genes) -> sum(abs.(genes))
    ga_sudoku = GeneticAlgorithm(
        initStrategy,
        sudoku_fitness,
        rouletteWheelSelection,
        singlePointCrossover,
        geneMutation,
        elitism = true,
        max_generations = 1000,
        mutation_rate = 0.4,
        save_best = true,
    )

    fitness_pre = ga_sudoku.best_fitness[1]
    for (i, fitness_score) in enumerate(ga_sudoku.best_fitness)
        @test fitness_score >= fitness_pre
        fitness_pre = fitness_score
        @test fitness_score ≈ sudoku_fitness(ga_sudoku.best_chromosomes[i])
    end

    @test length(ga_sudoku.best_chromosomes) == 101 # 100 generations + initial population
    @test length(ga_sudoku.best_fitness) == 101
end

@testset "test verbose outputs anything" begin
    uniform = RealUniformInitialization(10, 5, (-0.5, 0.5))
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
    ga_rosenbrock = GeneticAlgorithm(
        uniform,
        rosenbrock_fitness,
        rouletteWheelSelection,
        singlePointCrossover,
        geneMutation,
        verbose = true,
        elitism = true,
        max_generations = 4,
        mutation_rate = 0.4,
    )
    test_logger = TestLogger()
    with_logger(test_logger) do
        optimize(ga_rosenbrock)
    end
    @test length(test_logger.logs) > 0
end

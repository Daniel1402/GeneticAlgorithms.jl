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
        save_best = true,
        max_generations = 5,
    )

    optimize(ga_sum)
    fitness_pre = ga_sum.best_fitness[1]
    
    for (i, fitness_score) in enumerate(ga_sum.best_fitness)
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
    
    for (i, fitness_score) in enumerate(ga_rosenbrock.best_fitness)
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

    optimize(ga_sudoku)

    fitness_pre = ga_sudoku.best_fitness[1]
    for (i, fitness_score) in enumerate(ga_sudoku.best_fitness)
        @test fitness_score >= fitness_pre
        fitness_pre = fitness_score
        @test fitness_score ≈ sudoku_fitness(ga_sudoku.best_chromosomes[i])
    end

    @test length(ga_sudoku.best_chromosomes) == 1001 # 1000 generations + initial population
    @test length(ga_sudoku.best_fitness) == 1001
end

@testset "verbose outputs anything" begin
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

@testset "Early Stopping GA with max_no_improvement and target_fitness" begin
    uniform = RealUniformInitialization(10, 5, (-0.5, 0.5))
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
    sum_abs = (genes) -> sum(abs.(genes))  # Simple fitness function

    ga_early_stop = GeneticAlgorithm(
        uniform,
        sum_abs,
        rouletteWheelSelection,
        singlePointCrossover,
        geneMutation,
        max_generations = 50,
        mutation_rate = 0.5,
        save_best = true,
        max_no_improvement = 3,
        target_fitness = 1.0
    )
    
    initial_best_fitness = 100.0
    optimize(ga_early_stop)
    
    @test length(ga_early_stop.best_chromosomes) <= 51
    @test ga_early_stop.best_fitness[end] >= 1.0
    @test ga_early_stop.best_fitness[end] != initial_best_fitness

    no_improvement_count = 0
    best_fitness_so_far = -Inf
    for fitness_score in ga_early_stop.best_fitness
        if fitness_score == best_fitness_so_far
            no_improvement_count += 1
        else
            no_improvement_count = 0
        end
        best_fitness_so_far = fitness_score
    end
    @test no_improvement_count <= 3

    if ga_early_stop.best_fitness[end] >= 1.0
        @test ga_early_stop.best_fitness[end] >= 1.0
    end
end

@testset "Early Stopping GA with target_fitness" begin
    uniform = RealUniformInitialization(10, 5, (-0.5, 0.5))
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
    sum_abs = (genes) -> sum(abs.(genes))

    ga_target_fitness = GeneticAlgorithm(
        uniform,
        sum_abs,
        rouletteWheelSelection,
        singlePointCrossover,
        geneMutation,
        max_generations = 50,
        mutation_rate = 0.5,
        save_best = true,
        target_fitness = 1.0
    )
    
    optimize(ga_target_fitness)
    
    @test length(ga_target_fitness.best_chromosomes) <= 51 # 50 generations + initial population
    @test ga_target_fitness.best_fitness[end] >= 1.0
end

@testset "Early Stopping GA with max_no_improvements" begin
    uniform = RealUniformInitialization(10, 5, (-0.5, 0.5))
    rouletteWheelSelection = RouletteWheelSelection()
    singlePointCrossover = SinglePointCrossover()
    geneMutation = RealGeneMutation(0.5, (-0.5, 0.5))
    sum_abs = (genes) -> sum(abs.(genes))

    ga_max_no_improvements = GeneticAlgorithm(
        uniform,
        sum_abs,
        rouletteWheelSelection,
        singlePointCrossover,
        geneMutation,
        max_generations = 50,
        mutation_rate = 0.5,
        save_best = true,
        max_no_improvement = 3
    )
    
    optimize(ga_max_no_improvements)
    
    no_improvement_count = 0
    best_fitness_so_far = -Inf
    for fitness_score in ga_max_no_improvements.best_fitness
        if fitness_score == best_fitness_so_far
            no_improvement_count += 1
        else
            no_improvement_count = 0
        end
        best_fitness_so_far = fitness_score
    end
    @test no_improvement_count <= 4 # 3 generations + initial population
end

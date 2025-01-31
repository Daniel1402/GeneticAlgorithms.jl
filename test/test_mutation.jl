
@testset "RealGeneMutation" begin
    mutation = RealGeneMutation(0.1, (-0.5, 0.5))
    mutated_genes = mutation(Chromosome([0.0, 0.0, 0.0, 0.0, 0.0]))
    @test length(mutated_genes.genes) == 5
    for gene in mutated_genes.genes
        @test -0.5 <= gene <= 0.5
    end
    @test mutation.mutation_rate == 0.1
    @test mutation.mutation_interval == (-0.5, 0.5)

    mutation_int = RealGeneMutation(0.9, (0, 17))
    mutated_genes = mutation_int(Chromosome([0, 0])).genes
    @test all(mutated_genes .>= 0 .& mutated_genes .<= 17)

    mutation_bool = RealGeneMutation(1.0, (false, true))
    mutated_genes = mutation_bool(Chromosome([true, false, true, false])).genes
    @test all(mutated_genes .== false .|| mutated_genes .== true)

    @test_throws ArgumentError RealGeneMutation(-0.2, (0.0, 1.1))
    @test_throws ArgumentError RealGeneMutation(1.1, (0.0, 1.1))
    @test_throws ArgumentError RealGeneMutation(0.2, (0.0, 0.0))
    @test_throws ArgumentError RealGeneMutation(0.2, (0.1, 0.0))
end

@testset "SudokuMutation" begin
    test_sudoku = [
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
    test_chromosome = [
        [5, 3, 1, 2, 7, 4, 6, 8, 9],
        [6, 2, 3, 1, 9, 5, 4, 8, 7],
        [1, 9, 8, 7, 5, 4, 3, 6, 2],
        [8, 7, 9, 5, 6, 4, 1, 2, 3],
        [4, 2, 5, 8, 6, 3, 7, 9, 1],
        [7, 8, 9, 1, 2, 3, 4, 5, 6],
        [7, 6, 5, 4, 3, 1, 2, 8, 9],
        [2, 3, 6, 4, 1, 9, 7, 8, 5],
        [1, 2, 3, 4, 8, 6, 5, 7, 9],
    ]
    @test_throws ArgumentError SudokuMutation(-0.1, test_sudoku)
    @test_throws ArgumentError SudokuMutation(1.1, test_sudoku)
    @test_throws ArgumentError SudokuMutation(
        0.1,
        [[0, 0, 0, 4, 1, 9, 0, 0, 5], [0, 0, 0, 0, 8, 0, 0, 7, 9]],
    )
    @test_throws ArgumentError SudokuMutation(
        0.1,
        [
            [5, 0, 0, 7, 0, 0, 0, 0, 0],
            [6, 0, 0, 1, 9, 5, 0, 0, 0],
            [0, 9, 8, 0, 0, 0, 0, 6, 0],
            [8, 0, 0, 0, 6, 0, 0, 0, 3],
            [4, 0, 0, 8, 0, 3, 0, 0, 1],
            [7, 0, 0, 0, 2, 0, 0, 0, 6],
            [0, 6, 0, 0, 0, 0, 2, 8, 0],
            [0, 0, 0, 4, 1, 9, 0, 0, 5],
            [0, 0, 0, 0, 8, 0, 0, 7],
        ],
    )

    mutation = SudokuMutation(0.1, test_chromosome)
    chromosome = Chromosome(test_chromosome)
    mutated_chromosome = mutation(chromosome)
    @test size(mutated_chromosome.genes, 1) == 9
    @test all(size.(mutated_chromosome.genes, 1) .== 9)

    # The initial cell values should not change during the mutation step
    init_cells_not_changed = true
    for i in eachindex(mutated_chromosome.genes)
        bool_vec = mutated_chromosome.genes[i] .== test_sudoku[i]
        bool_vec = bool_vec .|| test_sudoku[i] .== 0
        init_cells_not_changed &= reduce(|, bool_vec)
    end
    @test init_cells_not_changed

    # The columns should still contain a permutation of [1, 2, 3, 4, 5, 6, 7, 8, 9]
    no_duplicates_in_columns = true
    sudoku_values = Set(1:9)
    for column in mutated_chromosome.genes
        no_duplicates_in_columns &= length(setdiff(sudoku_values, Set(column))) == 0
    end
    @test no_duplicates_in_columns
end

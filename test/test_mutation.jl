using Test
using GeneticAlgorithms.Mutation


@testset "Mutation.jl" begin

    mutation = RealGeneMutation(0.1, (-0.5, 0.5))
    mutated_genes = mutation([0.0 0.0 0.0 0.0 0.0])
    @test length(mutated_genes) == 5
    for gene in mutated_genes
        @test -0.5 <= gene <= 0.5
    end
    @test mutation.mutation_rate == 0.1
    @test mutation.mutation_interval == (-0.5, 0.5)

    mutation_int = RealGeneMutation(0.9, (0, 17))
    mutated_genes = mutation_int([0 0])
    @test all(mutated_genes .>= 0 .& mutated_genes .<= 17)

    mutation_bool = RealGeneMutation(1.0, (false, true))
    mutated_genes = mutation_bool([true false true false])
    @test all(mutated_genes .== false .|| mutated_genes .== true)

    @test_throws ArgumentError RealGeneMutation(-0.2, (0.0, 1.1))
    @test_throws ArgumentError RealGeneMutation(1.1, (0.0, 1.1))
    @test_throws ArgumentError RealGeneMutation(0.2, (0.0, 0.0))
    @test_throws ArgumentError RealGeneMutation(0.2, (0.1, 0.0))
end



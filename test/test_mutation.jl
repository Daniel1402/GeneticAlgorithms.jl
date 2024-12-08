using Test
using GeneticAlgorithms.Mutation


@testset "Mutation.jl" begin

    mutation = RealGeneMutation(0.1, (-0.5, 0.5))
    mutated_genes = mutation([0.0, 0.0, 0.0, 0.0, 0.0])
    @test length(mutated_genes) == 5
    for gene in mutated_genes
        @test -0.5 <= gene <= 0.5
    end
    @test mutation.mutation_rate == 0.1
    @test mutation.mutation_interval == (-0.5, 0.5)
end



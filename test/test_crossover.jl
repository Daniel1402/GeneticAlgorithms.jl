using Test
using GeneticAlgorithms.Crossover
using GeneticAlgorithms.Types

@testset "Crossover.jl" begin
    chrom1_values = [1, 2, 3, 4, 5]
    chrom2_values = [6, 7, 8, 9, 10]

    chrom1 = IntegerChromosome(chrom1_values)
    chrom2 = IntegerChromosome(chrom2_values)


    crossover = SinglePointCrossover()
    offspring1_chrom, offspring2_chrom = crossover(chrom1, chrom2)
    offspring1 = offspring1_chrom.genes
    offspring2 = offspring2_chrom.genes
    flipped = false
    isValid = true

    for i in eachindex(offspring1)
        if offspring1[i] != chrom1_values[i] && !flipped
            flipped = true
            @test offspring1[i] == chrom2_values[i]
            @test offspring2[i] == chrom1_values[i]
            continue
        end

        if flipped && offspring1[i] != chrom2_values[i]
            isValid = false
            break
        end

        if flipped && offspring2[i] != chrom1_values[i]
            isValid = false
            break
        end

        if !flipped && offspring1[i] != chrom1_values[i]
            isValid = false
            break
        end

        if !flipped && offspring2[i] != chrom2_values[i]
            isValid = false
            break
        end
    end

    @test isValid
end

using Test

using GeneticAlgorithms.Crossover 

@testset "Crossover.jl" begin
chromosome1 = [1, 2, 3, 4, 5]
chromosome2 = [6, 7, 8, 9, 10]

offspring1, offspring2 = singlePointCrossover(chromosome1, chromosome2)


flipped = false
isValid = true

for i in eachindex(offspring1)
    if offspring1[i] != chromosome1[i] && !flipped 
        flipped = true
        @test offspring1[i] == chromosome2[i]
        @test offspring2[i] == chromosome1[i]
        continue
    end

    if flipped && offspring1[i] != chromosome2[i]
        isValid = false
        break
    end

    if flipped && offspring2[i] != chromosome1[i]
        isValid = false
        break
    end

    if !flipped && offspring1[i] != chromosome1[i]
        isValid = false
        break
    end

    if !flipped && offspring2[i] != chromosome2[i]
        isValid = false
        break
    end
end

@test isValid

end 

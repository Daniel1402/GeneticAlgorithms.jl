module Population 

abstract type Chromosome end

struct Float64Chromosome <: Chromosome
    genes::Vector{Float64}
end

struct IntegerChromosome <: Chromosome
    genes::Vector{Integer}
end

struct BoolChromosome <: Chromosome
    genes::Vector{Float64}
end

struct Population{T <: Chromosome}
    chromosomes::Vector{T}
end

export Population, Chromosome, Float64Chromosome, IntegerChromosome, BoolChromosome

end
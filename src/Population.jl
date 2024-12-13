module Population 

abstract type Chromosome end

struct Float64Chromosome <: Chromosome
    genes::Vector{Float64}
end

struct Population{T <: Chromosome}#
    chromosomes::Vector{T}
end

end
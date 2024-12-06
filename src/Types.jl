module Types

abstract type Gene end
abstract type Chromosome <: AbstractVector{Gene} end
abstract type Population <: AbstractVector{Chromosome} end
abstract type SelectionStrategy end
abstract type CrossoverMethod end
abstract type MutationMethod end

# TODO

export Gene, Chromosome, SelectionStrategy, CrossoverMethod, MutationMethod

end
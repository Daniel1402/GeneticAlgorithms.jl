module Crossover

using ..Types

function singlePointCrossover(parent1::Vector{Int64}, parent2::Vector{Int64})::Tuple{Vector{Int64}, Vector{Int64}}
    crossover_point = rand(1:length(parent1))
    offspring1 = vcat(parent1[1:crossover_point], parent2[crossover_point+1:end])
    offspring2 = vcat(parent2[1:crossover_point], parent1[crossover_point+1:end])
    return offspring1, offspring2
end


function singlePointCrossover(parent1::Vector{Float64}, parent2::Vector{Float64})::Tuple{Vector{Float64}, Vector{Float64}}
    crossover_point = rand(1:length(parent1))
    offspring1 = vcat(parent1[1:crossover_point], parent2[crossover_point+1:end])
    offspring2 = vcat(parent2[1:crossover_point], parent1[crossover_point+1:end])
    return offspring1, offspring2
end

export singlePointCrossover
end
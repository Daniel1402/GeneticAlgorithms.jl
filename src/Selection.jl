module Selection

using ..Types

function rouletteWheelSelection(population::Vector{Vector{Int64}}, fitness_scores::Vector{Float64}, rand_generator::Function = rand)::Tuple{Vector{Int64}, Vector{Int64}}
    if length(population) != length(fitness_scores)
        throw(ArgumentError("Population and fitness scores must have the same length"))
    end

    if length(population) <= 1
        throw(ArgumentError("Population must have at least 2 individuals"))
    end

    if any(fitness_scores .< 0)
        throw(ArgumentError("Fitness scores must be non-negative"))
    end

    if all(fitness_scores .== 0.0)
        throw(ArgumentError("Fitness scores cannot all be zero"))
    end

    if length(population) == 2
        return population[1], population[2]
    end

    # Helper function to select an index based on the fitness scores
    function indexSelection(fitness_scores, rand_generator)
        # Calculate the cumulative probabilities
        cum_probs = cumsum(fitness_scores ./ sum(fitness_scores))

        selected_index = findfirst(cum_prob -> rand_generator() <= cum_prob, cum_probs)

        return selected_index == nothing ? length(fitness_scores) : selected_index
    end

    p1_index = indexSelection(fitness_scores, rand_generator)

    # Filter out the selected index & search for the second parent
    p2_index = indexSelection(fitness_scores[1:end .!= p1_index], rand_generator)

    # Adjust the index to account for the removed element
    p2_index += (p2_index >= p1_index ? 1 : 0)

    return population[p1_index], population[p2_index]
end


export rouletteWheelSelection   
end

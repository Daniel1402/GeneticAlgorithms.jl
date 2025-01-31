"""
    RouletteWheelSelection()

Struct for Roulette Wheel Selection. This selection method is based on the cumulative 
probabilities of the fitness scores. Implemented as a callable object.
"""
struct RouletteWheelSelection <: SelectionMethod end

"""
    (c::RouletteWheelSelection)(
        population::Population{T},
        fitness_scores::Vector{Float64},
        rand_generator::F=rand,
    )::Tuple{T,T} where {T<:Chromosome,F<:Function}

Performs Roulette Wheel Selection on a population based on fitness scores, returning two selected individuals (parents).

Selection is based on the cumulative probabilities of the fitness scores.

# Arguments
- `population::Population`: The population of chromosomes from which to select.
- `fitness_scores::Vector{Float64}`: A vector of fitness scores corresponding to the population.
- `rand_generator<:Function=rand`: A function to generate random numbers, default is `rand`.

# Return
- `Tuple{T,T}`: A tuple containing two selected chromosomes (parents).
"""
function (c::RouletteWheelSelection)(
    population::Population{T},
    fitness_scores::Vector{Float64},
    rand_generator::F=rand,
)::Tuple{T,T} where {T<:Chromosome,F<:Function}
    if size(population.chromosomes, 1) != length(fitness_scores)
        throw(ArgumentError("Population and fitness scores must have the same length"))
    end

    if size(population.chromosomes, 1) <= 1
        throw(ArgumentError("Population must have at least 2 individuals"))
    end

    if any(fitness_scores .< 0)
        throw(ArgumentError("Fitness scores must be non-negative"))
    end

    if all(fitness_scores .== 0.0)
        throw(ArgumentError("Fitness scores cannot all be zero"))
    end

    if size(population.chromosomes, 1) == 2
        return population.chromosomes[1], population.chromosomes[2]
    end

    # Helper function to select an index based on the fitness scores
    function indexSelection(fitness_scores::Vector{Float64}, rand_generator::Function)::Int
        # Calculate the cumulative probabilities
        cum_probs = cumsum(fitness_scores ./ sum(fitness_scores))

        fixed_rand = rand_generator()

        selected_index = findfirst(cum_prob -> fixed_rand <= cum_prob, cum_probs)

        return isnothing(selected_index) ? length(fitness_scores) : selected_index
    end

    p1_index = indexSelection(fitness_scores, rand_generator)

    p2_index = indexSelection(fitness_scores[1:end.!=p1_index], rand_generator)

    p2_index += (p2_index >= p1_index ? 1 : 0)

    return population.chromosomes[p1_index], population.chromosomes[p2_index]
end

module Fitness

using ..Types

"""
Calculates the negative Rosenbrock function value for a given vector.

# Arguments
- `values`: A vector of at least two Float64 values.

# Returns
- The negative Rosenbrock function value as a Float64.
"""
function rosenbrock_fitness(values::Vector{Float64})::Float64
    m = length(values)
    if m < 2
        throw(ArgumentError("Rosenbrock function requires at least two dimensions."))
    end
    
     # negative to maximize the function
    return - sum(
        100 * (values[i+1] - values[i]^2)^2 + (1 - values[i])^2
        for i in 1:m-1
    )
end

export rosenbrock_fitness

end
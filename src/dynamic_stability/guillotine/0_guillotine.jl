module Guillotine

include("./../../basic_model/constants.jl")
include("./1_equalities.jl")
include("./2_range.jl")
include("./4_and.jl")
include("./5_find_interval.jl")
using JuMP
using .Constants
using .Equalities
using .Range
using .GuillotineIfAnd
using .FindInterval

export cons_ds_guillotine

function cons_ds_guillotine(m)

    m = first_dim_equality(m)
    m = second_dim_range(m)
    m = all_dimensions_and(m)
    m = find_interval(m)

    @expression(m, guillotine_objective,
        sum(m[:guillotine_equalities_objective]) +
        #sum(m[:guillotine_range_objective]) +
        sum(m[:guillotine_and_objective]) +
        0.0001 * sum(m[:guillotine_interval_objective])
    )

    return m
end

end
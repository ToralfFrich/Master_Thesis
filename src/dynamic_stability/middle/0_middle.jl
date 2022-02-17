module Middle

include("./../../basic_model/constants.jl")
include("./1_get_supporting.jl")
include("./2_incentive.jl")
using JuMP
using .Constants
using .GetSupporting
using .Incentive

export cons_ds_middle

function cons_ds_middle(m)

    m = mid_get_supporting(m)
    m = incentive(m)

    @expression(m, middle_objective,
        sum(m[:ds_middle_minmax_objective]) + 
        sum(m[:ds_incentive_obj])
    )

    return m
end

end
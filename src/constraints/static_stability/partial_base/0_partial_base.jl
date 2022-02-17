module PartialBase

include("./../../constraints/geometric/constants.jl")
include("./1_if.jl")
include("./2_xy_cover.jl")
include("./3_multiplication.jl")
using JuMP
using .Constants
using .IfPartialBase
using .XYCoverPartialBase
using .MultiplicationPartialBase

export cons_ss_partial_base

function cons_ss_partial_base(model)

    model = if_pb(model)
    model = xy_cover(model)
    model = multiplication(model)

    # partial base stability constraint
    @constraint(model, c_pbs[i=1:(length(boxes)-1), j=1:length(boxes)-1; i!=j],  
        model[:pbs_box_i][i] >= 
        pb_ss_var*area_of_box[i]
    )

    return model
end

end
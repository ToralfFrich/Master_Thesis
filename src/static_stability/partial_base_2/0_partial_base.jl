module PartialBase2

include("./../../basic_model/constants.jl")
include("./1_if.jl")
include("./2_xy_cover.jl")
include("./3_multiplication.jl")
using JuMP
using .Constants
using .IfPartialBase
using .XYCoverPartialBase
using .MultiplicationPartialBase

export cons_ss_partial_base_two

function cons_ss_partial_base_two(m)

    m = if_pb(m)
    m = xy_cover(m)
    m = multiplication(m)

    
    # partial base stability constraint
    @constraint(m, c_pbs[i=1:(length(boxes)-1), j=1:length(boxes)-1; i!=j],  
        m[:pbs_box_i][i] >= 
        pb_ss_var*area_of_box[i]
    )

    return m
end

end
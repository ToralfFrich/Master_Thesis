module LBNumber

include("./../../basic_model/constants.jl")
include("./1_if.jl")
include("./2_calc_number.jl")
using JuMP
using .Constants
using .IfSimpleLoadBearing
using .CalcNumberLoadBearing

export cons_lb_number_load_bearing

function cons_lb_number_load_bearing(m)

    m = if_simple_lb(m)
    m = calc_number_lb(m)

    return m
end

end
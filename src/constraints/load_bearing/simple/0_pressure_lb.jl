module LBSimple

include("./../../constraints/geometric/constants.jl")
include("./1_if.jl")
include("./2_calc_pressure.jl")
using JuMP
using .Constants
using .IfSimpleLoadBearing
using .CalcSimpleLoadBearing

export cons_lb_simple_load_bearing

function cons_lb_simple_load_bearing(m)

    m = if_simple_lb(m)
    m = calc_simple_lb(m)
  
    #@expression(m, simple_load_bearing_objective,
    #    sum(m[:if_simple_lb_objective])
    #)

    return m
end

end
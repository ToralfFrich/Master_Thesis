module RobotPattern

include("./../../basic_model/constants.jl")
include("./1_equalities.jl")
include("./2_bounds.jl")
include("./3_constraints.jl")
using JuMP
using .Constants
using .RPEqualities
using .RPBounds
using .RPConstraints

export cons_rp_robot_pattern

function cons_rp_robot_pattern(m)

    m = rp_equalities(m)
    m = rp_bounds(m)
    m = rp_constraints(m)

    return m
end

end
module LoadBalancing

include("./../basic_model/constants.jl")
include("./1_constraints.jl")
using JuMP
using .Constants
using .LoadBalancingConstraints

export cons_lb_load_balancing

function cons_lb_load_balancing(m)

    m = lb_constraints(m)

    return m
end

end
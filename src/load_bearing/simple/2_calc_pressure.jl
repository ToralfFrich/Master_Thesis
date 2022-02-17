module CalcSimpleLoadBearing

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export calc_simple_lb

function calc_simple_lb(m)
    
    @expression(m, accountable_mass[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:if_simple_lb_var][i, j] * masses[j]
    )

    @expression(m, sum_of_mass_on_top_of_i[i=1:length(boxes)],
        sum(m[:accountable_mass][i, j] for j in 1:length(boxes) if i!=j)
    )

    @constraint(m, c_sum_of_mass_on_top_of_i[i=1:length(boxes)-1],
        m[:sum_of_mass_on_top_of_i][i] <= mass_volume[i]
    )

    return m
end

end
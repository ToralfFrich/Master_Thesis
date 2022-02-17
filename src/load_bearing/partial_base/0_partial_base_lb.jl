module LBPartialBase

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export cons_lb_partial_base

function cons_lb_partial_base(m)

    @expression(m, pb_mass_on_top_of_i[i=1:length(boxes), j=1:length(boxes); i!=j],
        mass_density[i] * m[:pbs_box_ij][i, j] / area_of_box[i]
    )

    @expression(m, pb_sum_of_mass_on_top_of_i[j=1:length(boxes)], 
        sum([m[:pb_mass_on_top_of_i][i, j] for i in 1:length(boxes) if i!=j])
    )

    @constraint(m, c_max_allowed_weight[i=1:length(boxes)-1],
        m[:pb_sum_of_mass_on_top_of_i][i] <= max_allowed_weight[i]
    )

    return m
end

end
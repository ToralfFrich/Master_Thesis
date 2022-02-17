module CMultipleBoxes

include("./../../constraints/geometric/constants.jl")
using .Constants

using JuMP

export cons_ss_mult_boxes

function cons_ss_mult_boxes(m)

    @variable(m, does_box_provide_var_support[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, c_how_many_boxes_provide_var_support1[i=1:(length(boxes)-1), j=1:length(boxes)-1; i!=j], 
        (1 - m[:does_box_provide_var_support][i, j]) * area_of_box[i] >=
        mult_boxes_ss_var * area_of_box[i] - m[:pbs_box_ij][i, j]
    )

    @constraint(m, c_how_many_boxes_provide_var_support2[i=1:(length(boxes)-1), j=1:length(boxes)-1; i!=j], 
        m[:does_box_provide_var_support][i, j] * area_of_box[i] >=
        m[:pbs_box_ij][i, j] - mult_boxes_ss_var * area_of_box[i]
    )

    @expression(m, sum_of_how_many_boxes_provide_var_support[i=1:length(boxes)-1], 
        sum([m[:does_box_provide_var_support][i, j] for j in 1:length(boxes)-1 if i!=j])
    )

    @variable(m, is_box_above_ground[i=1:length(boxes)-1], Bin)
    @constraint(m, c_is_box_above_ground1[i=1:length(boxes)-1],
        (1 - is_box_above_ground[i]) * H >=
        0.002 - m[:flbz_front_left_bot_z][i]
    )

    @constraint(m, c_is_box_above_ground2[i=1:length(boxes)-1],
        is_box_above_ground[i] * H >=
        m[:flbz_front_left_bot_z][i] - 0.002
    )

    @constraint(m, c_ensure_two_or_more_support1[i=1:length(boxes)-1],
        number_of_boxes * (1 - is_box_above_ground[i]) >= number_of_boxes - m[:sum_of_how_many_boxes_provide_var_support][i]
    )

    @expression(m, mult_boxes_objective[i=1:(length(boxes)-1), j=1:length(boxes)-1; i!=j],
        (1 - m[:does_box_provide_var_support][i, j])
    )

    return m
end

end
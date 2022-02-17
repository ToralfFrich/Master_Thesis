module MultBoxes

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export cons_ds_mult_boxes

function cons_ds_mult_boxes(m)

    @expression(m, mb_sum_of_boxes_below_box_i[i=1:length(boxes)], 
        sum([m[:if_on_top][i, j] for j in 1:length(boxes) if i!=j])
    )

    @expression(m, ds_mb_sum_of_boxes_below_obj[i=1:length(boxes)],
        length(boxes) - m[:mb_sum_of_boxes_below_box_i][i]
    )

    return m
end

end
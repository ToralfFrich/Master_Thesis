module CalcNumberLoadBearing

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export calc_number_lb

function calc_number_lb(m)

    @expression(m, num_of_boxes_on_top_i[i=1:length(boxes)],
        sum(m[:if_simple_lb_var][i, j] for j in 1:length(boxes) if i!=j)
    )

    @constraint(m, c_num_of_boxes_on_top_i[i=1:length(boxes)-1],
        m[:num_of_boxes_on_top_i][i] <= lb_number_of_boxes
    )

    return m
end

end
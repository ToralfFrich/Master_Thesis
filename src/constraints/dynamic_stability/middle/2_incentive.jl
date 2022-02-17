module Incentive

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export incentive

function incentive(m)
    

    @expression(m, midpoint_of_support_x[i=1:length(boxes)],
        (m[:max_flbx_of_supporting_i][i] + m[:min_flbx_of_supporting_i][i])/2
    )

    @expression(m, midpoint_of_support_y[i=1:length(boxes)],
        (m[:max_flby_of_supporting_i][i] + m[:min_flby_of_supporting_i][i])/2
    )

    #Want to minimise the absolute value distance away from the midpoints that are suggested. 
    @variable(m, incentive_x[i=1:length(boxes)])
    @constraint(m, incentive_x_min[i=1:length(boxes)], 
        m[:incentive_x][i] >= 
        m[:two_or_more_below][i] * 
        (m[:midpoint_of_support_x][i] - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]/2))
    )

    @constraint(m, incentive_x_max[i=1:length(boxes)-1], 
        m[:incentive_x][i] >= 
        m[:two_or_more_below][i] * 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]/2) - m[:midpoint_of_support_x][i]
    )

    @variable(m, incentive_y[i=1:length(boxes)])
    @constraint(m, incentive_y_min[i=1:length(boxes)], 
        m[:incentive_y][i] >= 
        m[:two_or_more_below][i] * 
        m[:midpoint_of_support_y][i] - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]/2)
    )

    @constraint(m, incentive_y_max[i=1:length(boxes)], 
        m[:incentive_y][i] >= 
        m[:two_or_more_below][i] * 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]/2) - m[:midpoint_of_support_y][i]
    )

    @expression(m, ds_incentive_obj,
        sum(m[:incentive_x]) +
        sum(m[:incentive_y])
    )

    return m
end

end
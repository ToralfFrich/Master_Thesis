module GetSupporting

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export mid_get_supporting

function mid_get_supporting(m)

    @expression(m, sum_of_boxes_below_box_i[i=1:length(boxes)], 
        sum([m[:if_on_top][i, j] for j in 1:length(boxes) if i!=j])
    )

    @variable(m, two_or_more_below[i=1:length(boxes)], Bin)
    @constraint(m, two_or_more_below_c1[i=1:length(boxes)], 
        m[:sum_of_boxes_below_box_i][i] + length(boxes) * (1 - m[:two_or_more_below][i]) >= 2
    )

    #min(flbx_front_left_bot_x[j]) * if_j_below_i
    #min(flby_front_left_bot_y[j]) * if_j_below_i

    @variable(m, min_flbx_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, get_min_flbx_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_flbx_of_supporting_ij][i, j] .>= 
        [m[:if_on_top][i, j] * m[:flbx_front_left_bot_x][j], (1 - m[:if_on_top][i, j]) * m[:flbx_front_left_bot_x][i]]
        )
    )

    @variable(m, min_flby_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, get_min_flby_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_flby_of_supporting_ij][i, j] .>= 
        [m[:if_on_top][i, j] * m[:flby_front_left_bot_y][j], (1 - m[:if_on_top][i, j]) * m[:flby_front_left_bot_y][i]]
        )
    )

    #max(flbx_front_left_bot_x[j] + box_x_axis_cover[j]) * if_j_below_i
    #max(flby_front_left_bot_y[j] + box_y_axis_cover[j]) * if_j_below_i

    @variable(m, max_flbx_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, get_max_flbx_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:max_flbx_of_supporting_ij][i, j] .>= 
        m[:if_on_top][i, j] * (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j])
    )

    @variable(m, max_flby_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, get_max_flby_of_supporting_ij[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:max_flby_of_supporting_ij][i, j] .>= 
        m[:if_on_top][i, j] * (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j])
    )

    #Change expression so that we have one value for each box
    @variable(m, min_flbx_of_supporting_i[i=1:length(boxes)] >= 0)
    @variable(m, min_flby_of_supporting_i[i=1:length(boxes)] >= 0)
    @variable(m, max_flbx_of_supporting_i[i=1:length(boxes)] >= 0)
    @variable(m, max_flby_of_supporting_i[i=1:length(boxes)] >= 0)

    @constraint(m, get_min_flbx_of_supporting_i[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:min_flbx_of_supporting_ij][i, j] >= m[:min_flbx_of_supporting_i][i]
    )
    @constraint(m, get_min_flby_of_supporting_i[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:min_flby_of_supporting_ij][i, j] >= m[:min_flby_of_supporting_i][i]
    )
    @constraint(m, get_max_flbx_of_supporting_i[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:max_flbx_of_supporting_i][i] >= m[:max_flbx_of_supporting_ij][i, j]
    )
    @constraint(m, get_max_flby_of_supporting_i[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:max_flby_of_supporting_i][i] >= m[:max_flby_of_supporting_ij][i, j]
    )

    #want to minimise this in the objective: minimise max, and maximise min
    @expression(m, ds_middle_minmax_objective[i=1:length(boxes), j=1:length(boxes); i!=j], 
        10 * (1 - m[:two_or_more_below][i]) +
        m[:max_flbx_of_supporting_ij][i, j] + 
        m[:max_flby_of_supporting_ij][i, j] +
        m[:min_flbx_of_supporting_ij][i, j] + 
        m[:min_flby_of_supporting_ij][i, j] + 
        m[:max_flbx_of_supporting_i][i] +
        m[:max_flby_of_supporting_i][i] +
        (L - m[:min_flbx_of_supporting_i][i]) +
        (W - m[:min_flby_of_supporting_i][i])
    )

    return m
end

end
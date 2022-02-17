module XYCoverPartialBase

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export xy_cover

function xy_cover(model)

    #max(flbx_front_left_bot_x[i], flbx_front_left_bot_x[j])
    #max(flby_front_left_bot_y[i], flby_front_left_bot_y[j])

    @variable(model, max_flbx_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(model, get_max_flbx_of_ij[i=1:length(boxes), j=1:length(boxes); i!=j], 
        model[:max_flbx_ij][i, j] .>= 
        [model[:flbx_front_left_bot_x][i], model[:flbx_front_left_bot_x][j]]
    )

    @variable(model, max_flby_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(model, get_max_flby_of_ij[i=1:length(boxes), j=1:length(boxes); i!=j], 
        model[:max_flby_ij][i, j] .>= 
        [model[:flby_front_left_bot_y][i], model[:flby_front_left_bot_y][j]]
    )


    #min(flbx_front_left_bot_x[i] + box_i_x_axis_cover, flbx_front_left_bot_x[j] + box_j_x_axis_cover)
    #min(flby_front_left_bot_y[i] + box_i_y_axis_cover, flby_front_left_bot_y[j] + box_j_y_axis_cover)

    @variable(model, min_flbx_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(model, get_min_flbx_of_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        [model[:flbx_front_left_bot_x][i] + model[:box_x_axis_cover][i], model[:flbx_front_left_bot_x][j] + model[:box_x_axis_cover][j]] .>= 
        model[:min_flbx_ij][i, j])
    )

    @variable(model, min_flby_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(model, get_min_flby_of_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        [model[:flby_front_left_bot_y][i] + model[:box_y_axis_cover][i], model[:flby_front_left_bot_y][j] + model[:box_y_axis_cover][j]] .>= 
        model[:min_flby_ij][i, j])
    )


    #x_axis_covered = min(flbx_front_left_bot_x[i] + box_i_x_axis_cover, flbx_front_left_bot_x[j] + box_j_x_axis_cover) - max(flbx_front_left_bot_x[i], flbx_front_left_bot_x[j])
    #y_axis_covered = min(flby_front_left_bot_y[i] + box_i_y_axis_cover, flby_front_left_bot_y[j] + box_j_y_axis_cover) - max(flby_front_left_bot_y[i], flby_front_left_bot_y[j])

    @expression(model, x_axis_covered[i=1:length(boxes), j=1:length(boxes); i!=j], 
        model[:min_flbx_ij][i, j] - model[:max_flbx_ij][i, j]
    )
    @expression(model, y_axis_covered[i=1:length(boxes), j=1:length(boxes); i!=j], 
        model[:min_flby_ij][i, j] - model[:max_flby_ij][i, j]
    )

    return model
end

end






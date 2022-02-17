module Variables

include("./constants.jl")
using JuMP
using .Constants

export init_variables

function init_variables(m)
    
    #Dimensions of box
    @variable(m, lob_length_of_box[i=1:length(boxes)] == boxes[i][1])
    @variable(m, wob_width_of_box[i=1:length(boxes)] == boxes[i][2])
    @variable(m, hob_height_of_box[i=1:length(boxes)] == boxes[i][3])

    #Front-left coordinate of each box
    @variable(m, flbx_front_left_bot_x[i=1:length(boxes)] >= 0)
    @variable(m, flby_front_left_bot_y[i=1:length(boxes)] >= 0)
    @variable(m, flbz_front_left_bot_z[i=1:length(boxes)] >= 0)

    #Check if length (pi) is parallel to X, Y or Z-axis
    @variable(m, lpx_length_of_box_parallel_to_x[i=1:length(boxes)], Bin)
    @variable(m, lpy_length_of_box_parallel_to_y[i=1:length(boxes)], Bin)
    @variable(m, lpz_length_of_box_parallel_to_z[i=1:length(boxes)], Bin)

    #Check if width (qi) is parallel to X, Y or Z-axis
    @variable(m, wpx_width_of_box_parallel_to_x[i=1:length(boxes)], Bin)
    @variable(m, wpy_width_of_box_parallel_to_y[i=1:length(boxes)], Bin)
    @variable(m, wpz_width_of_box_parallel_to_z[i=1:length(boxes)], Bin)

    #Check if height (ri) is parallel to X, Y or Z-axis
    @variable(m, hpx_height_of_box_parallel_to_x[i=1:length(boxes)], Bin)
    @variable(m, hpy_height_of_box_parallel_to_y[i=1:length(boxes)], Bin)
    @variable(m, hpz_height_of_box_parallel_to_z[i=1:length(boxes)], Bin)

    # box_j_x_axis_cover = lpx_length_of_box_parallel_to_x[j]*lob_length_of_box[j] + wpx_width_of_box_parallel_to_x[j]*wob_width_of_box[j]
    # box_j_y_axis_cover = lpy_length_of_box_parallel_to_y[j]*lob_length_of_box[j] + wpy_width_of_box_parallel_to_y[j]*wob_width_of_box[j]
    @expressions(m, begin
        box_x_axis_cover[i=1:length(boxes)], 
        (
        m[:lpx_length_of_box_parallel_to_x][i]*fix_value(m[:lob_length_of_box][i]) + 
        m[:wpx_width_of_box_parallel_to_x][i]*fix_value(m[:wob_width_of_box][i])
        )

        box_y_axis_cover[i=1:length(boxes)], 
        (
        m[:lpy_length_of_box_parallel_to_y][i]*fix_value(m[:lob_length_of_box][i]) + 
        m[:wpy_width_of_box_parallel_to_y][i]*fix_value(m[:wob_width_of_box][i])
        )
    end)

    #Make objective available for the whole program. Later used in objective function.
    @expression(
        m, heights[i=1:length(boxes)], m[:flbz_front_left_bot_z][i] + fix_value(m[:hob_height_of_box][i])
    )
    @variable(m, H >= maxHeight >= 0)
    @constraint(m, m[:maxHeight] .>= m[:heights])

    return m
end

end
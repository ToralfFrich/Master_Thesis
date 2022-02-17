module InsidePallet

include("./constants.jl")
using JuMP
using .Constants

export cons_inside_pallet

#Constraints ensuring that the only allowed rotations are those of Currence Robotics
function cons_inside_pallet(model)

    #Check not exceeding in X-axis
    @constraint(model,
    xnel_x_not_exceed_length[i=1:length(boxes)], 
    (model[:flbx_front_left_bot_x][i] + 
    boxes[i][1]*model[:lpx_length_of_box_parallel_to_x][i] + 
    boxes[i][2]*model[:wpx_width_of_box_parallel_to_x][i] + 
    boxes[i][3]*model[:hpx_height_of_box_parallel_to_x][i] <= 
    L)
    )

    #Check not exceeding in Y-axis
    @constraint(model, 
    ynew_y_not_exceed_width[i=1:length(boxes)], 
    (model[:flby_front_left_bot_y][i] + 
    boxes[i][1]*model[:lpy_length_of_box_parallel_to_y][i] + 
    boxes[i][2]*model[:wpy_width_of_box_parallel_to_y][i] + 
    boxes[i][3]*model[:hpy_height_of_box_parallel_to_y][i] <= 
    W)
    )

    #Check not exceeding in Z-axis
    @constraint(model,
    zneh_z_not_exceed_height[i=1:length(boxes)], 
    (model[:flbz_front_left_bot_z][i] + 
    boxes[i][1]*model[:lpz_length_of_box_parallel_to_z][i] + 
    boxes[i][2]*model[:wpz_width_of_box_parallel_to_z][i] + 
    boxes[i][3]*model[:hpz_height_of_box_parallel_to_z][i] <= 
    H)
    )

    return model
end

end








module RotationsCurrence

include("./constants.jl")
using JuMP
using .Constants

export cons_rotations_currence

#Constraints ensuring that the only allowed rotations are those of Currence Robotics
function cons_rotations_currence(model)

    # lx + ly = 1
    @constraint(model, 
    lxly[i=1:length(boxes)], (model[:lpx_length_of_box_parallel_to_x][i] +
    model[:lpy_length_of_box_parallel_to_y][i] == 1)
    )

    #wpx + wpy =1
    @constraint(model,
    wxwy[i=1:length(boxes)], (model[:wpx_width_of_box_parallel_to_x][i] + 
    model[:wpy_width_of_box_parallel_to_y][i] == 1)
    )

    #lx + wx = 1
    @constraint(model,
    lxwx[i=1:length(boxes)], (model[:lpx_length_of_box_parallel_to_x][i] +
    model[:wpx_width_of_box_parallel_to_x][i] == 1)
    )

    #ly + wy = 1
    @constraint(model, 
    lywy[i=1:length(boxes)], (model[:lpy_length_of_box_parallel_to_y][i] + 
    model[:wpy_width_of_box_parallel_to_y][i] == 1)
    )

    #hz = 1, hz, hy, lz, wz = 0
    @constraints(model, begin 
    [i=1:length(boxes)], model[:hpz_height_of_box_parallel_to_z][i] == 1
    [i=1:length(boxes)], model[:hpx_height_of_box_parallel_to_x][i] == 0
    [i=1:length(boxes)], model[:hpy_height_of_box_parallel_to_y][i] == 0
    [i=1:length(boxes)], model[:lpz_length_of_box_parallel_to_z][i] == 0
    [i=1:length(boxes)], model[:wpz_width_of_box_parallel_to_z][i] == 0
    end)

    return model
end

end
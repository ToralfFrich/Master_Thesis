module NonOverlapping

include("./constants.jl")
using JuMP
using .Constants

export cons_non_overlapping

#Constraints ensuring that the only allowed rotations are those of Currence Robotics
function cons_non_overlapping(model)

    # ====== RELATIVE POSISJONER START =======
    #For each pair of boxes (i, j), check j's relative position to i (from i's perspective)
    @variable(model, aij_j_left_of_i[i=1:length(boxes), j=1:length(boxes); i!=j], Bin) #left
    @variable(model, bij_j_right_of_i[i=1:length(boxes), j=1:length(boxes); i!=j], Bin) #right
    @variable(model, cij_j_behind_i[i=1:length(boxes), j=1:length(boxes); i!=j], Bin) #behind
    @variable(model, dij_j_in_front_i[i=1:length(boxes), j=1:length(boxes); i!=j], Bin) #in front
    @variable(model, eij_j_below_i[i=1:length(boxes), j=1:length(boxes); i!=j], Bin) #below
    @variable(model, fij_j_above_i[i=1:length(boxes), j=1:length(boxes); i!=j], Bin) #above


    #One box can only be at relative to another box with 1 position.
    @constraint(model, 
        rel_pos[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (model[:aij_j_left_of_i][i, j] + 
        model[:bij_j_right_of_i][i, j] + 
        model[:cij_j_behind_i][i, j] +
        model[:dij_j_in_front_i][i, j] + 
        model[:eij_j_below_i][i, j] +
        model[:fij_j_above_i][i, j] >= 1)
    )
    # ====== RELATIVE POSISJONER SLUTT =======


    # ====== IKKE OVERLAPPENDE START =======
    #left
    @constraint(model, 
        left[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (model[:flbx_front_left_bot_x][i] + 
        fix_value(model[:lob_length_of_box][i])*model[:lpx_length_of_box_parallel_to_x][i] + 
        fix_value(model[:wob_width_of_box][i])*model[:wpx_width_of_box_parallel_to_x][i] +
        fix_value(model[:hob_height_of_box][i])*model[:hpx_height_of_box_parallel_to_x][i]) <=
        (model[:flbx_front_left_bot_x][j] + (1-model[:aij_j_left_of_i][i, j])*L)
    )

    #right
    @constraint(model, 
        right[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (model[:flbx_front_left_bot_x][j] +
        fix_value(model[:lob_length_of_box][j])*model[:lpx_length_of_box_parallel_to_x][j] +
        fix_value(model[:wob_width_of_box][j])*model[:wpx_width_of_box_parallel_to_x][j] +
        fix_value(model[:hob_height_of_box][j])*model[:hpx_height_of_box_parallel_to_x][j]) <=
        (model[:flbx_front_left_bot_x][i] + (1-model[:bij_j_right_of_i][i, j])*L)
    )

    #behind
    @constraint(model, 
        behind[i=1:length(boxes), j=1:length(boxes); i!=j], (model[:flby_front_left_bot_y][i] +
        fix_value(model[:lob_length_of_box][i])*model[:lpy_length_of_box_parallel_to_y][i] +
        fix_value(model[:wob_width_of_box][i])*model[:wpy_width_of_box_parallel_to_y][i] +
        fix_value(model[:hob_height_of_box][i])*model[:hpy_height_of_box_parallel_to_y][i]) <=
        (model[:flby_front_left_bot_y][j] + (1-model[:cij_j_behind_i][i, j])*W)
    )

    #in_front
    @constraint(model, 
        in_front[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (model[:flby_front_left_bot_y][j] +
        fix_value(model[:lob_length_of_box][j])*model[:lpy_length_of_box_parallel_to_y][j] +
        fix_value(model[:wob_width_of_box][j])*model[:wpy_width_of_box_parallel_to_y][j] +
        fix_value(model[:hob_height_of_box][j])*model[:hpy_height_of_box_parallel_to_y][j]) <=
        (model[:flby_front_left_bot_y][i] + (1-model[:dij_j_in_front_i][i, j])*W)
    )

    #below
    @constraint(model,
        below[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (model[:flbz_front_left_bot_z][i] +
        fix_value(model[:lob_length_of_box][i])*model[:lpz_length_of_box_parallel_to_z][i] +
        fix_value(model[:wob_width_of_box][i])*model[:wpz_width_of_box_parallel_to_z][i] +
        fix_value(model[:hob_height_of_box][i])*model[:hpz_height_of_box_parallel_to_z][i]) <=
        (model[:flbz_front_left_bot_z][j] + (1-model[:eij_j_below_i][i, j])*H)
    )

    #above
    @constraint(model,
        above[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (model[:flbz_front_left_bot_z][j] +
        fix_value(model[:lob_length_of_box][j])*model[:lpz_length_of_box_parallel_to_z][j] +
        fix_value(model[:wob_width_of_box][j])*model[:wpz_width_of_box_parallel_to_z][j] +
        fix_value(model[:hob_height_of_box][j])*model[:hpz_height_of_box_parallel_to_z][j]) <=
        (model[:flbz_front_left_bot_z][i] + (1-model[:fij_j_above_i][i, j])*H)
    )
    # ====== IKKE OVERLAPPENDE SLUTT =======

    return model
end

end




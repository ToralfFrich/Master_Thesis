"""
@show value(m[:static_new_variable_1[1, 2])
@show value(m[:static_new_variable_1[2, 1])
@show value(m[:static_new_variable_1[1, 3])
@show value(m[:static_new_variable_1[3, 1])
@show value(m[:static_new_variable_1[2, 3])
@show value(m[:static_new_variable_1[3, 2])

@show value(m[:static_new_variable_2[1, 2])
@show value(m[:static_new_variable_2[2, 1])
@show value(m[:static_new_variable_2[1, 3])
@show value(m[:static_new_variable_2[3, 1])
@show value(m[:static_new_variable_2[2, 3])
@show value(m[:static_new_variable_2[3, 2])
"""


"""
    @show value(m[:max_of_xy_cover][1, 2])
    @show value(m[:max_of_xy_cover][2, 1])
    @show value(m[:max_of_xy_cover][1, 3])
    @show value(m[:max_of_xy_cover][3, 1])
    @show value(m[:max_of_xy_cover][2, 3])
    @show value(m[:max_of_xy_cover][3, 2])

    @show value(m[:min_of_xy_cover][1, 2])
    @show value(m[:min_of_xy_cover][2, 1])
    @show value(m[:min_of_xy_cover][1, 3])
    @show value(m[:min_of_xy_cover][3, 1])
    @show value(m[:min_of_xy_cover][2, 3])
    @show value(m[:min_of_xy_cover][3, 2])
    """


"""
@show value(m[:partial_static_stability_constraint][1, 2])
@show value(m[:partial_static_stability_constraint][2, 1])
@show value(m[:partial_static_stability_constraint][1, 3])
@show value(m[:partial_static_stability_constraint][3, 1])
@show value(m[:partial_static_stability_constraint][2, 3])
@show value(m[:partial_static_stability_constraint][3, 2])
"""

"""
@show value(m[:if_partial_static_stability_ij][1, 2])
@show value(m[:if_partial_static_stability_ij][2, 1])
@show value(m[:if_partial_static_stability_ij][1, 3])
@show value(m[:if_partial_static_stability_ij][3, 1])
@show value(m[:if_partial_static_stability_ij][2, 3])
@show value(m[:if_partial_static_stability_ij][3, 2])

@show value(m[:if1_equal_numbers][1, 2])
@show value(m[:if1_equal_numbers][2, 1])
@show value(m[:if1_equal_numbers][1, 3])
@show value(m[:if1_equal_numbers][3, 1])
@show value(m[:if1_equal_numbers][2, 3])
@show value(m[:if1_equal_numbers][3, 2])

@show value(m[:if2_geq_0][1, 2])
@show value(m[:if2_geq_0][2, 1])
@show value(m[:if2_geq_0][1, 3])
@show value(m[:if2_geq_0][3, 1])
@show value(m[:if2_geq_0][2, 3])
@show value(m[:if2_geq_0][3, 2])


@show value(m[:if3_x_axis][1, 2])
@show value(m[:if3_x_axis][2, 1])
@show value(m[:if3_x_axis][1, 3])
@show value(m[:if3_x_axis][3, 1])
@show value(m[:if3_x_axis][2, 3])
@show value(m[:if3_x_axis][3, 2])

@show value(m[:if4_x_axis][1, 2])
@show value(m[:if4_x_axis][2, 1])
@show value(m[:if4_x_axis][1, 3])
@show value(m[:if4_x_axis][3, 1])
@show value(m[:if4_x_axis][2, 3])
@show value(m[:if4_x_axis][3, 2])

@show value(m[:if5_y_axis][1, 2])
@show value(m[:if5_y_axis][2, 1])
@show value(m[:if5_y_axis][1, 3])
@show value(m[:if5_y_axis][3, 1])
@show value(m[:if5_y_axis][2, 3])
@show value(m[:if5_y_axis][3, 2])

@show value(m[:if6_y_axis][1, 2])
@show value(m[:if6_y_axis][2, 1])
@show value(m[:if6_y_axis][1, 3])
@show value(m[:if6_y_axis][3, 1])
@show value(m[:if6_y_axis][2, 3])
@show value(m[:if6_y_axis][3, 2])
"""

"""
@show value(m[:max_flbx_ij][1, 2])
@show value(m[:max_flbx_ij][2, 1])
@show value(m[:max_flbx_ij][1, 3])
@show value(m[:max_flbx_ij][3, 1])
@show value(m[:max_flbx_ij][2, 3])
@show value(m[:max_flbx_ij][3, 2])

@show value(m[:max_flby_ij][1, 2])
@show value(m[:max_flby_ij][2, 1])
@show value(m[:max_flby_ij][1, 3])
@show value(m[:max_flby_ij][3, 1])
@show value(m[:max_flby_ij][2, 3])
@show value(m[:max_flby_ij][3, 2])

@show value(m[:min_flbx_ij][1, 2])
@show value(m[:min_flbx_ij][2, 1])
@show value(m[:min_flbx_ij][1, 3])
@show value(m[:min_flbx_ij][3, 1])
@show value(m[:min_flbx_ij][2, 3])
@show value(m[:min_flbx_ij][3, 2])

@show value(m[:min_flby_ij][1, 2])
@show value(m[:min_flby_ij][2, 1])
@show value(m[:min_flby_ij][1, 3])
@show value(m[:min_flby_ij][3, 1])
@show value(m[:min_flby_ij][2, 3])
@show value(m[:min_flby_ij][3, 2])

@show value(m[:x_axis_covered][1, 2])
@show value(m[:x_axis_covered][2, 1])
@show value(m[:x_axis_covered][1, 3])
@show value(m[:x_axis_covered][3, 1])
@show value(m[:x_axis_covered][2, 3])
@show value(m[:x_axis_covered][3, 2])

@show value(m[:y_axis_covered][1, 2])
@show value(m[:y_axis_covered][2, 1])
@show value(m[:y_axis_covered][1, 3])
@show value(m[:y_axis_covered][3, 1])
@show value(m[:y_axis_covered][2, 3])
@show value(m[:y_axis_covered][3, 2])

@show value(m[:piecewise1][1, 2])
@show value(m[:piecewise1][2, 1])
@show value(m[:piecewise1][1, 3])
@show value(m[:piecewise1][3, 1])
@show value(m[:piecewise1][2, 3])
@show value(m[:piecewise1][3, 2])

@show value(m[:piecewise2][1, 2])
@show value(m[:piecewise2][2, 1])
@show value(m[:piecewise2][1, 3])
@show value(m[:piecewise2][3, 1])
@show value(m[:piecewise2][2, 3])
@show value(m[:piecewise2][3, 2])

@show value(m[:piecewise_partial_static_stability][1, 2])
@show value(m[:piecewise_partial_static_stability][2, 1])
@show value(m[:piecewise_partial_static_stability][1, 3])
@show value(m[:piecewise_partial_static_stability][3, 1])
@show value(m[:piecewise_partial_static_stability][2, 3])
@show value(m[:piecewise_partial_static_stability][3, 2])
"""


"""
@show value(m[:flbx_front_left_bot_x][1])
@show value(m[:flbx_front_left_bot_x][2])
@show value(m[:flbx_front_left_bot_x][3])
@show value(m[:flby_front_left_bot_y][1])
@show value(m[:flby_front_left_bot_y][2])
@show value(m[:flby_front_left_bot_y][3])
@show value(m[:flbz_front_left_bot_z][1])
@show value(m[:flbz_front_left_bot_z][2])
@show value(m[:flbz_front_left_bot_z][3])
"""



"""

for i in 1:length(boxes)
    for j in 1:length(boxes)
        if i == j
            continue
        end
        @show value(m[:if1_eq_flbx][i, j])
    end
end

@show value(m[:guillotine_flbx][1, 2])
@show value(m[:guillotine_flbx][1, 3])
@show value(m[:guillotine_flbx][2, 1])
@show value(m[:guillotine_flbx][2, 3])
@show value(m[:guillotine_flbx][3, 1])
@show value(m[:guillotine_flbx][3, 2])

@show value(m[:guillotine_flbx_ij_plus][1, 2])
@show value(m[:guillotine_flbx_ij_plus][1, 3])
@show value(m[:guillotine_flbx_ij_plus][2, 1])
@show value(m[:guillotine_flbx_ij_plus][2, 3])
@show value(m[:guillotine_flbx_ij_plus][3, 1])
@show value(m[:guillotine_flbx_ij_plus][3, 2])

@show value(m[:guillotine_flbx_i_plus][1, 2])
@show value(m[:guillotine_flbx_i_plus][1, 3])
@show value(m[:guillotine_flbx_i_plus][2, 1])
@show value(m[:guillotine_flbx_i_plus][2, 3])
@show value(m[:guillotine_flbx_i_plus][3, 1])
@show value(m[:guillotine_flbx_i_plus][3, 2])

@show value(m[:guillotine_flbx_j_plus][1, 2])
@show value(m[:guillotine_flbx_j_plus][1, 3])
@show value(m[:guillotine_flbx_j_plus][2, 1])
@show value(m[:guillotine_flbx_j_plus][2, 3])
@show value(m[:guillotine_flbx_j_plus][3, 1])
@show value(m[:guillotine_flbx_j_plus][3, 2])

@show value(m[:guillotine_height_flbx][1])
@show value(m[:guillotine_height_flbx][2])
@show value(m[:guillotine_height_flbx][3])

@show value(m[:guillotine_height_flbx_add_x_cover][1])
@show value(m[:guillotine_height_flbx_add_x_cover][2])
@show value(m[:guillotine_height_flbx_add_x_cover][3])



@show value(m[:guillotine_y][1, 2])
@show value(m[:guillotine_y][1, 3])
@show value(m[:guillotine_y][2, 3])
"""


"""
@show value(sum(m[:pb_if_obj]))
@show value(sum(m[:pb_xy_cover_objective]))
@show value(sum(m[:pb_multiplication_objective]))
@show value(0.1*sum(m[:guillotine_objective]))

@show value(sum(m[:guillotine_equalities_objective]))
@show value(sum(m[:guillotine_range_objective]))
@show value(sum(m[:guillotine_and_objective]))
@show value(0.001 * sum(m[:guillotine_interval_objective]))

@show value(sum(m[:max_guillotine_cut_x_left_ij]))
@show value(sum(m[:max_guillotine_cut_x_left_i]))
@show value(sum(m[:min_guillotine_cut_x_left_flbx_ij]))
@show value(sum(m[:min_guillotine_cut_x_left_j_plus_ij]))
@show value(sum(m[:min_guillotine_cut_x_left_ij]))
@show value(sum(m[:min_guillotine_cut_x_left_i]))

@show value(sum(m[:max_guillotine_cut_x_right_ij]))
@show value(sum(m[:max_guillotine_cut_x_right_i]))
@show value(sum(m[:min_guillotine_cut_x_right_ij_plus_ij]))
@show value(sum(m[:min_guillotine_cut_x_right_i_plus_ij]))
@show value(sum(m[:min_guillotine_cut_x_right_ij]))
@show value(sum(m[:min_guillotine_cut_x_right_i]))

@show value(sum(m[:max_guillotine_cut_y_left_ij]))
@show value(sum(m[:max_guillotine_cut_y_left_i]))
@show value(sum(m[:min_guillotine_cut_y_left_flby_ij]))
@show value(sum(m[:min_guillotine_cut_y_left_j_plus_ij]))
@show value(sum(m[:min_guillotine_cut_y_left_ij]))
@show value(sum(m[:min_guillotine_cut_y_left_i]))

@show value(sum(m[:max_guillotine_cut_y_right_ij]))
@show value(sum(m[:max_guillotine_cut_y_right_i]))
@show value(sum(m[:min_guillotine_cut_y_right_ij_plus_ij]))
@show value(sum(m[:min_guillotine_cut_y_right_i_plus_ij]))
@show value(sum(m[:min_guillotine_cut_y_right_ij]))
@show value(sum(m[:min_guillotine_cut_y_right_i]))

"""

"""
@show(value(m[:guillotine_flbx][1, 2]))
@show(value(m[:guillotine_flbx][2, 1]))
@show(value(m[:guillotine_flbx][1, 3]))
@show(value(m[:guillotine_flbx][3, 1]))
@show(value(m[:guillotine_flbx][2, 3]))
@show(value(m[:guillotine_flbx][3, 2]))

@show(value(m[:guillotine_flbx_j_plus][1, 2]))
@show(value(m[:guillotine_flbx_j_plus][2, 1]))
@show(value(m[:guillotine_flbx_j_plus][1, 3]))
@show(value(m[:guillotine_flbx_j_plus][3, 1]))
@show(value(m[:guillotine_flbx_j_plus][2, 3]))
@show(value(m[:guillotine_flbx_j_plus][3, 2]))

@show(value(m[:min_guillotine_cut_x_left_flbx_ij][1, 2]))
@show(value(m[:min_guillotine_cut_x_left_flbx_ij][2, 1]))
@show(value(m[:min_guillotine_cut_x_left_flbx_ij][1, 3]))
@show(value(m[:min_guillotine_cut_x_left_flbx_ij][3, 1]))
@show(value(m[:min_guillotine_cut_x_left_flbx_ij][2, 3]))
@show(value(m[:min_guillotine_cut_x_left_flbx_ij][3, 2]))

@show(value(m[:min_guillotine_cut_x_left_j_plus_ij][1, 2]))
@show(value(m[:min_guillotine_cut_x_left_j_plus_ij][2, 1]))
@show(value(m[:min_guillotine_cut_x_left_j_plus_ij][1, 3]))
@show(value(m[:min_guillotine_cut_x_left_j_plus_ij][3, 1]))
@show(value(m[:min_guillotine_cut_x_left_j_plus_ij][2, 3]))
@show(value(m[:min_guillotine_cut_x_left_j_plus_ij][3, 2]))

@show(value(m[:min_guillotine_cut_x_left_ij][1, 2]))
@show(value(m[:min_guillotine_cut_x_left_ij][2, 1]))
@show(value(m[:min_guillotine_cut_x_left_ij][1, 3]))
@show(value(m[:min_guillotine_cut_x_left_ij][3, 1]))
@show(value(m[:min_guillotine_cut_x_left_ij][2, 3]))
@show(value(m[:min_guillotine_cut_x_left_ij][3, 2]))

@show value(m[:min_guillotine_cut_x_left_i][1])
@show value(m[:min_guillotine_cut_x_left_i][2])  
@show value(m[:min_guillotine_cut_x_left_i][3])

"""

"""
@show value(m[:cut_x_flbx_left][1])
    @show value(m[:cut_x_flbx_j_plus_left][1]) 
    @show value(m[:cut_x_flbx_i_plus_right][1])
    @show value(m[:cut_x_flbx_ij_plus_right][1])  

    @show value(m[:cut_x_flbx_left][2])
    @show value(m[:cut_x_flbx_j_plus_left][2]) 
    @show value(m[:cut_x_flbx_i_plus_right][2])
    @show value(m[:cut_x_flbx_ij_plus_right][2]) 
    
    @show value(m[:cut_x_flbx_left][3])
    @show value(m[:cut_x_flbx_j_plus_left][3]) 
    @show value(m[:cut_x_flbx_i_plus_right][3])
    @show value(m[:cut_x_flbx_ij_plus_right][3]) 

    @show value(m[:cut_y_flby_right][1])
    @show value(m[:cut_y_flby_j_plus_right][1]) 
    @show value(m[:cut_y_flby_i_plus_left][1])
    @show value(m[:cut_y_flby_ij_plus_left][1])  

    @show value(m[:cut_y_flby_right][2])
    @show value(m[:cut_y_flby_j_plus_right][2]) 
    @show value(m[:cut_y_flby_i_plus_left][2])
    @show value(m[:cut_y_flby_ij_plus_left][2]) 
    
    @show value(m[:cut_y_flby_right][3])
    @show value(m[:cut_y_flby_j_plus_right][3]) 
    @show value(m[:cut_y_flby_i_plus_left][3])
    @show value(m[:cut_y_flby_ij_plus_left][3]) 



    @show(value(m[:guillotine_flbx][1, 2]))
    @show(value(m[:guillotine_flbx][2, 1]))
    @show(value(m[:guillotine_flbx][1, 3]))
    @show(value(m[:guillotine_flbx][3, 1]))
    @show(value(m[:guillotine_flbx][2, 3]))
    @show(value(m[:guillotine_flbx][3, 2]))

    @show(value(m[:guillotine_flbx_j_plus][1, 2]))
    @show(value(m[:guillotine_flbx_j_plus][2, 1]))
    @show(value(m[:guillotine_flbx_j_plus][1, 3]))
    @show(value(m[:guillotine_flbx_j_plus][3, 1]))
    @show(value(m[:guillotine_flbx_j_plus][2, 3]))
    @show(value(m[:guillotine_flbx_j_plus][3, 2]))

    @show(value(m[:guillotine_flbx_i_plus][1, 2]))
    @show(value(m[:guillotine_flbx_i_plus][2, 1]))
    @show(value(m[:guillotine_flbx_i_plus][1, 3]))
    @show(value(m[:guillotine_flbx_i_plus][3, 1]))
    @show(value(m[:guillotine_flbx_i_plus][2, 3]))
    @show(value(m[:guillotine_flbx_i_plus][3, 2]))

    @show(value(m[:guillotine_flbx_ij_plus][1, 2]))
    @show(value(m[:guillotine_flbx_ij_plus][2, 1]))
    @show(value(m[:guillotine_flbx_ij_plus][1, 3]))
    @show(value(m[:guillotine_flbx_ij_plus][3, 1]))
    @show(value(m[:guillotine_flbx_ij_plus][2, 3]))
    @show(value(m[:guillotine_flbx_ij_plus][3, 2]))

    @show(value(m[:guillotine_flby][1, 2]))
    @show(value(m[:guillotine_flby][2, 1]))
    @show(value(m[:guillotine_flby][1, 3]))
    @show(value(m[:guillotine_flby][3, 1]))
    @show(value(m[:guillotine_flby][2, 3]))
    @show(value(m[:guillotine_flby][3, 2]))

    @show(value(m[:guillotine_flby_j_plus][1, 2]))
    @show(value(m[:guillotine_flby_j_plus][2, 1]))
    @show(value(m[:guillotine_flby_j_plus][1, 3]))
    @show(value(m[:guillotine_flby_j_plus][3, 1]))
    @show(value(m[:guillotine_flby_j_plus][2, 3]))
    @show(value(m[:guillotine_flby_j_plus][3, 2]))


    @show(value(m[:guillotine_flby_i_plus][1, 2]))
    @show(value(m[:guillotine_flby_i_plus][2, 1]))
    @show(value(m[:guillotine_flby_i_plus][1, 3]))
    @show(value(m[:guillotine_flby_i_plus][3, 1]))
    @show(value(m[:guillotine_flby_i_plus][2, 3]))
    @show(value(m[:guillotine_flby_i_plus][3, 2]))

    @show(value(m[:guillotine_flby_ij_plus][1, 2]))
    @show(value(m[:guillotine_flby_ij_plus][2, 1]))
    @show(value(m[:guillotine_flby_ij_plus][1, 3]))
    @show(value(m[:guillotine_flby_ij_plus][3, 1]))
    @show(value(m[:guillotine_flby_ij_plus][2, 3]))
    @show(value(m[:guillotine_flby_ij_plus][3, 2]))
"""


"""
@show value(m[:sum_of_boxes_below_box_i][1])
@show value(m[:sum_of_boxes_below_box_i][2])
@show value(m[:sum_of_boxes_below_box_i][3])

@show value(m[:max_flbx_of_supporting_i][1])
@show value(m[:max_flbx_of_supporting_i][2])
@show value(m[:max_flbx_of_supporting_i][3])

@show value(m[:max_flby_of_supporting_i][1])
@show value(m[:max_flby_of_supporting_i][2])
@show value(m[:max_flby_of_supporting_i][3])

@show value(m[:min_flbx_of_supporting_i][1])
@show value(m[:min_flbx_of_supporting_i][2])
@show value(m[:min_flbx_of_supporting_i][3])

@show value(m[:min_flby_of_supporting_i][1])
@show value(m[:min_flby_of_supporting_i][2])
@show value(m[:min_flby_of_supporting_i][3])

@show value(m[:midpoint_of_support_x][1])
@show value(m[:midpoint_of_support_x][2])
@show value(m[:midpoint_of_support_x][3])

@show value(m[:midpoint_of_support_y][1])
@show value(m[:midpoint_of_support_y][2])
@show value(m[:midpoint_of_support_y][3])

@show value(m[:two_or_more_below][1])
@show value(m[:two_or_more_below][2])
@show value(m[:two_or_more_below][3])
"""


"""
@show value(m[:robot_on_top][1, 2])
@show value(m[:robot_on_top][1, 3])
@show value(m[:robot_on_top][2, 3])

@show value(m[:robot_right][1, 2])
@show value(m[:robot_right][1, 3])
@show value(m[:robot_right][2, 3])

@show value(m[:robot_behind][1, 2])
@show value(m[:robot_behind][1, 3])
@show value(m[:robot_behind][2, 3])
"""



"""
print('\n')
@show value(m[:min_cut_flbx_left_ij][2, 1])
@show value(m[:min_cut_flbx_left_ij][2, 3])
@show value(m[:min_cut_flbx_j_plus_left_ij][2, 1])
@show value(m[:min_cut_flbx_j_plus_left_ij][2, 3])
print('\n')
@show value(m[:min_cut_flbx_left_i][2])
@show value(m[:min_cut_flbx_j_plus_left_i][2])
print('\n')
@show value(m[:min_cut_flbx_i_plus_right_ij][2, 1])
@show value(m[:min_cut_flbx_i_plus_right_ij][2, 3])
@show value(m[:min_cut_flbx_ij_plus_right_ij][2, 1])
@show value(m[:min_cut_flbx_ij_plus_right_ij][2, 3])
print('\n')
@show value(m[:min_cut_flbx_i_plus_right_i][2])
@show value(m[:min_cut_flbx_ij_plus_right_i][2])
print('\n')
@show value(m[:min_cut_flby_right_ij][2, 1])
@show value(m[:min_cut_flby_right_ij][2, 3])
@show value(m[:min_cut_flby_j_plus_right_ij][2, 1])
@show value(m[:min_cut_flby_j_plus_right_ij][2, 3])
print('\n')
@show value(m[:min_cut_flby_right_i][2])
@show value(m[:min_cut_flby_j_plus_right_i][2])
print('\n')
@show value(m[:min_cut_flby_i_plus_left_ij][2, 1])
@show value(m[:min_cut_flby_i_plus_left_ij][2, 3])
@show value(m[:min_cut_flby_ij_plus_left_ij][2, 1])
@show value(m[:min_cut_flby_ij_plus_left_ij][2, 3])
print('\n')
@show value(m[:min_cut_flby_i_plus_left_i][2])
@show value(m[:min_cut_flby_ij_plus_left_i][2])

print('\n')
@show value(m[:cut_flbx_left_i][1])
@show value(m[:cut_flbx_j_plus_left_i][1])
@show value(m[:cut_flbx_i_plus_right][1])
@show value(m[:cut_flbx_ij_plus_right][1])
@show value(m[:cut_flby_right][1])
@show value(m[:cut_flby_j_plus_right][1])
@show value(m[:cut_flby_i_plus_left][1])
@show value(m[:cut_flby_ij_plus_left][1])

print('\n')
@show value(m[:cut_flbx_left_i][2])
@show value(m[:cut_flbx_j_plus_left_i][2])
@show value(m[:cut_flbx_i_plus_right][2])
@show value(m[:cut_flbx_ij_plus_right][2])
@show value(m[:cut_flby_right][2])
@show value(m[:cut_flby_j_plus_right][2])
@show value(m[:cut_flby_i_plus_left][2])
@show value(m[:cut_flby_ij_plus_left][2])

print('\n')
@show value(m[:cut_flbx_left_i][3])
@show value(m[:cut_flbx_j_plus_left_i][3])
@show value(m[:cut_flbx_i_plus_right][3])
@show value(m[:cut_flbx_ij_plus_right][3])
@show value(m[:cut_flby_right][3])
@show value(m[:cut_flby_j_plus_right][3])
@show value(m[:cut_flby_i_plus_left][3])
@show value(m[:cut_flby_ij_plus_left][3])

print('\n')
@show value(m[:pb_sum_of_mass_on_top_of_i][1])
@show value(m[:pb_sum_of_mass_on_top_of_i][2])
@show value(m[:pb_sum_of_mass_on_top_of_i][3])

print('\n')
@show value(m[:sum_of_mass_on_top_of_i][1])
@show value(m[:sum_of_mass_on_top_of_i][2])
@show value(m[:sum_of_mass_on_top_of_i][3])

print('\n')
@show max_allowed_weight[1]
@show max_allowed_weight[2]
@show max_allowed_weight[3]

print('\n')
@show value(m[:piecewise_partial_static_stability][1, 2])
@show value(m[:piecewise_partial_static_stability][1, 3])
@show value(m[:piecewise_partial_static_stability][2, 1])
@show value(m[:piecewise_partial_static_stability][2, 3])
@show value(m[:piecewise_partial_static_stability][3, 1])
@show value(m[:piecewise_partial_static_stability][3, 2])
"""

"""
for i in 1:length(boxes)-1
    for j in 1:length(boxes)-1
        if i!=j
            print(i, j, '\n')
            @show (value(m[:if1_zj_geq_zi_add_hobi_ij][i, j]))
            @show (value(m[:if2_xj_l_xi_xcoveri_ij][i, j]))
            @show (value(m[:if3_xj_xcoverj_g_xi_ij][i, j]))
            @show (value(m[:if4_yj_l_yi_ycoveri_ij][i, j]))
            @show (value(m[:if5_yj_ycoverj_g_yi_ij][i, j]))
            @show (value(m[:if_simple_lb_var][i, j]))
            @show (value(m[:accountable_mass][i, j]))
        end
    end
end
"""
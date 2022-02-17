"""
# Finn max og min av variabler slik at linearisering fungerer 
@variable(model, max_of_xy_cover[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
@constraint(model, get_max_of_xy_cover[i=1:length(boxes), j=1:length(boxes); i!=j], 
    max_of_xy_cover[i, j] .>= 
    [model[:x_axis_covered][i, j], model[:y_axis_covered][i, j]]
)

@variable(model, min_of_xy_cover[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
@constraint(model, get_min_of_xy_cover[i=1:length(boxes), j=1:length(boxes); i!=j], 
    [model[:x_axis_covered][i, j], model[:y_axis_covered][i, j]] .>= 
    model[:min_of_xy_cover][i, j]
)

#objective for max min
@expression(model, pb_multiplication_max_min_obj[i=1:length(boxes), j=1:length(boxes); i!=j],
    model[:max_of_xy_cover][i, j] +
    (max(L, W) - model[:min_of_xy_cover][i, j])
)
"""


#FOR GUILLOTINE CUT
"""

function third_dim_inequal(m)

    #We don't want to add to a guillotine height a box which covers the same space in the z-axis

    @variable(m, guillo_if_z_axis_1[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, guillo_c_if_z_axis_1[i=1:length(boxes), j=1:length(boxes); i!=j],  
        m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j] <= 
        m[:flbz_front_left_bot_z][i] + H * (1 - m[:guillo_if_z_axis_1][i, j])
    )

    @variable(m, guillo_if_z_axis_2[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, guillo_c_if_z_axis_2[i=1:length(boxes), j=1:length(boxes); i!=j],  
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i] <=
        m[:flbz_front_left_bot_z][j] + H * (1 - m[:guillo_if_z_axis_2][i, j]) 
        
    )

    # OR, as z-axis has to be either lower of higher (or equal)
    @variable(m, guillo_z_axis_inequal[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, guillo_c_z_axis_inequal[i=1:length(boxes), j=1:length(boxes); i!=j],
        m[:guillo_if_z_axis_1][i, j] + m[:guillo_if_z_axis_2][i, j] >= 
        m[:guillo_z_axis_inequal][i, j]
    )

    @expression(m, guillotine_inequalities_objective[i=1:length(boxes), j=1:length(boxes); i!=j],
        (1 - m[:guillo_z_axis_inequal][i, j])
    )


    return m
end

"""


"""
    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_x_left_flbx_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_x_left_flbx_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_x_left_flbx_ij][i, j] .>=
        [m[:guillotine_flbx][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx][i, j]) * m[:flbz_front_left_bot_z][i]]
        )   
    )

    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_x_left_j_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_x_left_j_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j],
        m[:min_guillotine_cut_x_left_j_plus_ij][i, j] .>=
        [m[:guillotine_flbx_j_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx_j_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
    )

    #the min is the min of possible cuts
    @variable(m, min_guillotine_cut_x_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_x_left_ij_1[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_x_left_flbx_ij][i, j] >=
        m[:min_guillotine_cut_x_left_ij][i, j]
        )
    )
    @constraint(m, c_min_guillotine_cut_x_left_ij_2[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_x_left_j_plus_ij][i, j] >=
        m[:min_guillotine_cut_x_left_ij][i, j]
        )
    )


    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_x_right_ij_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_x_right_ij_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_x_right_ij_plus_ij][i, j] .>=
        [m[:guillotine_flbx_ij_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx_ij_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        )   
    )

    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_x_right_i_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_x_right_i_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_x_right_i_plus_ij][i, j] .>=
        [m[:guillotine_flbx_i_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx_i_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        )
    )

    #the min is the min of possible cuts
    @variable(m, min_guillotine_cut_x_right_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_x_right_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        [m[:min_guillotine_cut_x_right_ij_plus_ij][i, j], m[:min_guillotine_cut_x_right_i_plus_ij][i, j]] .>=
        m[:min_guillotine_cut_x_right_ij][i, j]
        )
    )


    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_y_left_flby_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_y_left_flby_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_y_left_flby_ij][i, j] .>=
        [m[:guillotine_flby][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby][i, j]) * m[:flbz_front_left_bot_z][i]]
        )   
    )

    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_y_left_j_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_y_left_j_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_y_left_j_plus_ij][i, j] .>=
        [m[:guillotine_flby_j_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_j_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        )
    )

    #the min is the min of possible cuts
    @variable(m, min_guillotine_cut_y_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_y_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        [m[:min_guillotine_cut_y_left_flby_ij][i, j], m[:min_guillotine_cut_y_left_j_plus_ij][i, j]] .>=
        m[:min_guillotine_cut_y_left_ij][i, j]
        )
    )



    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_y_right_ij_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_y_right_ij_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_y_right_ij_plus_ij][i, j] .>=
        [m[:guillotine_flby_ij_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_ij_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        )   
    )

    #if guillotine is 1, then min = j, if 0, then min is i
    @variable(m, min_guillotine_cut_y_right_i_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_y_right_i_plus_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        m[:min_guillotine_cut_y_right_i_plus_ij][i, j] .>=
        [m[:guillotine_flby_i_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_i_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        )
    )

    #the min is the min of possible cuts
    @variable(m, min_guillotine_cut_y_right_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_guillotine_cut_y_right_ij[i=1:length(boxes), j=1:length(boxes); i!=j], (
        [m[:min_guillotine_cut_y_right_ij_plus_ij][i, j], m[:min_guillotine_cut_y_right_i_plus_ij][i, j]] .>=
        m[:min_guillotine_cut_y_right_ij][i, j]
        )
    )
    """


# VERSJON 2 GUILLOTINE
"""
@variable(m, min_cut_y_right_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_cut_y_right_ij[i=1:length(boxes), j=1:length(boxes); i!=j],
        m[:min_cut_y_right_ij][i, j] .>=
        [m[:guillotine_flby][i, j] * m[:flbz_front_left_bot_z][j], 
        (1 - m[:guillotine_flby][i, j]) * m[:flbz_front_left_bot_z][i],
        m[:guillotine_flby_j_plus][i, j] * m[:flbz_front_left_bot_z][j], 
        (1 - m[:guillotine_flby_j_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )

    @variable(m, min_cut_y_right_i[i=1:length(boxes)] >= 0)
    @constraint(m, c_min_cut_y_right_i[i=1:length(boxes)], 
        [m[:min_cut_y_right_ij][i, j] for j in 1:length(boxes) if i != j] .>= 
        m[:min_cut_y_right_i][i]
    )

    #Need to ensure that the min_guillotine cut must be lower than or equal to z_i
    @constraint(m, c_min_cut_y_right_ii[i=1:length(boxes)], 
        m[:flbz_front_left_bot_z][i] >= 
        m[:min_cut_y_right_i][i]
    )

    #the difference between max and min is the cut
    @expression(m, cut_y_right[i=1:length(boxes)],
        m[:max_cut_y_right_i][i] - m[:min_cut_y_right_i][i]
    )
"""

"""
    @show(value(m[:max_cut]))
    

    @show value(m[:cut_x_left][1])
    @show value(m[:cut_x_right][1])
    @show value(m[:cut_y_right][1])
    @show value(m[:cut_y_left][1])

    @show value(m[:cut_x_left][2])
    @show value(m[:cut_x_right][2])
    @show value(m[:cut_y_right][2])
    @show value(m[:cut_y_left][2])

    @show value(m[:cut_x_left][3])
    @show value(m[:cut_x_right][3])
    @show value(m[:cut_y_right][3])
    @show value(m[:cut_y_left][3])
    """
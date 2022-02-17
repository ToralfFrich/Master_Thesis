@variable(m, max_cut_y_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_max_cut_y_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:max_cut_y_left_ij][i, j] .>= 
        [m[:guillotine_flby_ij_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]), 
        m[:guillotine_flby_i_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])]
    )

    @variable(m, max_cut_y_left_i[i=1:length(boxes)] >= 0)
    @constraint(m, c_max_cut_y_left_i[i=1:length(boxes)], 
        m[:max_cut_y_left_i][i] .>= 
        [m[:max_cut_y_left_ij][i, j] for j in 1:length(boxes) if i != j]
    )
    @constraint(m, c_max_cut_y_left_ii[i=1:length(boxes)], 
        m[:max_cut_y_left_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )

    @variable(m, min_cut_flby_i_plus_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_cut_flby_i_plus_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j],
        m[:min_cut_flby_left_ij][i, j] .>= 
        [m[:guillotine_flby_i_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_i_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )
    @variable(m, min_cut_flby_ij_plus_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0)
    @constraint(m, c_min_cut_flby_ij_plus_left_ij[i=1:length(boxes), j=1:length(boxes); i!=j],
        m[:min_cut_flby_ij_plus_left_ij][i, j] .>= 
        [m[:guillotine_flby_ij_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_ij_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )

    #Find the lowest box of the j other boxes
    @variable(m, min_cut_flby_i_plus_left_i[i=1:length(boxes)] >= 0)
    @constraint(m, c_min_cut_flby_i_plus_left_i[i=1:length(boxes)], 
        [m[:min_cut_flby_i_plus_left_ij][i, j] for j in 1:length(boxes) if i != j] .>= 
        m[:min_cut_flby_i_plus_left_i][i]
    )

    @variable(m, min_cut_flby_ij_plus_left_i[i=1:length(boxes)] >= 0)
    @constraint(m, c_min_cut_flby_ij_plus_left_i[i=1:length(boxes)], 
        [m[:min_cut_flby_ij_plus_left_ij][i, j] for j in 1:length(boxes) if i != j] .>= 
        m[:min_cut_flby_ij_plus_left_i][i]
    )

    #Need to ensure that the min_guillotine cut must be lower than or equal to z_i
    @constraint(m, c_min_cut_flby_cover_left_ii[i=1:length(boxes)], 
        m[:flbz_front_left_bot_z][i] .>= 
        [m[:min_cut_flby_i_plus_left_i][i], m[:min_cut_flby_ij_plus_left_i][i]]
    )

    #the difference between max and min is the cut
    @expression(m, cut_y_flby_i_plus_left[i=1:length(boxes)], 
        m[:max_cut_y_left_i][i] - m[:min_cut_flby_i_plus_left_i][i]
    )
    @expression(m, cut_y_flby_ij_plus_left[i=1:length(boxes)], 
        m[:max_cut_y_left_i][i] - m[:min_cut_flby_ij_plus_left_i][i]
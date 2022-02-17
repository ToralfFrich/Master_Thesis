module FindInterval

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export find_interval

function find_interval(m)

    # Find max and min part of the guillotine cut to determine its height

    # flbx

    # MAX
    @variable(m, max_cut_flbx_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flbx_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flbx_left_ij][i, j] >= 
        m[:guillotine_flbx][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flbx_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flbx_left_i[i=1:length(boxes)-1], 
        m[:max_cut_flbx_left_i][i] .>= 
        [m[:max_cut_flbx_left_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )

    @constraint(m, c_max_cut_flbx_left_ii[i=1:length(boxes)-1], 
        m[:max_cut_flbx_left_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )

    @variable(m, max_cut_flbx_j_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flbx_j_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flbx_j_plus_left_ij][i, j] >= 
        m[:guillotine_flbx_j_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flbx_j_plus_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flbx_j_plus_left_i[i=1:length(boxes)-1], 
        m[:max_cut_flbx_j_plus_left_i][i] .>= 
        [m[:max_cut_flbx_j_plus_left_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )

    @constraint(m, c_max_cut_flbx_j_plus_left_ii[i=1:length(boxes)-1], 
        m[:max_cut_flbx_j_plus_left_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )


    # MIN using two possibilities
    @variable(m, min_cut_flbx_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flbx_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flbx_left_ij][i, j] .>= 
        [m[:guillotine_flbx][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx][i, j]) * m[:flbz_front_left_bot_z][i]] 
        
    )
    @variable(m, min_cut_flbx_j_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flbx_j_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flbx_j_plus_left_ij][i, j] .>=
        [m[:guillotine_flbx_j_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx_j_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )
    
    #Find the lowest box of the j other boxes
    @variable(m, min_cut_flbx_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flbx_left_i[i=1:length(boxes)-1], 
        [m[:min_cut_flbx_left_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flbx_left_i][i]
    )

    @variable(m, min_cut_flbx_j_plus_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flbx_j_plus_left_i[i=1:length(boxes)-1], 
        [m[:min_cut_flbx_j_plus_left_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flbx_j_plus_left_i][i]
    )

    #Need to ensure that the min_guillotine cut must be lower than or equal to z_i
    @constraint(m, c_min_cut_flbx_left_ii[i=1:length(boxes)-1], 
        m[:flbz_front_left_bot_z][i] .>= 
        [m[:min_cut_flbx_left_i][i], m[:min_cut_flbx_j_plus_left_i][i]]
    )

    #the difference between max and min is the cut
    @expression(m, cut_flbx_left_i[i=1:length(boxes)-1], 
        m[:max_cut_flbx_left_i][i] - m[:min_cut_flbx_left_i][i]
    )
    @expression(m, cut_flbx_j_plus_left_i[i=1:length(boxes)-1], 
        m[:max_cut_flbx_j_plus_left_i][i] - m[:min_cut_flbx_j_plus_left_i][i]
    )

    """
    @variable(m, cut_left[i=1:length(boxes)] >= 0)
    @constraint(m, c_cut_left[i=1:length(boxes)], 
        m[:cut_left][i] .>= 
        [m[:cut_flbx_left_i][i], m[:cut_flbx_j_plus_left_i][i]]
    )
    """



    

    # flbx + cover
    @variable(m, max_cut_flbx_ij_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flbx_ij_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flbx_ij_plus_right_ij][i, j] >= 
        m[:guillotine_flbx_ij_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flbx_ij_plus_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flbx_ij_plus_right_i[i=1:length(boxes)-1], 
        m[:max_cut_flbx_ij_plus_right_i][i] .>= 
        [m[:max_cut_flbx_ij_plus_right_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )
    @constraint(m, c_max_cut_flbx_ij_plus_right_ii[i=1:length(boxes)-1], 
        m[:max_cut_flbx_ij_plus_right_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )

    @variable(m, max_cut_flbx_i_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flbx_i_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flbx_i_plus_right_ij][i, j] >= 
        m[:guillotine_flbx_i_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flbx_i_plus_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flbx_i_plus_right_i[i=1:length(boxes)-1], 
        m[:max_cut_flbx_i_plus_right_i][i] .>= 
        [m[:max_cut_flbx_i_plus_right_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )
    @constraint(m, c_max_cut_flbx_i_plus_right_ii[i=1:length(boxes)-1], 
        m[:max_cut_flbx_i_plus_right_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )


    # MIN using two possibilities
    @variable(m, min_cut_flbx_i_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flbx_i_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flbx_i_plus_right_ij][i, j] .>= 
        [m[:guillotine_flbx_i_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx_i_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )
    @variable(m, min_cut_flbx_ij_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flbx_ij_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flbx_ij_plus_right_ij][i, j] .>= 
        [m[:guillotine_flbx_ij_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flbx_ij_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )

    #Find the lowest box of the j other boxes
    @variable(m, min_cut_flbx_i_plus_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flbx_i_plus_right_i[i=1:length(boxes)-1], 
        [m[:min_cut_flbx_i_plus_right_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flbx_i_plus_right_i][i]
    )

    @variable(m, min_cut_flbx_ij_plus_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flbx_ij_plus_right_i[i=1:length(boxes)-1], 
        [m[:min_cut_flbx_ij_plus_right_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flbx_ij_plus_right_i][i]
    )

    #Need to ensure that the min_guillotine cut must be lower than or equal to z_i
    @constraint(m, c_min_cut_flbx_cover_right_ii[i=1:length(boxes)-1], 
        m[:flbz_front_left_bot_z][i] .>= 
        [m[:min_cut_flbx_i_plus_right_i][i], m[:min_cut_flbx_ij_plus_right_i][i]]
    )

    #the difference between max and min is the cut
    @expression(m, cut_flbx_i_plus_right[i=1:length(boxes)-1], 
        m[:max_cut_flbx_i_plus_right_i][i] - m[:min_cut_flbx_i_plus_right_i][i]
    )
    @expression(m, cut_flbx_ij_plus_right[i=1:length(boxes)-1], 
        m[:max_cut_flbx_ij_plus_right_i][i] - m[:min_cut_flbx_ij_plus_right_i][i]
    )

    """
    @variable(m, cut_right[i=1:length(boxes)] >= 0)
    @constraint(m, c_cut_right[i=1:length(boxes)], 
        m[:cut_right][i] .>= 
        [m[:cut_flbx_i_plus_right][i], m[:cut_flbx_ij_plus_right][i]]
    )
    """






    # ===== Y AXIS =====

    # flby
    @variable(m, max_cut_flby_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flby_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flby_right_ij][i, j] >= 
        m[:guillotine_flby][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flby_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flby_right_i[i=1:length(boxes)-1], 
        m[:max_cut_flby_right_i][i] .>= 
        [m[:max_cut_flby_right_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )

    @constraint(m, c_max_cut_flby_right_ii[i=1:length(boxes)-1], 
        m[:max_cut_flby_right_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )

    @variable(m, max_cut_flby_j_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flby_j_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flby_j_plus_right_ij][i, j] >= 
        m[:guillotine_flby_j_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flby_j_plus_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flby_j_plus_right_i[i=1:length(boxes)-1], 
        m[:max_cut_flby_j_plus_right_i][i] .>= 
        [m[:max_cut_flby_j_plus_right_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )

    @constraint(m, c_max_cut_flby_j_plus_right_ii[i=1:length(boxes)-1], 
        m[:max_cut_flby_j_plus_right_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )


    # MIN using two possibilities
    @variable(m, min_cut_flby_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flby_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flby_right_ij][i, j] .>= 
        [m[:guillotine_flby][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )
    @variable(m, min_cut_flby_j_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flby_j_plus_right_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flby_j_plus_right_ij][i, j] .>= 
        [m[:guillotine_flby_j_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_j_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )
    
    #Find the lowest box of the j other boxes
    @variable(m, min_cut_flby_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flby_right_i[i=1:length(boxes)-1], 
        [m[:min_cut_flby_right_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flby_right_i][i]
    )

    @variable(m, min_cut_flby_j_plus_right_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flby_j_plus_right_i[i=1:length(boxes)-1], 
        [m[:min_cut_flby_j_plus_right_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flby_j_plus_right_i][i]
    )

    #Need to ensure that the min_guillotine cut must be lower than or equal to z_i
    @constraint(m, c_min_cut_flby_cover_right_ii[i=1:length(boxes)-1], 
        m[:flbz_front_left_bot_z][i] .>= 
        [m[:min_cut_flby_right_i][i], m[:min_cut_flby_j_plus_right_i][i]]
    )

    #the difference between max and min is the cut
    @expression(m, cut_flby_right[i=1:length(boxes)-1], 
        m[:max_cut_flby_right_i][i] - m[:min_cut_flby_right_i][i]
    )
    @expression(m, cut_flby_j_plus_right[i=1:length(boxes)-1], 
        m[:max_cut_flby_j_plus_right_i][i] - m[:min_cut_flby_j_plus_right_i][i]
    )

    """
    @variable(m, cut_right[i=1:length(boxes)] >= 0)
    @constraint(m, c_cut_right[i=1:length(boxes)], 
        m[:cut_right][i] .>= 
        [m[:cut_flby_right][i], m[:cut_flby_j_plus_right][i]]
    )
    """





    # flby + cover
    @variable(m, max_cut_flby_ij_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flby_ij_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flby_ij_plus_left_ij][i, j] >= 
        m[:guillotine_flby_ij_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flby_ij_plus_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flby_ij_plus_left_i[i=1:length(boxes)-1], 
        m[:max_cut_flby_ij_plus_left_i][i] .>= 
        [m[:max_cut_flby_ij_plus_left_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )
    @constraint(m, c_max_cut_flby_ij_plus_left_ii[i=1:length(boxes)-1], 
        m[:max_cut_flby_ij_plus_left_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )

    @variable(m, max_cut_flby_i_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_max_cut_flby_i_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:max_cut_flby_i_plus_left_ij][i, j] >= 
        m[:guillotine_flby_i_plus][i, j] * (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j])
    )

    @variable(m, max_cut_flby_i_plus_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_max_cut_flby_i_plus_left_i[i=1:length(boxes)-1], 
        m[:max_cut_flby_i_plus_left_i][i] .>= 
        [m[:max_cut_flby_i_plus_left_ij][i, j] for j in 1:length(boxes)-1 if i != j]
    )
    @constraint(m, c_max_cut_flby_i_plus_left_ii[i=1:length(boxes)-1], 
        m[:max_cut_flby_i_plus_left_i][i] >= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )



    @variable(m, min_cut_flby_i_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flby_i_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flby_i_plus_left_ij][i, j] .>= 
        [m[:guillotine_flby_i_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_i_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )
    @variable(m, min_cut_flby_ij_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0)
    @constraint(m, c_min_cut_flby_ij_plus_left_ij[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        m[:min_cut_flby_ij_plus_left_ij][i, j] .>= 
        [m[:guillotine_flby_ij_plus][i, j] * m[:flbz_front_left_bot_z][j], (1 - m[:guillotine_flby_ij_plus][i, j]) * m[:flbz_front_left_bot_z][i]]
        
    )
    
    #Find the lowest box of the j other boxes
    @variable(m, min_cut_flby_i_plus_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flby_i_plus_left_i[i=1:length(boxes)-1], 
        [m[:min_cut_flby_i_plus_left_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flby_i_plus_left_i][i]
    )

    @variable(m, min_cut_flby_ij_plus_left_i[i=1:length(boxes)-1] >= 0)
    @constraint(m, c_min_cut_flby_ij_plus_left_i[i=1:length(boxes)-1], 
        [m[:min_cut_flby_ij_plus_left_ij][i, j] for j in 1:length(boxes)-1 if i != j] .>= 
        m[:min_cut_flby_ij_plus_left_i][i]
    )

    #Need to ensure that the min_guillotine cut must be lower than or equal to z_i
    @constraint(m, c_min_cut_flby_cover_left_ii[i=1:length(boxes)-1], 
        m[:flbz_front_left_bot_z][i] .>= 
        [m[:min_cut_flby_i_plus_left_i][i], m[:min_cut_flby_ij_plus_left_i][i]]
    )

    #the difference between max and min is the cut
    @expression(m, cut_flby_i_plus_left[i=1:length(boxes)-1], 
        m[:max_cut_flby_i_plus_left_i][i] - m[:min_cut_flby_i_plus_left_i][i]
    )
    @expression(m, cut_flby_ij_plus_left[i=1:length(boxes)-1], 
        m[:max_cut_flby_ij_plus_left_i][i] - m[:min_cut_flby_ij_plus_left_i][i]
    )

    """
    @variable(m, cut_left[i=1:length(boxes)] >= 0)
    @constraint(m, c_cut_left[i=1:length(boxes)], 
        m[:cut_left][i] .>= 
        [m[:cut_flby_i_plus_left][i], m[:cut_flby_ij_plus_left][i]]
    )

    
    @variable(m, max_cut >= 0)
    @constraints(m, begin
        m[:max_cut] .>= [m[:cut_left][i] for i in 1:length(boxes)]
        m[:max_cut] .>= [m[:cut_right][i] for i in 1:length(boxes)]
        m[:max_cut] .>= [m[:cut_left][i] for i in 1:length(boxes)]
        m[:max_cut] .>= [m[:cut_right][i] for i in 1:length(boxes)]    
    end)
    """
    
    
    @expression(m, guillotine_interval_objective[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j],
        #xleft
        0.5 * m[:max_cut_flbx_left_ij][i, j] +
        0.5 * m[:max_cut_flbx_left_i][i] +
        0.5 * m[:max_cut_flbx_j_plus_left_ij][i, j] +
        0.5 * m[:max_cut_flbx_j_plus_left_i][i] +
        10 * m[:min_cut_flbx_left_ij][i, j] +
        10 * m[:min_cut_flbx_j_plus_left_ij][i, j] +
        8 * (H - m[:min_cut_flbx_left_i][i]) +
        8 * (H - m[:min_cut_flbx_j_plus_left_i][i]) +
        #0.00000001 * m[:cut_left][i] +

        #xright
        0.5 * m[:max_cut_flbx_ij_plus_right_ij][i, j] +
        0.5 * m[:max_cut_flbx_ij_plus_right_i][i] +
        0.5 * m[:max_cut_flbx_i_plus_right_ij][i, j] +
        0.5 * m[:max_cut_flbx_i_plus_right_i][i] +
        10 * m[:min_cut_flbx_i_plus_right_ij][i, j] +
        10 * m[:min_cut_flbx_ij_plus_right_ij][i, j] +
        8 * (H - m[:min_cut_flbx_i_plus_right_i][i]) +
        8 * (H - m[:min_cut_flbx_ij_plus_right_i][i]) +
        #0.00000001 * m[:cut_right][i] +

        #yleft
        0.5 * m[:max_cut_flby_right_ij][i, j] +
        0.5 * m[:max_cut_flby_right_i][i] +
        0.5 * m[:max_cut_flby_j_plus_right_ij][i, j] +
        0.5 * m[:max_cut_flby_j_plus_right_i][i] +
        10 * m[:min_cut_flby_right_ij][i, j] +
        10 * m[:min_cut_flby_j_plus_right_ij][i, j] +
        8 * (H - m[:min_cut_flby_right_i][i]) +
        8 * (H - m[:min_cut_flby_j_plus_right_i][i]) +
        #0.00000001 * m[:cut_right][i] +

        #yleft
        0.5 * m[:max_cut_flby_ij_plus_left_ij][i, j] +
        0.5 * m[:max_cut_flby_ij_plus_left_i][i] +
        0.5 * m[:max_cut_flby_i_plus_left_ij][i, j] +
        0.5 * m[:max_cut_flby_i_plus_left_i][i] +
        10 * m[:min_cut_flby_i_plus_left_ij][i, j] +
        10 * m[:min_cut_flby_ij_plus_left_ij][i, j] +
        8 * (H - m[:min_cut_flby_i_plus_left_i][i]) +
        8 * (H - m[:min_cut_flby_ij_plus_left_i][i])
        #0.00000001 * m[:cut_left][i]

        #0.00001 * m[:max_cut]
    )
    return m
end

end
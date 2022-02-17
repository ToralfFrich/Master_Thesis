module IfSimpleLoadBearing

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export if_simple_lb

function if_simple_lb(m)

    #Basically just check whether box j is located right above box i

    # Zj >= Zi + hobi
    @variable(m, if1_zj_geq_zi_add_hobi_ij[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c_if1_zj_geq_zi_add_hobi_ij1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * (1 - m[:if1_zj_geq_zi_add_hobi_ij][i, j]) >= 
        (m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]) - m[:flbz_front_left_bot_z][j]
    )

    @constraint(m, c_if1_zj_geq_zi_add_hobi_ij2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * m[:if1_zj_geq_zi_add_hobi_ij][i, j] >= 
        m[:flbz_front_left_bot_z][j] - (m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]) + 0.001
    )


    # Xj < Xi + Xcoveri
    @variable(m, if2_xj_l_xi_xcoveri_ij[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c_if2_xj_l_xi_xcoveri_ij1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * (1 - m[:if2_xj_l_xi_xcoveri_ij][i, j]) >= 
        m[:flbx_front_left_bot_x][j] + 0.001 - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i])
    )

    @constraint(m, c_if2_xj_l_xi_xcoveri_ij2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * m[:if2_xj_l_xi_xcoveri_ij][i, j] >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - m[:flbx_front_left_bot_x][j] - 0.001
    )

    # Xj + Xcoverj < Xi
    @variable(m, if3_xj_xcoverj_g_xi_ij[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c_if3_xj_xcoverj_g_xi_ij1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * (1 - m[:if3_xj_xcoverj_g_xi_ij][i, j]) >= 
        m[:flbx_front_left_bot_x][i] + 0.001 - (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j])
    )

    @constraint(m, c_if3_xj_xcoverj_g_xi_ij2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * m[:if3_xj_xcoverj_g_xi_ij][i, j] >= 
        (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - m[:flbx_front_left_bot_x][i] - 0.001
    )

    # Yj < Yi + Ycoveri
    @variable(m, if4_yj_l_yi_ycoveri_ij[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c_if4_yj_l_yi_ycoveri_ij1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * (1 - m[:if4_yj_l_yi_ycoveri_ij][i, j]) >= 
        m[:flby_front_left_bot_y][j] + 0.001 - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i])
    )

    @constraint(m, c_if4_yj_l_yi_ycoveri_ij2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * m[:if4_yj_l_yi_ycoveri_ij][i, j] >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - m[:flby_front_left_bot_y][j] - 0.001
    )

    # Yj < Yi + Ycoveri
    @variable(m, if5_yj_ycoverj_g_yi_ij[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c_if5_yj_ycoverj_g_yi_ij1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * (1 - m[:if5_yj_ycoverj_g_yi_ij][i, j]) >= 
        m[:flby_front_left_bot_y][i] + 0.001 - (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j])
    )

    @constraint(m, c_if5_yj_ycoverj_g_yi_ij2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * m[:if5_yj_ycoverj_g_yi_ij][i, j] >= 
        (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - m[:flby_front_left_bot_y][i] - 0.001
    )

    #attempt at advanced AND 
    @variable(m, if_simple_lb_var[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c_if_simple_lb1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:if_simple_lb_var][i, j] >=
        m[:if1_zj_geq_zi_add_hobi_ij][i, j] + 
        m[:if2_xj_l_xi_xcoveri_ij][i, j] + 
        m[:if3_xj_xcoverj_g_xi_ij][i, j] + 
        m[:if4_yj_l_yi_ycoveri_ij][i, j] + 
        m[:if5_yj_ycoverj_g_yi_ij][i, j] - 4
    )

    #@expression(m, if_simple_lb_objective[i=1:length(boxes), j=1:length(boxes); i!=j],
    #    (1 - m[:if_simple_lb_var][i, j])
    #)
    return m
end

end
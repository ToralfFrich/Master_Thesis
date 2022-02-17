module Equalities

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export first_dim_equality

function first_dim_equality(m)

    # 1 flbxi == flbxj
    @variable(m, if11_eq_flbx[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flbx[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flbx[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    #Lz1 >= xi-xj+e
    #L(1-z1) >= xj-xi-e
    @constraint(m, if_eq_flbx_11[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if11_eq_flbx][i, j] >= 
        m[:flbx_front_left_bot_x][i] - m[:flbx_front_left_bot_x][j] + 0.0001
    )
    @constraint(m, if_eq_flbx_12[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if11_eq_flbx][i, j]) >= 
        m[:flbx_front_left_bot_x][j] - m[:flbx_front_left_bot_x][i] - 0.0001
    )

    #Lz2 >= xj-xi+e
    #L(1-z2) >= xi-xj-e
    @constraint(m, if_eq_flbx_13[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if12_eq_flbx][i, j] >= 
        m[:flbx_front_left_bot_x][j] - m[:flbx_front_left_bot_x][i] + 0.0001
    )
    @constraint(m, if_eq_flbx_14[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if12_eq_flbx][i, j]) >= 
        m[:flbx_front_left_bot_x][i] - m[:flbx_front_left_bot_x][j] - 0.0001
    )

    @constraint(m, if1_eq_flbx_cons[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flbx][i, j] + m[:if12_eq_flbx][i, j] >= 
        2 * m[:if1_eq_flbx][i, j]
    )

    # 2 flbxi + box_x_axis_cover_i == flbxj + box_x_axis_cover_j
    @variable(m, if11_eq_flbx_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flbx_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flbx_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    @constraint(m, if_eq_flbx_11_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if11_eq_flbx_ij_plus][i, j] >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) + 0.0001
    )
    @constraint(m, if_eq_flbx_12_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if11_eq_flbx_ij_plus][i, j]) >= 
        (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - 0.0001
    )
    @constraint(m, if_eq_flbx_13_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if12_eq_flbx_ij_plus][i, j] >= 
        (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) + 0.0001
    )
    @constraint(m, if_eq_flbx_14_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if12_eq_flbx_ij_plus][i, j]) >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - 0.0001
    )

    @constraint(m, if1_eq_flbx_cons_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flbx_ij_plus][i, j] + m[:if12_eq_flbx_ij_plus][i, j] >= 
        2 * m[:if1_eq_flbx_ij_plus][i, j]
    )


    # 3 flbxi + box_x_axis_cover_i == flbxj
    @variable(m, if11_eq_flbx_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flbx_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flbx_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    @constraint(m, if_eq_flbx_11_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if11_eq_flbx_i_plus][i, j] >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - m[:flbx_front_left_bot_x][j] + 0.0001
    )
    @constraint(m, if_eq_flbx_12_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if11_eq_flbx_i_plus][i, j]) >= 
        m[:flbx_front_left_bot_x][j] - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - 0.0001
    )
    @constraint(m, if_eq_flbx_13_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if12_eq_flbx_i_plus][i, j] >= 
        m[:flbx_front_left_bot_x][j] - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) + 0.0001
    )
    @constraint(m, if_eq_flbx_14_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if12_eq_flbx_i_plus][i, j]) >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - m[:flbx_front_left_bot_x][j] - 0.0001
    )

    @constraint(m, if1_eq_flbx_cons_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flbx_i_plus][i, j] + m[:if12_eq_flbx_i_plus][i, j] >= 
        2 * m[:if1_eq_flbx_i_plus][i, j]
    )

    # 4 flbxj + box_x_axis_cover_j == flbxi
    @variable(m, if11_eq_flbx_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flbx_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flbx_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    @constraint(m, if_eq_flbx_11_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if11_eq_flbx_j_plus][i, j] >= 
        m[:flbx_front_left_bot_x][i] - (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) + 0.0001
    )
    @constraint(m, if_eq_flbx_12_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if11_eq_flbx_j_plus][i, j]) >= 
        (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - m[:flbx_front_left_bot_x][i] - 0.0001
    )
    @constraint(m, if_eq_flbx_13_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if12_eq_flbx_j_plus][i, j] >= 
        (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - m[:flbx_front_left_bot_x][i] + 0.0001
    )
    @constraint(m, if_eq_flbx_14_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if12_eq_flbx_j_plus][i, j]) >= 
        m[:flbx_front_left_bot_x][i] - (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - 0.0001
    )

    @constraint(m, if1_eq_flbx_cons_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flbx_j_plus][i, j] + m[:if12_eq_flbx_j_plus][i, j] >= 
        2 * m[:if1_eq_flbx_j_plus][i, j]
    )


    # ==== Y AXIS =====

    # 1 flbyi == flbyj
    @variable(m, if11_eq_flby[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flby[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flby[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    #Wz1 >= yi-yj+e
    #W(1-z1) >= yj-yi-e
    @constraint(m, if_eq_flby_11[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if11_eq_flby][i, j] >= 
        m[:flby_front_left_bot_y][i] - m[:flby_front_left_bot_y][j] + 0.0001
    )
    @constraint(m, if_eq_flby_12[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if11_eq_flby][i, j]) >= 
        m[:flby_front_left_bot_y][j] - m[:flby_front_left_bot_y][i] - 0.0001
    )

    #Wz2 >= yj-yi+e
    #W(1-z2) >= yi-yj-e
    @constraint(m, if_eq_flby_13[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if12_eq_flby][i, j] >= 
        m[:flby_front_left_bot_y][j] - m[:flby_front_left_bot_y][i] + 0.0001
    )
    @constraint(m, if_eq_flby_14[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if12_eq_flby][i, j]) >= 
        m[:flby_front_left_bot_y][i] - m[:flby_front_left_bot_y][j] - 0.0001
    )

    @constraint(m, if1_eq_flby_cons[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flby][i, j] + m[:if12_eq_flby][i, j] >= 
        2 * m[:if1_eq_flby][i, j]
    )

    # 2 flbyi + box_y_axis_cover_i == flbyj + box_y_axis_cover_j
    @variable(m, if11_eq_flby_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flby_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flby_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    @constraint(m, if_eq_flby_11_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if11_eq_flby_ij_plus][i, j] >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) + 0.0001
    )
    @constraint(m, if_eq_flby_12_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if11_eq_flby_ij_plus][i, j]) >= 
        (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - 0.0001
    )
    @constraint(m, if_eq_flby_13_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if12_eq_flby_ij_plus][i, j] >= 
        (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) + 0.0001
    )
    @constraint(m, if_eq_flby_14_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if12_eq_flby_ij_plus][i, j]) >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - 0.0001
    )

    @constraint(m, if1_eq_flby_cons_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flby_ij_plus][i, j] + m[:if12_eq_flby_ij_plus][i, j] >= 
        2 * m[:if1_eq_flby_ij_plus][i, j]
    )


    # 3 flbyi + box_y_axis_cover_i == flbyj
    @variable(m, if11_eq_flby_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flby_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flby_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    @constraint(m, if_eq_flby_11_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if11_eq_flby_i_plus][i, j] >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - m[:flby_front_left_bot_y][j] + 0.0001
    )
    @constraint(m, if_eq_flby_12_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if11_eq_flby_i_plus][i, j]) >= 
        m[:flby_front_left_bot_y][j] - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - 0.0001
    )
    @constraint(m, if_eq_flby_13_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if12_eq_flby_i_plus][i, j] >= 
        m[:flby_front_left_bot_y][j] - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) + 0.0001
    )
    @constraint(m, if_eq_flby_14_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if12_eq_flby_i_plus][i, j]) >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - m[:flby_front_left_bot_y][j] - 0.0001
    )

    @constraint(m, if1_eq_flby_cons_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flby_i_plus][i, j] + m[:if12_eq_flby_i_plus][i, j] >= 
        2 * m[:if1_eq_flby_i_plus][i, j]
    )

    # 4 flbyj + box_y_axis_cover_j == flbyi
    @variable(m, if11_eq_flby_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if12_eq_flby_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @variable(m, if1_eq_flby_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j] >= 0, Bin)

    @constraint(m, if_eq_flby_11_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if11_eq_flby_j_plus][i, j] >= 
        m[:flby_front_left_bot_y][i] - (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) + 0.0001
    )
    @constraint(m, if_eq_flby_12_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if11_eq_flby_j_plus][i, j]) >= 
        (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - m[:flby_front_left_bot_y][i] - 0.0001
    )
    @constraint(m, if_eq_flby_13_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if12_eq_flby_j_plus][i, j] >= 
        (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - m[:flby_front_left_bot_y][i] + 0.0001
    )
    @constraint(m, if_eq_flby_14_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if12_eq_flby_j_plus][i, j]) >= 
        m[:flby_front_left_bot_y][i] - (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - 0.0001
    )

    @constraint(m, if1_eq_flby_cons_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if11_eq_flby_j_plus][i, j] + m[:if12_eq_flby_j_plus][i, j] >= 
        2 * m[:if1_eq_flby_j_plus][i, j]
    )

    @expression(m, guillotine_equalities_objective[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        #X
        (1 - m[:if1_eq_flbx][i, j]) +
        (1 - m[:if1_eq_flbx_i_plus][i, j]) +
        (1 - m[:if1_eq_flbx_j_plus][i, j]) +
        (1 - m[:if1_eq_flbx_ij_plus][i, j]) +

        #Y
        (1 - m[:if1_eq_flby][i, j]) +
        (1 - m[:if1_eq_flby_i_plus][i, j]) +
        (1 - m[:if1_eq_flby_j_plus][i, j]) +
        (1 - m[:if1_eq_flby_ij_plus][i, j])
    )

    return m
end

end



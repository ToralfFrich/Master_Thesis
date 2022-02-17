module RPEqualities

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export rp_equalities

function rp_equalities(m)

    #Check if zi + heighti == zj. 
    @variable(m, ifz1_on_top[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @variable(m, ifz2_on_top[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @variable(m, ifz_on_top[i=1:length(boxes)-2, j=(i+1):length(boxes)-1] >= 0, Bin)

    @constraint(m, cz1_on_top1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * m[:ifz1_on_top][i, j] >= 
        (m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]) - m[:flbz_front_left_bot_z][j] + 0.001
    )
    @constraint(m, cz1_on_top2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * (1 - m[:ifz1_on_top][i, j]) >= 
        m[:flbz_front_left_bot_z][j] - (m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][j]) - 0.001
    )

    @constraint(m, cz2_on_top1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * m[:ifz2_on_top][i, j] >= 
        m[:flbz_front_left_bot_z][j] - (m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]) + 0.001
    )
    @constraint(m, cz2_on_top2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * (1 - m[:ifz2_on_top][i, j]) >= 
        (m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]) - m[:flbz_front_left_bot_z][j] - 0.001
    )

    @constraint(m, cz_on_top[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:ifz1_on_top][i, j] + m[:ifz2_on_top][i, j] >= 
        2 * m[:ifz_on_top][i, j]
    )


    #Check if xi + xcoveri == xj. 
    @variable(m, ifx1_right[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @variable(m, ifx2_right[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @variable(m, ifx_right[i=1:length(boxes)-2, j=(i+1):length(boxes)-1] >= 0, Bin)

    @constraint(m, cx1_right1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * m[:ifx1_right][i, j] >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - m[:flbx_front_left_bot_x][j] + 0.001
    )
    @constraint(m, cx1_right2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * (1 - m[:ifx1_right][i, j]) >= 
        m[:flbx_front_left_bot_x][j] - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][j]) - 0.001
    )

    @constraint(m, cx2_right1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * m[:ifx2_right][i, j] >= 
        m[:flbx_front_left_bot_x][j] - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) + 0.001
    )
    @constraint(m, cx2_right2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * (1 - m[:ifx2_right][i, j]) >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - m[:flbx_front_left_bot_x][j] - 0.001
    )

    @constraint(m, cx_right[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:ifx1_right][i, j] + m[:ifx2_right][i, j] >= 
        2 * m[:ifx_right][i, j]
    )
    

    #Check if yi + ycoveri == yj. 
    @variable(m, ify1_behind[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @variable(m, ify2_behind[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @variable(m, ify_behind[i=1:length(boxes)-2, j=(i+1):length(boxes)-1] >= 0, Bin)

    @constraint(m, cy1_behind1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * m[:ify1_behind][i, j] >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - m[:flby_front_left_bot_y][j] + 0.001
    )
    @constraint(m, cy1_behind2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * (1 - m[:ify1_behind][i, j]) >= 
        m[:flby_front_left_bot_y][j] - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][j]) - 0.001
    )

    @constraint(m, cy2_behind1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * m[:ify2_behind][i, j] >= 
        m[:flby_front_left_bot_y][j] - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) + 0.001
    )
    @constraint(m, cy2_behind2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        H * (1 - m[:ify2_behind][i, j]) >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - m[:flby_front_left_bot_y][j] - 0.001
    )

    @constraint(m, cy_right[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:ify1_behind][i, j] + m[:ify2_behind][i, j] >= 
        2 * m[:ify_behind][i, j]
    )  
    
    return m
end

end
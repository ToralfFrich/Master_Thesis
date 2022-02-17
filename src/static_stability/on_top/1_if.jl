module IfOnTop

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export if_on_top

function if_on_top(m)

    #if (flbz_front_left_bot_z[i] == flbz_front_left_bot_z[j] + hob_height_of_box[j] && 
    #    flbz_front_left_bot_z[i] - hob_height_of_box[j] >= 0 && 
    #    flbx_front_left_bot_x[j] > flbx_front_left_bot_x[i] - box_i_x_axis_cover &&
    #    flbx_front_left_bot_x[j] < flbx_front_left_bot_x[i] + box_i_x_axis_cover &&
    #    flby_front_left_bot_y[j] > flby_front_left_bot_y[i] - box_i_y_axis_cover &&
    #    flby_front_left_bot_y[j] < flby_front_left_bot_y[i] + box_i_y_axis_cover)

    
    # IF 1
    @variable(m, if11_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @variable(m, if12_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @variable(m, if1_on_top[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0, Bin)

    #Hz1 >= x-b+e
    #H(1-z1) >= b-x-e
    @constraint(m, c1_if11_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * m[:if11_on_top][i, j] >= 
        m[:flbz_front_left_bot_z][i] - (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) + 0.001
    )
    @constraint(m, c2_if11_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * (1 - m[:if11_on_top][i, j]) >= 
        (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) - m[:flbz_front_left_bot_z][i] - 0.001
    )

    #Hz2 >= b-x+e
    #H(1-z2) >= x-b-e
    @constraint(m, c1_if12_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * m[:if12_on_top][i, j] >= 
        (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) - m[:flbz_front_left_bot_z][i] + 0.001
    )
    @constraint(m, c2_if12_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * (1 - m[:if12_on_top][i, j]) >= 
        m[:flbz_front_left_bot_z][i] - (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) - 0.001
    )

    #If if11, if12 = 1, then box i and j have z-bot/top value within interval -e <= z <= +e, hence, expression = 1
    @constraint(m, c_if1_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:if11_on_top][i, j] + m[:if12_on_top][i, j] >= 
        2 * m[:if1_on_top][i, j]
    )

    #Xj < Xi + Xcoveri
    @variable(m, if2_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c1_if2_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * (1 - m[:if2_on_top][i, j]) >= 
        m[:flbx_front_left_bot_x][j] + 0.001 - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i])
    )

    @constraint(m, c2_if2_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * m[:if2_on_top][i, j] >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - m[:flbx_front_left_bot_x][j] - 0.001
    )

    # Xj + Xcoverj > Xi
    @variable(m, if3_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c1_if3_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * (1 - m[:if3_on_top][i, j]) >= 
        m[:flbx_front_left_bot_x][i] + 0.001 - (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j])
    )

    @constraint(m, c2_if3_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        L * m[:if3_on_top][i, j] >= 
        (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - m[:flbx_front_left_bot_x][i] - 0.001
    )

    # Yj < Yi + Ycoveri
    @variable(m, if4_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c1_if4_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * (1 - m[:if4_on_top][i, j]) >= 
        m[:flby_front_left_bot_y][j] + 0.001 - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i])
    )

    @constraint(m, c2_if4_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * m[:if4_on_top][i, j] >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - m[:flby_front_left_bot_y][j] - 0.001
    )

    # Yj + Ycoverj > Yi
    @variable(m, if5_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c1_if5_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * (1 - m[:if5_on_top][i, j]) >= 
        m[:flby_front_left_bot_y][i] + 0.001 - (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j])
    )

    @constraint(m, c2_if5_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        W * m[:if5_on_top][i, j] >= 
        (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - m[:flby_front_left_bot_y][i] - 0.001
    )

    @variable(m, if_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @constraint(m, c_if_on_top[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:if1_on_top][i, j] + 
        m[:if2_on_top][i, j] + 
        m[:if3_on_top][i, j] +
        m[:if4_on_top][i, j] + 
        m[:if5_on_top][i, j] >= 
        5 * m[:if_on_top][i, j]
    )
    
    return m
end

end

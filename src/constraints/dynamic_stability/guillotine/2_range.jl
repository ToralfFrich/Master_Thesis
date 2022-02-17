module Range

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export second_dim_range

function second_dim_range(m)

    #Then, given that x-axis is the same, we now want to check whether the boxes are within the y-range

    #Xj < Xi + Xcoveri
    @variable(m, if2_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, c1_if2_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if2_guillo][i, j]) >= 
        m[:flbx_front_left_bot_x][j] + 0.001 - (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i])
    )

    @constraint(m, c2_if2_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if2_guillo][i, j] >= 
        (m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]) - m[:flbx_front_left_bot_x][j] - 0.001
    )

    # Xj + Xcoverj > Xi
    @variable(m, if3_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, c1_if3_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * (1 - m[:if3_guillo][i, j]) >= 
        m[:flbx_front_left_bot_x][i] + 0.001 - (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j])
    )

    @constraint(m, c2_if3_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        L * m[:if3_guillo][i, j] >= 
        (m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]) - m[:flbx_front_left_bot_x][i] - 0.001
    )

    @variable(m, x_for_y_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, c_x_for_y_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if2_guillo][i, j] + 
        m[:if3_guillo][i, j] >= 
        2 * m[:x_for_y_guillo][i, j]
    )



    # Yj < Yi + Ycoveri
    @variable(m, if4_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, c1_if4_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if4_guillo][i, j]) >= 
        m[:flby_front_left_bot_y][j] + 0.001 - (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i])
    )

    @constraint(m, c2_if4_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if4_guillo][i, j] >= 
        (m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]) - m[:flby_front_left_bot_y][j] - 0.001
    )

    # Yj + Ycoverj > Yi
    @variable(m, if5_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, c1_if5_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * (1 - m[:if5_guillo][i, j]) >= 
        m[:flby_front_left_bot_y][i] + 0.001 - (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j])
    )

    @constraint(m, c2_if5_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        W * m[:if5_guillo][i, j] >= 
        (m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]) - m[:flby_front_left_bot_y][i] - 0.001
    )

    @variable(m, y_for_x_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, c_y_for_x_guillo[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if4_guillo][i, j] + 
        m[:if5_guillo][i, j] >= 
        2 * m[:y_for_x_guillo][i, j]
    )

    return m
end

end








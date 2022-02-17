module RobotSimple

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export cons_rp_robot_simple

function cons_rp_robot_simple(m)

    @variable(m, robot_simple[i=1:length(boxes)-1], Bin)
    @variable(m, robot_simple_x[i=1:length(boxes)-1], Bin)
    @variable(m, robot_simple_y[i=1:length(boxes)-1], Bin)
    @variable(m, robot_simple_z[i=1:length(boxes)-1], Bin)

    @constraint(m, c_robot_simple_x1[i=1:length(boxes)-2],
        L * (1 - robot_simple_x[i+1]) >=
        m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i] - m[:flbx_front_left_bot_x][i+1]
    )

    @constraint(m, c_robot_simple_y1[i=1:length(boxes)-2],
        W * (1 - robot_simple_y[i+1]) >=
        m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i] - m[:flby_front_left_bot_y][i+1]
    )

    @constraint(m, c_robot_simple_z1[i=1:length(boxes)-2],
        H * (1 - robot_simple_z[i+1]) >=
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i] - m[:flbz_front_left_bot_z][i+1]
    )
    
    """
    @constraint(m, c_robot_simple_x2[i=1:length(boxes)-2],
        L * robot_simple_x[i+1] >=
        m[:flbx_front_left_bot_x][i+1] - m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]
    )

    @constraint(m, c_robot_simple_y2[i=1:length(boxes)-2],
        W * robot_simple_y[i+1] >=
        m[:flby_front_left_bot_y][i+1] - m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]
    )

    @constraint(m, c_robot_simple_z2[i=1:length(boxes)-2],
        H * robot_simple_z[i+1] >=
        m[:flbz_front_left_bot_z][i+1] - m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i]
    )
    """

    @constraint(m, c_robot_simple[i=1:length(boxes)-2],
        robot_simple_x[i+1] + robot_simple_y[i+1] + robot_simple_z[i+1] >= robot_simple[i+1]
    )

    @constraint(m, c_robot[i=1:length(boxes)-2],
        robot_simple[i+1] >= 1
    )

    @expression(m, robot_simple_objective,
        length(boxes)*length(boxes) - sum(robot_simple)
    )

    return m
end

end
module IfPartialBase

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export if_pb

function if_pb(m)

    #if (flbz_front_left_bot_z[i] == flbz_front_left_bot_z[j] + hob_height_of_box[j] && 
    #    flbz_front_left_bot_z[i] - hob_height_of_box[j] >= 0 && 
    #    flbx_front_left_bot_x[j] > flbx_front_left_bot_x[i] - box_i_x_axis_cover &&
    #    flbx_front_left_bot_x[j] < flbx_front_left_bot_x[i] + box_i_x_axis_cover &&
    #    flby_front_left_bot_y[j] > flby_front_left_bot_y[i] - box_i_y_axis_cover &&
    #    flby_front_left_bot_y[j] < flby_front_left_bot_y[i] + box_i_y_axis_cover)

    # IF 1
    @variable(m, if11_pbs[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @variable(m, if12_pbs[i=1:length(boxes), j=1:length(boxes); i!=j], Bin)
    @variable(m, if1_pbs[i=1:length(boxes), j=1:length(boxes); i!=j] >= 0, Bin)

    #Hz1 >= x-b+e
    #H(1-z1) >= b-x-e
    @constraint(m, c1_if11_pbs[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * m[:if11_pbs][i, j] >= 
        m[:flbz_front_left_bot_z][i] - (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) + 0.001
    )
    @constraint(m, c2_if11_pbs[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * (1 - m[:if11_pbs][i, j]) >= 
        (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) - m[:flbz_front_left_bot_z][i] - 0.001
    )

    #Hz2 >= b-x+e
    #H(1-z2) >= x-b-e
    @constraint(m, c1_if12_pbs[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * m[:if12_pbs][i, j] >= 
        (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) - m[:flbz_front_left_bot_z][i] + 0.001
    )
    @constraint(m, c2_if12_pbs[i=1:length(boxes), j=1:length(boxes); i!=j], 
        H * (1 - m[:if12_pbs][i, j]) >= 
        m[:flbz_front_left_bot_z][i] - (m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]) - 0.001
    )

    #If if11, if12 = 1, then box i and j have z-bot/top value within interval -e <= z <= +e, hence, expression = 1
    @constraint(m, c_if1_pbs[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:if11_pbs][i, j] + m[:if12_pbs][i, j] >= 
        2 * m[:if1_pbs][i, j]
    )


    return m
end

end

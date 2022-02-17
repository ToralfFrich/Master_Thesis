module OnTop

include("./../../basic_model/constants.jl")
include("./1_if.jl")
using JuMP
using .Constants
using .IfOnTop

export cons_ss_on_top

function cons_ss_on_top(m)

    m = if_on_top(m)

    @expression(m, if_pbs_i[i=1:length(boxes)-1], 
        sum([m[:if_on_top][i, j] for j in 1:length(boxes)-1 if i!=j])
    )

    # zi < 0.001
    @variable(m, above_ground[i=1:length(boxes)-1], Bin)
    @constraint(m, c_above_ground1[i=1:length(boxes)-1], 
        H * (1 - m[:above_ground][i]) >= 
        m[:flbz_front_left_bot_z][i] - 0.002
    )
    

    @constraint(m, c_above_ground2[i=1:length(boxes)-1], 
        H * m[:above_ground][i] >= 
        0.002 - m[:flbz_front_left_bot_z][i]
    )

    @constraint(m, c_on_top[i=1:length(boxes)-1],
        m[:if_pbs_i][i] + m[:above_ground][i] >= 1
    )

    return m
end

end
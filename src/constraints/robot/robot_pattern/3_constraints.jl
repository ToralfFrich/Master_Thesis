module RPConstraints

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export rp_constraints

function rp_constraints(m)

    #AND TOP
    @variable(m, robot_on_top[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, c_robot_on_top[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:ifz_on_top][i, j] + m[:rp_ifx_or][i, j] + m[:rp_ify_or][i, j] >=
        3 * m[:robot_on_top][i, j]
    )

    #AND RIGHT
    @variable(m, robot_right[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, c_robot_right[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:ifx_right][i, j] + m[:rp_ify_or][i, j] + m[:rp_ifz_or][i, j] >=
        3 * m[:robot_right][i, j]
    )

    #AND behind
    @variable(m, robot_behind[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, c_robot_behind[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:ify_behind][i, j] + m[:rp_ifx_or][i, j] + m[:rp_ifz_or][i, j] >=
        3 * m[:robot_behind][i, j]
    )

    @expression(m, robot_positions[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],
        m[:robot_on_top][i, j] + m[:robot_right][i, j] + m[:robot_behind][i, j]
    )

    for k in 2:length(boxes)-1
        positions = []
        for j in k:k
            for i in 1:j
                if i!=j
                    push!(positions, [i, j])
                end
            end
        end
        expressions = []
        for l in 1:length(positions)
            push!(expressions, m[:robot_positions][value(positions[l][1]), value(positions[l][2])])
        end
        @show(sum(expressions[n] for n in 1:length(expressions)))
        @constraint(m, 
            sum(expressions[n] for n in 1:length(expressions)) == 1
        )
    end
    
    
    # The first box is placed at (0, 0, 0) for this pattern to work.
    @constraint(m, robot_box_one_x, m[:flbx_front_left_bot_x][1] == 0)
    @constraint(m, robot_box_one_y, m[:flby_front_left_bot_y][1] == 0)
    @constraint(m, robot_box_one_z, m[:flbz_front_left_bot_z][1] == 0)

    return m
end

end
module LoadBalancingConstraints

include("./../basic_model/constants.jl")
using JuMP
using .Constants

export lb_constraints

function lb_constraints(m)

    @expression(m, lb_x[i=1:length(boxes)], 
        masses[i]*(m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i]/2)
    )

    @constraint(m, lb_x_start_constraint,
        sum(m[:lb_x])/sum_of_masses >= cm_x_interval_1
    )

    @constraint(m, lb_x_end_constraint,
        sum(m[:lb_x])/sum_of_masses <= cm_x_interval_2
    )

    @expression(m, lb_y[i=1:length(boxes)], 
        masses[i]*(m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i]/2)
    )

    @constraint(m, lb_y_start_constraint,
        sum(m[:lb_y])/sum_of_masses >= cm_y_interval_1
    )

    @constraint(m, lb_y_end_constraint,
        sum(m[:lb_y])/sum_of_masses <= cm_y_interval_2
    )
    
    return m
end

end
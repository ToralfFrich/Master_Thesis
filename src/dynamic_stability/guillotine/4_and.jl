module GuillotineIfAnd

include("./../../basic_model/constants.jl")
using JuMP
using .Constants

export all_dimensions_and

function all_dimensions_and(m)

    #The "left" side of a box
    @variable(m, guillotine_flbx[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_x_cons_flbx[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flbx][i, j] + m[:y_for_x_guillo][i, j] >= 
        2 * m[:guillotine_flbx][i, j]
    )

    @variable(m, guillotine_flbx_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_x_cons_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flbx_j_plus][i, j] + m[:y_for_x_guillo][i, j] >= 
        2 * m[:guillotine_flbx_j_plus][i, j]
    )

    #The "right" side of a box
    @variable(m, guillotine_flbx_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_x_cons_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flbx_ij_plus][i, j] + m[:y_for_x_guillo][i, j] >= 
        2 * m[:guillotine_flbx_ij_plus][i, j]
    )

    @variable(m, guillotine_flbx_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_x_cons_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flbx_i_plus][i, j] + m[:y_for_x_guillo][i, j] >= 
        2 * m[:guillotine_flbx_i_plus][i, j]
    )


    # ===== Y AXIS =====

    #The "left" side of a box
    @variable(m, guillotine_flby[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_y_cons_flby[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flby][i, j] + m[:x_for_y_guillo][i, j] >= 
        2 * m[:guillotine_flby][i, j]
    )

    @variable(m, guillotine_flby_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_y_cons_j_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flby_j_plus][i, j] + m[:x_for_y_guillo][i, j] >= 
        2 * m[:guillotine_flby_j_plus][i, j]
    )

    #The "right" side of a box
    @variable(m, guillotine_flby_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_y_cons_ij_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flby_ij_plus][i, j] + m[:x_for_y_guillo][i, j] >= 
        2 * m[:guillotine_flby_ij_plus][i, j]
    )

    @variable(m, guillotine_flby_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], Bin)
    @constraint(m, guillotine_y_cons_i_plus[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        m[:if1_eq_flby_i_plus][i, j] + m[:x_for_y_guillo][i, j] >= 
        2 * m[:guillotine_flby_i_plus][i, j]
    )

    @expression(m, guillotine_and_objective[i=1:length(boxes)-1, j=1:length(boxes)-1; i!=j], 
        #x
        (1 - m[:guillotine_flbx][i, j]) +
        (1 - m[:guillotine_flbx_i_plus][i, j]) +
        (1 - m[:guillotine_flbx_j_plus][i, j]) +
        (1 - m[:guillotine_flbx_ij_plus][i, j]) +

        #y
        (1 - m[:guillotine_flby][i, j]) +
        (1 - m[:guillotine_flby_i_plus][i, j]) +
        (1 - m[:guillotine_flby_j_plus][i, j]) +
        (1 - m[:guillotine_flby_ij_plus][i, j])
    )


    return m
end

end
module MultiplicationPartialBase

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export multiplication

function multiplication(m)

    #tot_cover_of_i += x_axis_covered*y_axis_covered

    @expression(m, static_new_variable_1[i=1:length(boxes), j=1:length(boxes); i!=j], 0.5*(m[:x_axis_covered][i, j] + m[:y_axis_covered][i, j]))
    @expression(m, static_new_variable_2[i=1:length(boxes), j=1:length(boxes); i!=j], 0.5*(m[:x_axis_covered][i, j] - m[:y_axis_covered][i, j]))

    
    # Piecewise linearisation start, need two, one for new each variable
    @variable(m, piecewise1[i=1:length(boxes), j=1:length(boxes); i!=j])
    @variable(m, static_lambda_box_cover1[i=1:length(boxes), j=1:length(boxes), k=1:10; i!=j] >= 0)
    @expression(m, static_lambda_box_cover1_row[i=1:length(boxes), j=1:length(boxes); i!=j], 
        [
        m[:static_lambda_box_cover1][i, j, 1], 
        m[:static_lambda_box_cover1][i, j, 2], 
        m[:static_lambda_box_cover1][i, j, 3], 
        m[:static_lambda_box_cover1][i, j, 4], 
        m[:static_lambda_box_cover1][i, j, 5],
        m[:static_lambda_box_cover1][i, j, 6], 
        m[:static_lambda_box_cover1][i, j, 7], 
        m[:static_lambda_box_cover1][i, j, 8], 
        m[:static_lambda_box_cover1][i, j, 9],
        m[:static_lambda_box_cover1][i, j, 10]
        ]
    )
    @constraint(m, static_lambda_box_cover_constraint1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        sum(m[:static_lambda_box_cover1_row][i, j]) == 1
    )
    @constraint(m, static_lambda_box_cover1_sos[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:static_lambda_box_cover1_row][i, j] in SOS2()
    )

    @constraint(m, static_product_lambda_constraint1[i=1:length(boxes), j=1:length(boxes); i!=j], (
        -m[:static_new_variable_1][i, j] + 
        lin_plus[1]*m[:static_lambda_box_cover1][i, j, 2] +
        lin_plus[2]*m[:static_lambda_box_cover1][i, j, 3] +
        lin_plus[3]*m[:static_lambda_box_cover1][i, j, 4] +
        lin_plus[4]*m[:static_lambda_box_cover1][i, j, 5] +
        lin_plus[5]*m[:static_lambda_box_cover1][i, j, 6] +
        lin_plus[6]*m[:static_lambda_box_cover1][i, j, 7] +
        lin_plus[7]*m[:static_lambda_box_cover1][i, j, 8] +
        lin_plus[8]*m[:static_lambda_box_cover1][i, j, 9] +
        lin_plus[9]*m[:static_lambda_box_cover1][i, j, 10] == 0)
    )
    @constraint(m, static_piecewise_lambda_constraint1[i=1:length(boxes), j=1:length(boxes); i!=j], (
        -m[:piecewise1][i, j] + 
        lin_plus_2[1]*m[:static_lambda_box_cover1][i, j, 2] +
        lin_plus_2[2]*m[:static_lambda_box_cover1][i, j, 3] +
        lin_plus_2[3]*m[:static_lambda_box_cover1][i, j, 4] +
        lin_plus_2[4]*m[:static_lambda_box_cover1][i, j, 5] +
        lin_plus_2[5]*m[:static_lambda_box_cover1][i, j, 6] +
        lin_plus_2[6]*m[:static_lambda_box_cover1][i, j, 7] +
        lin_plus_2[7]*m[:static_lambda_box_cover1][i, j, 8] +
        lin_plus_2[8]*m[:static_lambda_box_cover1][i, j, 9] +
        lin_plus_2[9]*m[:static_lambda_box_cover1][i, j, 10] == 0)
    )

    @variable(m, piecewise2[i=1:length(boxes), j=1:length(boxes); i!=j], )
    @variable(m, static_lambda_box_cover2[i=1:length(boxes), j=1:length(boxes), k=1:10; i!=j] >= 0)
    @expression(m, static_lambda_box_cover2_row[i=1:length(boxes), j=1:length(boxes); i!=j], 
        [
        m[:static_lambda_box_cover2][i, j, 1], 
        m[:static_lambda_box_cover2][i, j, 2], 
        m[:static_lambda_box_cover2][i, j, 3], 
        m[:static_lambda_box_cover2][i, j, 4], 
        m[:static_lambda_box_cover2][i, j, 5],
        m[:static_lambda_box_cover2][i, j, 6], 
        m[:static_lambda_box_cover2][i, j, 7], 
        m[:static_lambda_box_cover2][i, j, 8], 
        m[:static_lambda_box_cover2][i, j, 9],
        m[:static_lambda_box_cover2][i, j, 10] 
        ]
    )
    @constraint(m, static_lambda_box_cover_constraint2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        sum(m[:static_lambda_box_cover2_row][i, j]) == 1
    )
    @constraint(m, static_lambda_box_cover2_sos[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:static_lambda_box_cover2_row][i, j] in SOS2()
    )

    @constraint(m, static_product_lambda_constraint2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (
        -m[:static_new_variable_2][i, j] + 
        lin_min[1]*m[:static_lambda_box_cover2][i, j, 2] +
        lin_min[2]*m[:static_lambda_box_cover2][i, j, 3] +
        lin_min[3]*m[:static_lambda_box_cover2][i, j, 4] +
        lin_min[4]*m[:static_lambda_box_cover2][i, j, 5] +
        lin_min[5]*m[:static_lambda_box_cover2][i, j, 6] +
        lin_min[6]*m[:static_lambda_box_cover2][i, j, 7] +
        lin_min[7]*m[:static_lambda_box_cover2][i, j, 8] +
        lin_min[8]*m[:static_lambda_box_cover2][i, j, 9] +
        lin_min[9]*m[:static_lambda_box_cover2][i, j, 10] == 0
        )
    )
    @constraint(m, static_piecewise_lambda_constraint2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (
        -m[:piecewise2][i, j] + 
        lin_min_2[1]*m[:static_lambda_box_cover2][i, j, 2] +
        lin_min_2[2]*m[:static_lambda_box_cover2][i, j, 3] +
        lin_min_2[3]*m[:static_lambda_box_cover2][i, j, 4] +
        lin_min_2[4]*m[:static_lambda_box_cover2][i, j, 5] +
        lin_min_2[5]*m[:static_lambda_box_cover2][i, j, 6] +
        lin_min_2[6]*m[:static_lambda_box_cover2][i, j, 7] +
        lin_min_2[7]*m[:static_lambda_box_cover2][i, j, 8] +
        lin_min_2[8]*m[:static_lambda_box_cover2][i, j, 9] +
        lin_min_2[9]*m[:static_lambda_box_cover2][i, j, 10] == 0
        )   
    )


    # Finding total partial stability of one box start. (length(boxes)-1 as we do not want to get support from sentinel). 
    # Multiply by if, as if tells whether i,j is to be considered. 
    @expression(m, pbs_box_ij[i=1:length(boxes), j=1:length(boxes); i!=j], 
        m[:if_on_top][i, j] * (m[:piecewise1][i, j] - m[:piecewise2][i, j])
    )
    @expression(m, pbs_box_i[i=1:length(boxes)], 
        sum([m[:pbs_box_ij][i, j] for j in 1:length(boxes) if i!=j])
    )
    
    return m
end

end








module MultiplicationPartialBase

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export multiplication

function multiplication(model)

    #tot_cover_of_i += x_axis_covered*y_axis_covered

    @expression(model, static_new_variable_1[i=1:length(boxes), j=1:length(boxes); i!=j], 0.5*(model[:x_axis_covered][i, j] + model[:y_axis_covered][i, j]))
    @expression(model, static_new_variable_2[i=1:length(boxes), j=1:length(boxes); i!=j], 0.5*(model[:x_axis_covered][i, j] - model[:y_axis_covered][i, j]))

    # Piecewise linearisation start, need two, one for new each variable
    @variable(model, piecewise1[i=1:length(boxes), j=1:length(boxes); i!=j])
    @variable(model, static_lambda_box_cover1[i=1:length(boxes), j=1:length(boxes), k=1:10; i!=j] >= 0)
    @expression(model, static_lambda_box_cover1_row[i=1:length(boxes), j=1:length(boxes); i!=j], 
        [
        model[:static_lambda_box_cover1][i, j, 1], 
        model[:static_lambda_box_cover1][i, j, 2], 
        model[:static_lambda_box_cover1][i, j, 3], 
        model[:static_lambda_box_cover1][i, j, 4], 
        model[:static_lambda_box_cover1][i, j, 5],
        model[:static_lambda_box_cover1][i, j, 6], 
        model[:static_lambda_box_cover1][i, j, 7], 
        model[:static_lambda_box_cover1][i, j, 8], 
        model[:static_lambda_box_cover1][i, j, 9],
        model[:static_lambda_box_cover1][i, j, 10]
        ]
    )
    @constraint(model, static_lambda_box_cover_constraint1[i=1:length(boxes), j=1:length(boxes); i!=j], 
        sum(model[:static_lambda_box_cover1_row][i, j]) == 1
    )
    @constraint(model, static_lambda_box_cover1_sos[i=1:length(boxes), j=1:length(boxes); i!=j], 
        model[:static_lambda_box_cover1_row][i, j] in SOS2()
    )

    @constraint(model, static_product_lambda_constraint1[i=1:length(boxes), j=1:length(boxes); i!=j], (
        -model[:static_new_variable_1][i, j] + 
        lin_plus[1]*model[:static_lambda_box_cover1][i, j, 2] +
        lin_plus[2]*model[:static_lambda_box_cover1][i, j, 3] +
        lin_plus[3]*model[:static_lambda_box_cover1][i, j, 4] +
        lin_plus[4]*model[:static_lambda_box_cover1][i, j, 5] +
        lin_plus[5]*model[:static_lambda_box_cover1][i, j, 6] +
        lin_plus[6]*model[:static_lambda_box_cover1][i, j, 7] +
        lin_plus[7]*model[:static_lambda_box_cover1][i, j, 8] +
        lin_plus[8]*model[:static_lambda_box_cover1][i, j, 9] +
        lin_plus[9]*model[:static_lambda_box_cover1][i, j, 10] == 0)
    )
    @constraint(model, static_piecewise_lambda_constraint1[i=1:length(boxes), j=1:length(boxes); i!=j], (
        -model[:piecewise1][i, j] + 
        lin_plus_2[1]*model[:static_lambda_box_cover1][i, j, 2] +
        lin_plus_2[2]*model[:static_lambda_box_cover1][i, j, 3] +
        lin_plus_2[3]*model[:static_lambda_box_cover1][i, j, 4] +
        lin_plus_2[4]*model[:static_lambda_box_cover1][i, j, 5] +
        lin_plus_2[5]*model[:static_lambda_box_cover1][i, j, 6] +
        lin_plus_2[6]*model[:static_lambda_box_cover1][i, j, 7] +
        lin_plus_2[7]*model[:static_lambda_box_cover1][i, j, 8] +
        lin_plus_2[8]*model[:static_lambda_box_cover1][i, j, 9] +
        lin_plus_2[9]*model[:static_lambda_box_cover1][i, j, 10] == 0)
    )

    @variable(model, piecewise2[i=1:length(boxes), j=1:length(boxes); i!=j], )
    @variable(model, static_lambda_box_cover2[i=1:length(boxes), j=1:length(boxes), k=1:10; i!=j] >= 0)
    @expression(model, static_lambda_box_cover2_row[i=1:length(boxes), j=1:length(boxes); i!=j], 
        [
        model[:static_lambda_box_cover2][i, j, 1], 
        model[:static_lambda_box_cover2][i, j, 2], 
        model[:static_lambda_box_cover2][i, j, 3], 
        model[:static_lambda_box_cover2][i, j, 4], 
        model[:static_lambda_box_cover2][i, j, 5],
        model[:static_lambda_box_cover2][i, j, 6], 
        model[:static_lambda_box_cover2][i, j, 7], 
        model[:static_lambda_box_cover2][i, j, 8], 
        model[:static_lambda_box_cover2][i, j, 9],
        model[:static_lambda_box_cover2][i, j, 10] 
        ]
    )
    @constraint(model, static_lambda_box_cover_constraint2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        sum(model[:static_lambda_box_cover2_row][i, j]) == 1
    )
    @constraint(model, static_lambda_box_cover2_sos[i=1:length(boxes), j=1:length(boxes); i!=j], 
        model[:static_lambda_box_cover2_row][i, j] in SOS2()
    )

    @constraint(model, static_product_lambda_constraint2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (
        -model[:static_new_variable_2][i, j] + 
        lin_min[1]*model[:static_lambda_box_cover2][i, j, 2] +
        lin_min[2]*model[:static_lambda_box_cover2][i, j, 3] +
        lin_min[3]*model[:static_lambda_box_cover2][i, j, 4] +
        lin_min[4]*model[:static_lambda_box_cover2][i, j, 5] +
        lin_min[5]*model[:static_lambda_box_cover2][i, j, 6] +
        lin_min[6]*model[:static_lambda_box_cover2][i, j, 7] +
        lin_min[7]*model[:static_lambda_box_cover2][i, j, 8] +
        lin_min[8]*model[:static_lambda_box_cover2][i, j, 9] +
        lin_min[9]*model[:static_lambda_box_cover2][i, j, 10] == 0
        )
    )
    @constraint(model, static_piecewise_lambda_constraint2[i=1:length(boxes), j=1:length(boxes); i!=j], 
        (
        -model[:piecewise2][i, j] + 
        lin_min_2[1]*model[:static_lambda_box_cover2][i, j, 2] +
        lin_min_2[2]*model[:static_lambda_box_cover2][i, j, 3] +
        lin_min_2[3]*model[:static_lambda_box_cover2][i, j, 4] +
        lin_min_2[4]*model[:static_lambda_box_cover2][i, j, 5] +
        lin_min_2[5]*model[:static_lambda_box_cover2][i, j, 6] +
        lin_min_2[6]*model[:static_lambda_box_cover2][i, j, 7] +
        lin_min_2[7]*model[:static_lambda_box_cover2][i, j, 8] +
        lin_min_2[8]*model[:static_lambda_box_cover2][i, j, 9] +
        lin_min_2[9]*model[:static_lambda_box_cover2][i, j, 10] == 0
        )   
    )


    # Finding total partial stability of one box start. (length(boxes)-1 as we do not want to get support from sentinel). 
    # Multiply by if, as if tells whether i,j is to be considered. 
    @expression(model, pbs_box_ij[i=1:length(boxes), j=1:length(boxes); i!=j], 
        model[:if1_pbs][i, j] * (model[:piecewise1][i, j] - model[:piecewise2][i, j])
    )
    @expression(model, pbs_box_i[i=1:length(boxes)], 
        sum([model[:pbs_box_ij][i, j] for j in 1:length(boxes) if i!=j])
    )

    return model
end

end








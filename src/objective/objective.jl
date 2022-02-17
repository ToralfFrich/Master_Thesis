module Objective

include("./../basic_model/constants.jl")
using JuMP
using .Constants

export objective

function objective(m, mode::Int64)

    #Other weights
    print(mode)
    if (mode == 0)
        @expression(m, minner_og_maxer,
            0
        )
    elseif (mode == 2)
        @expression(m, minner_og_maxer, 
            0.1 * sum(m[:ds_mb_sum_of_boxes_below_obj]) +
            0.1 * sum(m[:middle_objective])
        )
    elseif (mode == 3)
        @expression(m, minner_og_maxer, 
            0.1 * sum(m[:ds_mb_sum_of_boxes_below_obj])
        )
    elseif (mode == 4)
        @expression(m, minner_og_maxer,
            0.1 * sum(m[:middle_objective])
        )
    else
        @expression(m, minner_og_maxer, 
            0.001 * sum(m[:guillotine_objective])
        )
    end
    
    #Objective function
    @objective(m, Min, m[:maxHeight] + 0.001 * m[:minner_og_maxer])

    return m
end

end
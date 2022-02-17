module Master

include("./basic_model/variables.jl")
include("./basic_model/sentinel.jl")
include("./basic_model/rotations_currence.jl")
include("./basic_model/non_overlapping.jl")
include("./basic_model/inside_pallet.jl")
include("./static_stability/partial_base/0_partial_base.jl")
include("./static_stability/partial_base_2/0_partial_base.jl")
include("./static_stability/on_top/0_on_top.jl")
include("./static_stability/ss_mult_boxes/0_ss_mult_boxes.jl")
include("./dynamic_stability/guillotine/0_guillotine.jl")
include("./dynamic_stability/guillotine/callback.jl")
include("./dynamic_stability/middle/0_middle.jl")
include("./objective/objective.jl")
include("./basic_model/constants.jl")
include("./dynamic_stability/mult_boxes/0_mult_boxes.jl")
include("./load_balance/0_load_balancing.jl")
include("./robot/robot_pattern/0_robot_pattern.jl")
include("./robot/simple/0_robot_simple.jl")
include("./robot/simple/0_robot_simple_fixed.jl")
include("./load_bearing/partial_base/0_partial_base_lb.jl")
include("./load_bearing/simple/0_pressure_lb.jl")
include("./load_bearing/simple/0_number_lb.jl")
include("./results/write_to_file.jl")
include("./results/write_to_json.jl")
using JuMP, Gurobi
using .Variables 
using .Sentinel
using .RotationsCurrence
using .NonOverlapping
using .InsidePallet
using .PartialBase
using .PartialBase2
using .OnTop
using .CMultipleBoxes
using .Guillotine
using .GuillotineCallback
using .Middle
using .Objective
using .Constants
using .MultBoxes
using .LoadBalancing
using .RobotPattern
using .RobotSimple
using .RobotSimpleFixed
using .LBPartialBase
using .LBSimple
using .LBNumber
using .WriteToFile
using .WriteToJSON

function init_model()
    return direct_model(Gurobi.Optimizer())
end

export main

function main(mode::Int64)
    m = init_model()
    m = init_variables(m)
    m = init_sentinel(m)
    m = cons_rotations_currence(m)
    m = cons_non_overlapping(m)
    m = cons_inside_pallet(m)
    print(mode)
    if (mode == 1)
        # LB

        m = cons_lb_load_balancing(m)
    elseif (mode == 2)
        # LBP

        m = cons_lb_simple_load_bearing(m)
    elseif (mode == 3)
        # Robot

        m = cons_rp_robot_simple_fixed(m)
    elseif (mode == 4)
        #PBS1

        m = cons_ss_partial_base(m)
    elseif (mode == 5)
        #PBS2

        m = cons_ss_partial_base_two(m)
    elseif (mode == 6)
        # LBP OnTop

        m = cons_ss_on_top(m)
        m = cons_lb_simple_load_bearing(m)
    elseif (mode == 7)
        # OnTop

        m = cons_ss_on_top(m)
    elseif (mode == 8)
        # Guillotine

        m = cons_ds_guillotine(m)
    elseif (mode == 9)
        # Guillotine OnTop

        m = cons_ss_on_top(m)
        m = cons_ds_guillotine(m)
    elseif (mode == 10)
        # Guillotine OnTop LB LBP

        m = cons_ss_on_top(m)
        m = cons_ds_guillotine(m)
        m = cons_lb_load_balancing(m)
        m = cons_lb_simple_load_bearing(m)
    elseif (mode == 11)
        # PBS2 LB LBP

        m = cons_ss_partial_base_two(m)
        m = cons_lb_load_balancing(m)
        m = cons_lb_simple_load_bearing(m)
    elseif (mode == 12)
        # PBS2 Guillotine LB LBP

        m = cons_ss_partial_base_two(m)
        m = cons_ds_guillotine(m)
        m = cons_lb_load_balancing(m)
        m = cons_lb_simple_load_bearing(m)
    elseif (mode == 13)
        #PBS1 LB LBP MIDDLE MB

        m = cons_ss_partial_base(m)
        m = cons_lb_load_balancing(m)
        m = cons_lb_simple_load_bearing(m)
        m = cons_ds_mult_boxes(m)
        m = cons_ds_middle(m)
    elseif (mode == 14)
        # MB OnTop

        m = cons_ss_on_top(m)
        m = cons_ds_mult_boxes(m)
    elseif (mode == 15)
        # MIDDLE OnTop

        m = cons_ss_on_top(m)
        m = cons_ds_mult_boxes(m)
    elseif (mode == 16)
        #MBSS ONTOP

        m = cons_ss_partial_base_two(m)
        m = cons_ss_mult_boxes(m)
    end

    if (mode == 8 || mode == 9 || mode == 10 || mode == 12)
        # Guillotine

        m = objective(m, 1)
    elseif (mode == 13)
        # MIDDLE MB

        m = objective(m, 2)
    elseif (mode == 14)
        # MB

        m = objective(m, 3)
    elseif (mode == 13)
        # MIDDLE

        m = objective(m, 4)
    else
        # NONE

        m = objective(m, 0)
    end

    # OPTIONS
    #m = cons_ss_mult_boxes(m)
    #m = cons_ds_guillotine(m)
    #m = cons_ds_mult_boxes(m)
    #m = cons_ds_middle(m)
    #m = cons_lb_load_balancing(m)
    
    #m = cons_lb_simple_load_bearing(m)
    #m = cons_lb_number_load_bearing(m)
    #m = cons_rp_robot_simple_fixed(m)
    #m = objective(m)

    function callback_function(cb_data)
        #guillotine_callback(cb_data, m)
        return
    end

    MOI.set(m, MOI.RawParameter("TimeLimit"), 2400)
    #MOI.set(m, MOI.LazyConstraintCallback(), callback_function)
    #MOI.set(m, MOI.RawParameter("MIPGap"), 0.00025)
    #MOI.set(m, MOI.RawParameter("MIPFocus"), 1)
    #mipfocus = 1: focus on finding feasible solutions
    #mipfocus = 2: focus on finding optimality
    #mipfocus = 3: focus on improving the bounds
    
    try
        optimize!(m)
    catch err
        print("\n ERROR \n")
    end

    try
        print("\n MaxHEIGHT \n")
        print(value(m[:maxHeight]))
        print('\n')
    catch err
        print("\n ERROR \n")
    end

    """
    if (has_values(m))
        WriteToJSON.write_to_json_simple(m)
    end
    """
    
    WriteToFile.append_to_file(m, mode)


    #WriteToFile.write_to_file(m)
    #WriteToFile.write_to_json(m)

end

for i in [5, 11, 12]
    main(i)
end

end


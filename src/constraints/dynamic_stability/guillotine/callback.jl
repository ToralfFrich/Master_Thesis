module GuillotineCallback

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export guillotine_callback, get_involved_boxes_flbx, find_all_guillotine_cuts_exceeding_limit


#Finds a guillotine cut that is larger than the allowed amount
function guillotine_callback(cb_data, m)

    max_cut = guillotine_ds_var * callback_value(cb_data, m[:maxHeight])

    fixed_x = []
    fixed_y = []

    #Check if there exists a cut higher than the allowed cuts
    for i in 1:length(boxes) - 1

        if length(fixed_x) > 0 || length(fixed_y) > 0
            print("Fixed X ", fixed_x, "\n")
            print("Fixed Y ", fixed_y, "\n")
        end

        print("Round ", i, "\n")
        
        #Find out where the cut is and pass information onwards
        if (callback_value(cb_data, m[:cut_flbx_left_i][i]) + 0.001 >= max_cut && check_if_fixed_x(cb_data, m, 1, i, fixed_x))
            print("Nr 1 \n")
            get_involved_boxes(cb_data, m, 1, i)
            x_value = callback_value(cb_data, m[:flbx_front_left_bot_x][i])
            push!(fixed_x, x_value)
        end
        if (callback_value(cb_data, m[:cut_flbx_j_plus_left_i][i]) + 0.001 >= max_cut && check_if_fixed_x(cb_data, m, 2, i, fixed_x))
            print("Nr 2 \n")
            get_involved_boxes(cb_data, m, 2, i)
            x_value = callback_value(cb_data, m[:flbx_front_left_bot_x][i])
            push!(fixed_x, x_value)
        end
        if (callback_value(cb_data, m[:cut_flbx_i_plus_right][i]) + 0.001 >= max_cut && check_if_fixed_x(cb_data, m, 3, i, fixed_x))
            print("Nr 3 \n")
            get_involved_boxes(cb_data, m, 3, i)
            x_value = callback_value(cb_data, m[:flbx_front_left_bot_x][i]) + callback_value(cb_data, m[:box_x_axis_cover][i])
            push!(fixed_x, x_value)
        end
        if (callback_value(cb_data, m[:cut_flbx_ij_plus_right][i]) + 0.001 >= max_cut && check_if_fixed_x(cb_data, m, 4, i, fixed_x))
            print("Nr 4 \n")
            get_involved_boxes(cb_data, m, 4, i)
            x_value = callback_value(cb_data, m[:flbx_front_left_bot_x][i]) + callback_value(cb_data, m[:box_x_axis_cover][i])
            push!(fixed_x, x_value)
        end
        if (callback_value(cb_data, m[:cut_flby_right][i]) + 0.001 >= max_cut && check_if_fixed_y(cb_data, m, 5, i, fixed_y))
            print("Nr 5 \n")
            get_involved_boxes(cb_data, m, 5, i)
            y_value = callback_value(cb_data, m[:flby_front_left_bot_y][i])
            push!(fixed_y, y_value)
        end
        if (callback_value(cb_data, m[:cut_flby_j_plus_right][i]) + 0.001 >= max_cut && check_if_fixed_y(cb_data, m, 6, i, fixed_y))
            print("Nr 6 \n")
            get_involved_boxes(cb_data, m, 6, i)
            y_value = callback_value(cb_data, m[:flby_front_left_bot_y][i])
            push!(fixed_y, y_value)
        end
        if (callback_value(cb_data, m[:cut_flby_i_plus_left][i]) + 0.001 >= max_cut && check_if_fixed_y(cb_data, m, 7, i, fixed_y))
            print("Nr 7 \n")
            get_involved_boxes(cb_data, m, 7, i)
            y_value = callback_value(cb_data, m[:flby_front_left_bot_y][i]) + callback_value(cb_data, m[:box_y_axis_cover][i])
            push!(fixed_y, y_value)
        end
        if (callback_value(cb_data, m[:cut_flby_ij_plus_left][i]) + 0.001 >= max_cut && check_if_fixed_y(cb_data, m, 8, i, fixed_y))
            print("Nr 8 \n")
            get_involved_boxes(cb_data, m, 8, i)
            y_value = callback_value(cb_data, m[:flby_front_left_bot_y][i]) + callback_value(cb_data, m[:box_y_axis_cover][i])
            push!(fixed_y, y_value)
        end
    end

    return 
end

function check_if_fixed_x(cb_data, m, pos, i, fixed_x)
    fixed = false
    if pos == 1 || pos == 2
        for fixed_pos in 1:length(fixed_x)
            if (callback_value(cb_data, m[:flbx_front_left_bot_x][i]) - 0.0001 <= 
                fixed_x[fixed_pos] <= 
                callback_value(cb_data, m[:flbx_front_left_bot_x][i]) + 0.0001)
                fixed = true
            end
        end
    elseif pos == 3 || pos == 4
        for fixed_pos in 1:length(fixed_x)
            if (callback_value(cb_data, m[:flbx_front_left_bot_x][i]) + callback_value(cb_data, m[:box_x_axis_cover][i]) - 0.0001 <= 
                fixed_x[fixed_pos] <= 
                callback_value(cb_data, m[:flbx_front_left_bot_x][i]) + callback_value(cb_data, m[:box_x_axis_cover][i]) + 0.0001)
                fixed = true
            end
        end
    end
    return ~fixed
end

function check_if_fixed_y(cb_data, m, pos, i, fixed_y)
    fixed = false
    if pos == 5 || pos == 6
        for fixed_pos in 1:length(fixed_y)
            if (callback_value(cb_data, m[:flby_front_left_bot_y][i]) - 0.0001 <= 
                fixed_y[fixed_pos] <= 
                callback_value(cb_data, m[:flby_front_left_bot_y][i]) + 0.0001)
                fixed = true
            end
        end
    elseif pos == 7 || pos == 8
        for fixed_pos in 1:length(fixed_y)
            if (callback_value(cb_data, m[:flby_front_left_bot_y][i]) + callback_value(cb_data, m[:box_y_axis_cover][i]) - 0.0001 <= 
                fixed_y[fixed_pos] <= 
                callback_value(cb_data, m[:flby_front_left_bot_y][i]) + callback_value(cb_data, m[:box_y_axis_cover][i]) + 0.0001)
                fixed = true
            end
        end
    end
    return ~fixed
end


#Takes a box number to check what boxes are involved in guillotine
function get_involved_boxes(cb_data, m, pos, i)
    involved = []
    push!(involved, i)
    # Check the position of the cut
    for j in 1:length(boxes) - 1
        if i!=j
            if (pos == 1)
                if (callback_value(cb_data, m[:guillotine_flbx][i, j]) == 1)
                    push!(involved, j)
                end
            elseif (pos == 2)
                if (callback_value(cb_data, m[:guillotine_flbx_j_plus][i, j]) == 1)
                    push!(involved, j)
                end
            elseif (pos == 3)
                if (callback_value(cb_data, m[:guillotine_flbx_i_plus][i, j]) == 1)
                    push!(involved, j)
                end
            elseif (pos == 4)
                if (callback_value(cb_data, m[:guillotine_flbx_ij_plus][i, j]) == 1)
                    push!(involved, j)
                end
            elseif (pos == 5)
                if (callback_value(cb_data, m[:guillotine_flby][i, j]) == 1)
                    push!(involved, j)
                end
            elseif (pos == 6)
                if (callback_value(cb_data, m[:guillotine_flby_j_plus][i, j]) == 1)
                    push!(involved, j)
                end
            elseif (pos == 7)
                if (callback_value(cb_data, m[:guillotine_flby_i_plus][i, j]) == 1)
                    push!(involved, j)
                end
            elseif (pos == 8)
                if (callback_value(cb_data, m[:guillotine_flby_ij_plus][i, j]) == 1)
                    push!(involved, j)
                end
            end
            break
        end
    end
    
    if (length(involved) >= 2)
        create_constraint(cb_data, m, involved, pos)
    end  
end

function create_constraint(cb_data, m, involved, pos)
    print(involved)
    
    max_height = 0
    max_height_box = 0
    snd_max_height = 0
    snd_max_height_box = 0

    for i in 1:length(involved)
        height_of_i = callback_value(cb_data, m[:flbz_front_left_bot_z][involved[i]]) + callback_value(cb_data, m[:hob_height_of_box][involved[i]])
        if height_of_i >= max_height
            #update second highest
            snd_max_height = max_height
            snd_max_height_box = max_height_box

            #update highest
            max_height = height_of_i
            max_height_box = involved[i]
        elseif height_of_i >= snd_max_height
            #update second highest
            snd_max_height = height_of_i
            snd_max_height_box = involved[i]
        end
    end

    for i in 1:3
        print('\n')
        print(i)
        print('\n')
        @show callback_value(cb_data, m[:flbx_front_left_bot_x][i])
        @show callback_value(cb_data, m[:flby_front_left_bot_y][i])  
        @show callback_value(cb_data, m[:flbz_front_left_bot_z][i])  
    end

    print('\n')
    print("First ", max_height, " ", max_height_box, "\n")
    print("Second ", snd_max_height, " ", snd_max_height_box, "\n")

    #If same size as sentinel, then the new constraints can't apply. 
    if ~((callback_value(cb_data, m[:lob_length_of_box][max_height_box]) >= 
        (1 - guillotine_fix_var) * callback_value(cb_data, m[:lob_length_of_box][length(boxes)])) &&
        (callback_value(cb_data, m[:wob_width_of_box][max_height_box]) >= 
        (1 - guillotine_fix_var) * callback_value(cb_data, m[:wob_width_of_box][length(boxes)])))

        #check if lowest dimension still same as width of sentinel
        if ~((callback_value(cb_data, m[:lob_length_of_box][max_height_box]) >= 
            (1 - guillotine_fix_var) * callback_value(cb_data, m[:lob_length_of_box][length(boxes)])) &&
            (callback_value(cb_data, m[:wob_width_of_box][max_height_box]) >= 
            (1 - guillotine_fix_var) * callback_value(cb_data, m[:lob_length_of_box][length(boxes)])))
            if pos == 1
                con = @build_constraint(
                    m[:flbx_front_left_bot_x][max_height_box] - 
                    m[:flbx_front_left_bot_x][snd_max_height_box] >= guillotine_fix_var
                    )
                print("added constraint 1 \n")
            elseif pos == 2
                con = @build_constraint(
                    (m[:flbx_front_left_bot_x][max_height_box] + m[:box_x_axis_cover][max_height_box]) -
                    m[:flbx_front_left_bot_x][snd_max_height_box] >= guillotine_fix_var
                    )
                print("added constraint 2 \n")
            elseif pos == 3
                con = @build_constraint(
                    (m[:flbx_front_left_bot_x][snd_max_height_box] + m[:box_x_axis_cover][snd_max_height_box]) - 
                    m[:flbx_front_left_bot_x][max_height_box] >= guillotine_fix_var
                    )
                print("added constraint 3 \n")    
            elseif pos == 4
                con = @build_constraint(
                    (m[:flbx_front_left_bot_x][snd_max_height_box] + m[:box_x_axis_cover][snd_max_height_box]) - 
                    (m[:flbx_front_left_bot_x][max_height_box] + m[:box_x_axis_cover][max_height_box]) >= guillotine_fix_var
                    )
                print("added constraint 4 \n")
            end
            if pos == 1 || pos == 2 || pos == 3 || pos == 4
                MOI.submit(m, MOI.LazyConstraint(cb_data), con)
            end
        end
        if ~((callback_value(cb_data, m[:lob_length_of_box][max_height_box]) >= 
            (1 - guillotine_fix_var) * callback_value(cb_data, m[:wob_width_of_box][length(boxes)])) &&
            (callback_value(cb_data, m[:wob_width_of_box][max_height_box]) >= 
            (1 - guillotine_fix_var) * callback_value(cb_data, m[:wob_width_of_box][length(boxes)])))
            if pos == 5
                con = @build_constraint(
                    m[:flby_front_left_bot_y][max_height_box] - 
                    m[:flby_front_left_bot_y][snd_max_height_box] >= guillotine_fix_var
                    )
                print("added constraint 5 \n")
            elseif pos == 6
                con = @build_constraint(
                    (m[:flby_front_left_bot_y][max_height_box] + m[:box_y_axis_cover][max_height_box]) -
                    m[:flby_front_left_bot_y][snd_max_height_box] >= guillotine_fix_var
                    )
                print("added constraint 6 \n")
            elseif pos == 7
                con = @build_constraint(
                    (m[:flby_front_left_bot_y][snd_max_height_box] + m[:box_y_axis_cover][snd_max_height_box]) - 
                    m[:flby_front_left_bot_y][max_height_box] >= guillotine_fix_var
                    )
                print("added constraint 7 \n")    
            elseif pos == 8
                con = @build_constraint(
                    (m[:flby_front_left_bot_y][snd_max_height_box] + m[:box_y_axis_cover][snd_max_height_box]) - 
                    (m[:flby_front_left_bot_y][max_height_box] + m[:box_y_axis_cover][max_height_box]) >= guillotine_fix_var
                    )
                print("added constraint 8 \n")
            end
            if pos == 5 || pos == 6 || pos == 7 || pos == 8
                MOI.submit(m, MOI.LazyConstraint(cb_data), con)
            end  
        end
    end

end


end



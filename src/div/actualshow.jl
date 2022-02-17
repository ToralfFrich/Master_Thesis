    #Geometric
    
    """
    print("GEOMETRIC\n")
    for i in 1:length(boxes)
        print(i)
        print('\n')
        @show value(m[:flbx_front_left_bot_x][i])
        @show value(m[:flby_front_left_bot_y][i])  
        @show value(m[:flbz_front_left_bot_z][i])  
    end
    print('\n')
    for i in 1:length(boxes)
        print(i)
        print('\n')
        @show value(m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i])
        @show value(m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i])  
        @show value(m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i])  
    end
    print('\n')
    """

    """
    for i in 1:length(boxes)
        print(i)
        print('\n')
        @show value(m[:lpx_length_of_box_parallel_to_x][i])
        @show value(m[:lpy_length_of_box_parallel_to_y][i])  
        @show value(m[:lpz_length_of_box_parallel_to_z][i])
        @show value(m[:wpx_width_of_box_parallel_to_x][i])
        @show value(m[:wpy_width_of_box_parallel_to_y][i])  
        @show value(m[:wpz_width_of_box_parallel_to_z][i])    
    end
    """
    
    """
    for i in 1:length(boxes)-1
        print(i)
        print('\n')
        @show value(m[:robot_simple][i])
        @show value(m[:robot_simple_x][i])
 
        @show value(m[:robot_simple_y][i])
        
        @show value(m[:robot_simple_z][i])
        
    end
    """
    
    """
    for i in 1:length(boxes)-2
        @show value(m[:c_robot_simple_x1][i])
        @show value(m[:c_robot_simple_y1][i])
        @show value(m[:c_robot_simple_z1][i])
    end
    """

    """
    for i in 1:length(boxes)-1
        on_top = value(m[:if_pbs_i][i])
        on_ground = value(m[:above_ground][i])
        if_on_top = value(m[:if_pbs_i][i])
        print(i, " ")
        @show on_top 
        @show on_ground
        @show if_on_top
    end

    for i in 1:length(boxes)-1
        for j in 1:length(boxes)-1
            if i != j
                print(i, j,'\n')
                if1 = value(m[:if1_equal_numbers][i, j])
                if2 = value(m[:if2_xj_l_xi_xcoveri_ij][i, j])
                if3 = value(m[:if3_xj_xcoverj_g_xi_ij][i, j])
                if4 = value(m[:if4_yj_l_yi_ycoveri_ij][i, j])
                if5 = value(m[:if5_yj_ycoverj_g_yi_ij][i, j])
                @show if1 
                @show if2
                @show if3
                @show if4 
                @show if5
            end
        end
    end
    """

    """
    print('\n')
    print("PARTIAL BASE\n")
    #PBS
    for i in 1:length(boxes)
        pbs_for_one = value(m[:pbs_box_i][i])
        print(i, " ")
        @show pbs_for_one 
    end
    print('\n')
    for i in 1:length(boxes)
        pbs_for_one_100 = value(m[:pbs_box_i][i])/area_of_box[i]*100
        print(i, " ")
        @show pbs_for_one_100
    end
    """
    
    
    """
    print('\n')
    
    print("MB STATIC STABILITY \n")
    for i in 1:length(boxes)-1
        boxes_providing_var_support = value(m[:sum_of_how_many_boxes_provide_var_support][i])
        print(i, " ")
        @show boxes_providing_var_support
    end
    print('\n')
    """
    
    """
    print("GUILLOTINE\n")
    for i in 1:length(boxes)-1
        print(i, '\n')
        cut_x = value(m[:cut_flbx_left_i][i])
        cut_x_i = value(m[:cut_flbx_i_plus_right][i])
        cut_x_j = value(m[:cut_flbx_j_plus_left_i][i])
        cut_x_ij = value(m[:cut_flbx_ij_plus_right][i]) 
        cut_y = value(m[:cut_flby_right][i])
        cut_y_i = value(m[:cut_flby_i_plus_left][i]) 
        cut_y_j = value(m[:cut_flby_j_plus_right][i])
        cut_y_ij = value(m[:cut_flby_ij_plus_left][i])
        @show cut_x
        @show cut_x_i
        @show cut_x_j
        @show cut_x_ij
        @show cut_y
        @show cut_y_i
        @show cut_y_j
        @show cut_y_ij
    end
    """
    """

    for i in 1:length(boxes)-1
        for j in 1:length(boxes)-1
            if i != j
                print(i, j,'\n')
                maxx = value(m[:max_cut_flbx_left_ij][i, j])
                maxxi = value(m[:max_cut_flbx_i_plus_right_ij][i, j])
                maxxj = value(m[:max_cut_flbx_j_plus_left_ij][i, j])
                maxxij = value(m[:max_cut_flbx_ij_plus_right_ij][i, j])
                maxy = value(m[:max_cut_flby_right_ij][i, j])
                maxyi = value(m[:max_cut_flby_i_plus_left_ij][i, j])
                maxyj = value(m[:max_cut_flby_j_plus_right_ij][i, j])
                maxyij = value(m[:max_cut_flby_ij_plus_left_ij][i, j])
                @show maxx 
                @show maxxi
                @show maxxj
                @show maxxij 
                @show maxy
                @show maxyi 
                @show maxyj
                @show maxyij
                minx = value(m[:min_cut_flbx_left_ij][i, j])
                minxi = value(m[:min_cut_flbx_i_plus_right_ij][i, j])
                minxj = value(m[:min_cut_flbx_j_plus_left_ij][i, j])
                minxij = value(m[:min_cut_flbx_ij_plus_right_ij][i, j])
                miny = value(m[:min_cut_flby_right_ij][i, j])
                minyi = value(m[:min_cut_flby_i_plus_left_ij][i, j])
                minyj = value(m[:min_cut_flby_j_plus_right_ij][i, j])
                minyij = value(m[:min_cut_flby_ij_plus_left_ij][i, j])
                @show minx 
                @show minxi
                @show minxj
                @show minxij 
                @show miny
                @show minyi 
                @show minyj
                @show minyij
            end
        end
    end
    """

    """
    for i in 1:length(boxes)-1
        print(i, '\n')
        maxx = value(m[:max_cut_flbx_left_i][i])
        maxxi = value(m[:max_cut_flbx_i_plus_right_i][i])
        maxxj = value(m[:max_cut_flbx_j_plus_left_i][i])
        maxxij = value(m[:max_cut_flbx_ij_plus_right_i][i])
        maxy = value(m[:max_cut_flby_right_i][i])
        maxyi = value(m[:max_cut_flby_i_plus_left_i][i])
        maxyj = value(m[:max_cut_flby_j_plus_right_i][i])
        maxyij = value(m[:max_cut_flby_ij_plus_left_i][i])
        @show maxx 
        @show maxxi
        @show maxxj
        @show maxxij 
        @show maxy
        @show maxyi 
        @show maxyj
        @show maxyij
        minx = value(m[:min_cut_flbx_left_i][i])
        minxi = value(m[:min_cut_flbx_i_plus_right_i][i])
        minxj = value(m[:min_cut_flbx_j_plus_left_i][i])
        minxij = value(m[:min_cut_flbx_ij_plus_right_i][i])
        miny = value(m[:min_cut_flby_right_i][i])
        minyi = value(m[:min_cut_flby_i_plus_left_i][i])
        minyj = value(m[:min_cut_flby_j_plus_right_i][i])
        minyij = value(m[:min_cut_flby_ij_plus_left_i][i])
        @show minx 
        @show minxi
        @show minxj
        @show minxij 
        @show miny
        @show minyi 
        @show minyj
        @show minyij
    end
    """
  
    """
    print("MB INCENTIVE \n")
    for i in 1:length(boxes)
        boxes_below_i = value(m[:sum_of_boxes_below_box_i][i])
        print(i, " ")
        @show boxes_below_i
    end
    print('\n')
    
    
    print("PARTIAL BASE LB\n")
    for i in 1:length(boxes)
        print(i, " ")
        @show value(m[:pb_sum_of_mass_on_top_of_i][i])
    end
    print('\n')
    """
    
    """
    print("PPUA LB\n")
    for i in 1:length(boxes)
        print(i, " ")
        @show value(m[:sum_of_mass_on_top_of_i][i])
        @show value(mass_volume[i])
    end
    print('\n')
    """

    """
    print("NUMBER LB\n")
    for i in 1:length(boxes)
        print(i, " ")
        @show value(m[:num_of_boxes_on_top_i][i])
    end
    """
    
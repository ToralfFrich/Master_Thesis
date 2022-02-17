function calc_static_support_factor(i)
    tot_cover_of_i = 0
    for j in 1:length(boxes)
        if j == i
            continue
        end

        box_i_x_axis_cover = lpx_length_of_box_parallel_to_x[i]*lob_length_of_box[i] + wpx_width_of_box_parallel_to_x[i]*wob_width_of_box[i]
        box_i_y_axis_cover = lpy_length_of_box_parallel_to_y[i]*lob_length_of_box[i] + wpy_width_of_box_parallel_to_y[i]*wob_width_of_box[i]

        if (flbz_front_left_bot_z[i] == flbz_front_left_bot_z[j] + hob_height_of_box[j] && 
            flbz_front_left_bot_z[i] - hob_height_of_box[j] >= 0 && 
            flbx_front_left_bot_x[j] > flbx_front_left_bot_x[i] - box_i_x_axis_cover &&
            flbx_front_left_bot_x[j] < flbx_front_left_bot_x[i] + box_i_x_axis_cover &&
            flby_front_left_bot_y[j] > flby_front_left_bot_y[i] - box_i_y_axis_cover &&
            flby_front_left_bot_y[j] < flby_front_left_bot_y[i] + box_i_y_axis_cover)
            
            box_j_x_axis_cover = lpx_length_of_box_parallel_to_x[j]*lob_length_of_box[j] + wpx_width_of_box_parallel_to_x[j]*wob_width_of_box[j]
            box_j_y_axis_cover = lpy_length_of_box_parallel_to_y[j]*lob_length_of_box[j] + wpy_width_of_box_parallel_to_y[j]*wob_width_of_box[j]

            x_axis_covered = min(flbx_front_left_bot_x[i] + box_i_x_axis_cover, flbx_front_left_bot_x[j] + box_j_x_axis_cover) - max(flbx_front_left_bot_x[i], flbx_front_left_bot_x[j])
            y_axis_covered = min(flby_front_left_bot_y[i] + box_i_y_axis_cover, flby_front_left_bot_y[j] + box_j_y_axis_cover) - max(flby_front_left_bot_y[i], flby_front_left_bot_y[j])

            tot_cover_of_i += x_axis_covered*y_axis_covered
        end
    end
    return tot_cover_of_i
end
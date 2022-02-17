# ======= ALL ROTATIONS ALLOWED START =======
#lx + ly + lz = 1
@constraints(model, begin
    [i=1:length(boxes)], (lpx_length_of_box_parallel_to_x[i] + 
    lpy_length_of_box_parallel_to_y[i] + 
    lpz_length_of_box_parallel_to_z[i] == 1)
end)

#wx + wy + wz = 1
@constraints(model, begin
    [i=1:length(boxes)], (wpx_width_of_box_parallel_to_x[i] + 
    wpy_width_of_box_parallel_to_y[i] + 
    wpz_width_of_box_parallel_to_z[i] == 1)
end)

#hx + hy + hz = 1
@constraints(model, begin
    [i=1:length(boxes)], (hpx_height_of_box_parallel_to_x[i] + 
    hpy_height_of_box_parallel_to_y[i] + 
    hpz_height_of_box_parallel_to_z[i] == 1)
end)

#lx + wx + hx = 1
@constraints(model, begin
    [i=1:length(boxes)], (lpx_length_of_box_parallel_to_x[i] + 
    wpx_width_of_box_parallel_to_x[i] + 
    hpx_height_of_box_parallel_to_x[i] == 1)
end)


#ly + wy + hy = 1
@constraints(model, begin
    [i=1:length(boxes)], (lpy_length_of_box_parallel_to_y[i] + 
    wpy_width_of_box_parallel_to_y[i] + 
    hpy_height_of_box_parallel_to_y[i] == 1)
end)

#lz + wz + hz = 1
@constraints(model, begin
    [i=1:length(boxes)], (lpz_length_of_box_parallel_to_z[i] + 
    wpz_width_of_box_parallel_to_z[i] + 
    hpz_height_of_box_parallel_to_z[i] == 1)
end)
# ======= ALL ROTATIONS ALLOWED END =======
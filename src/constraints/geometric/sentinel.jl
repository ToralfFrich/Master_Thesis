module Sentinel

include("./constants.jl")
using JuMP
using .Constants

export init_sentinel

function init_sentinel(m)

    fix(m[:flbx_front_left_bot_x][length(boxes)], 0, force=true)
    fix(m[:flby_front_left_bot_y][length(boxes)], 0, force=true)
    fix(m[:flbz_front_left_bot_z][length(boxes)], 0, force=true)

    fix(m[:lpx_length_of_box_parallel_to_x][length(boxes)], 1, force=true)
    fix(m[:wpy_width_of_box_parallel_to_y][length(boxes)], 1, force=true)
    return m
end

end
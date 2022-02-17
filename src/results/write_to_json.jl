module WriteToJSON

include("./../constraints/geometric/constants.jl")
using JuMP
using DelimitedFiles
using Dates
using JSON
using JSON3
using .Constants

export write_to_json_simple

function write_to_json_simple(m)

    for i in 1:length(boxes)-1
        print(boxes[i])
    end

    positions = []
    dimensions = []
    for i in 1:length(boxes)-1
        if (value((m[:lpx_length_of_box_parallel_to_x])[i]) == 1)
            push!(positions, [
                boxes[i][1]/2 + value(m[:flbx_front_left_bot_x][i]), 
                boxes[i][3]/2 + value(m[:flbz_front_left_bot_z][i]),
                boxes[i][2]/2 + value(m[:flby_front_left_bot_y][i])
                ]
            )
            push!(dimensions,
                [
                    boxes[i][2],
                    boxes[i][3],
                    boxes[i][1]
                ]
            )
        else
            push!(positions, [
                boxes[i][2]/2 + value(m[:flbx_front_left_bot_x][i]), 
                boxes[i][3]/2 + value(m[:flbz_front_left_bot_z][i]),
                boxes[i][1]/2 + value(m[:flby_front_left_bot_y][i])
                ]
            )
            push!(dimensions,
                [
                    boxes[i][1],
                    boxes[i][3],
                    boxes[i][2]
                ]
            )
        end
    end

    inside_json = []
    for i in 1:length(boxes)-1
        dim = Dict(
            "w" => dimensions[i][1], 
            "h" => dimensions[i][2], 
            "d" => dimensions[i][3],
        )
        pos = Dict(
            "x" => positions[i][1], 
            "z" => positions[i][2],
            "y" => positions[i][3] 
            
        )
        push!(inside_json, Dict(
                "dimensions" => dim,
                "position" => pos
            )
        )
    end

    open(resultjson, "w") do io
        JSON3.pretty(io, inside_json)
    end
    
end

end
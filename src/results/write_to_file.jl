module WriteToFile

include("./../constraints/geometric/constants.jl")
using Gurobi, JuMP
using DelimitedFiles
using Dates
using JSON
using JSON3
using .Constants

export write_to_file, write_to_json, append_to_file

function write_to_file(m)
    open(resultfile, "a") do io
        write(io, "========== NEW TEST ========== \n")

        write(io, "Date: ", string(Dates.today()), "\n")
        write(io, "JSON FILE: ", "test.json", "\n")
        write(io, "Time: ", "20", "\n")
        write(io, '\n')


        write(io, "Activated: \n")
        
        write(io, "Rotations Currence:        Y\n")
        #write(io, "Rotations Currence:        N\n")

        #write(io, "Rotations All:             Y\n")
        write(io, "Rotations All:             N\n")
        
        write(io, "Partial Base Stability:    Y\n")
        #write(io, "Partial Base Stability:    N\n")
        
        write(io, "Guillotine:                Y\n")
        #write(io, "Guillotine:                N\n")
        
        write(io, "Multiple Boxes:            Y\n")
        #write(io, "Multiple Boxes:            N\n")
        
        write(io, "Middle Incentive:          Y\n")
        #write(io, "Middle Incentive:          N\n")

        write(io, "Load Balancing:            Y\n")
        #write(io, "Load Balancing:            N\n")

        #write(io, "Partial Base Load Bearing: Y\n")
        write(io, "Partial Base Load Bearing: N\n")

        write(io, "Simple Load Bearing:       Y\n")
        #write(io, "Simple Load Bearing:       N\n")

        #write(io, "Number Load Bearing:       Y\n")
        write(io, "Simple Load Bearing:       N\n")

        #write(io, "Robot Pattern:             Y\n")
        write(io, "Robot Pattern:             N\n")
        write(io, '\n')

        write(io, "Positions: \n")
        positions = 
        [
            [
            value(m[:flbx_front_left_bot_x][i]), 
            value(m[:flby_front_left_bot_y][i]), 
            value(m[:flbz_front_left_bot_z][i])
            ] for i in 1:length(boxes)
        ]
        writedlm(io, transpose(positions))
        write(io, '\n')

        write(io, "Static stabilities: \n")
        static_stabilities = [value(m[:piecewise_partial_static_stability_for_one_box][i]) for i in 1:length(boxes)]
        writedlm(io, transpose(static_stabilities))
        write(io, '\n')

        write(io, "Area covered: \n")
        area_covered = [(value(m[:piecewise_partial_static_stability_for_one_box][i])/area_of_box[i])*100 for i in 1:length(boxes)]
        writedlm(io, transpose(area_covered))
        write(io, '\n')

        write(io, "Guillotine Cut: \n")
        guillotine = 
        [
            [
            value(m[:cut_flbx_left_i][i]), 
            value(m[:cut_flbx_j_plus_left_i][i]), 
            value(m[:cut_flbx_i_plus_right][i]),
            value(m[:cut_flbx_ij_plus_right][i]), 
            value(m[:cut_flby_right][i]), 
            value(m[:cut_flby_j_plus_right][i]),
            value(m[:cut_flby_i_plus_left][i]), 
            value(m[:cut_flby_ij_plus_left][i]),
            ] for i in 1:length(boxes)
        ]
        writedlm(io, transpose(guillotine))
        write(io, '\n')

        write(io, "========== END OF TEST ========== \n")
        write(io, '\n')
        close(io)
    end
end


function write_to_json(m)
    positions = 
        [
            [
            value(m[:flbx_front_left_bot_x][i]), 
            value(m[:flby_front_left_bot_y][i]), 
            value(m[:flbz_front_left_bot_z][i])
            ] for i in 1:length(boxes)
        ]
    static_stabilities = [value(m[:piecewise_partial_static_stability_for_one_box][i]) for i in 1:length(boxes)]
    area_covered = [(value(m[:piecewise_partial_static_stability_for_one_box][i])/area_of_box[i])*100 for i in 1:length(boxes)]
    guillotine = 
        [
            [
            value(m[:cut_flbx_left_i][i]), 
            value(m[:cut_flbx_j_plus_left_i][i]), 
            value(m[:cut_flbx_i_plus_right][i]),
            value(m[:cut_flbx_ij_plus_right][i]), 
            value(m[:cut_flby_right][i]), 
            value(m[:cut_flby_j_plus_right][i]),
            value(m[:cut_flby_i_plus_left][i]), 
            value(m[:cut_flby_ij_plus_left][i]),
            ] for i in 1:length(boxes)
        ]

    inside_json = []
    for i in 1:length(boxes)
        push!(inside_json, Dict(
                "x" => positions[i][1], 
                "y" => positions[i][2], 
                "z" => positions[i][3],
                "partial_base_coverage" => static_stabilities[i],
                "area_covered" => area_covered[i],
                "guillotine" => 
                    [
                    guillotine[i][1], 
                    guillotine[i][2], 
                    guillotine[i][3], 
                    guillotine[i][4], 
                    guillotine[i][5], 
                    guillotine[i][6],
                    guillotine[i][7],
                    guillotine[i][7],
                    ]
                )
        )
    end
    dict = Dict("items" => inside_json)

    open(resultjson, "w") do io
        JSON3.pretty(io, dict)
    end
    
end

function append_to_file(m, mode::Int64)
    open(resultfile, "a") do io
        write(io, string(filename))
        write(io, '\n')
        write(io, string(mode))
        write(io, '\n')
        write(io, "TerminationStatus: ")
        write(io, string(termination_status(m)))
        write(io, '\n')
        write(io, "Time: ")
        write(io, string(solve_time(m)))
        write(io, string(termination_status(m)))
        if (has_values(m))
            write(io, '\n')
            write(io, "ObjectiveValue: ")
            write(io, string(objective_value(m)))
            write(io, '\n')
            write(io, "ObjectiveBound: ")
            write(io, string(objective_bound(m)))
            write(io, '\n')
            write(io, "Gap: ")
            write(io, string(relative_gap(m)))
            write(io, '\n')
            write(io, "ResultCount: ")
            write(io, string(result_count(m)))
            write(io, '\n')
            write(io, "NodeCount: ")
            write(io, string(node_count(m)))
        end
        write(io, '\n')
        write(io, '\n')
        close(io)
    end
end

end
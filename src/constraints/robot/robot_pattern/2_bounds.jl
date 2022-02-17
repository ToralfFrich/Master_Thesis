module RPBounds

include("./../../constraints/geometric/constants.jl")
using JuMP
using .Constants

export rp_bounds

function rp_bounds(m)

    #Check if flbzi < flbzj < flbzi +heighti OR flbzi < flbzj+height < flbzi +height
    @variable(m, rp_ifz_1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifz_1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbz_front_left_bot_z][i] - H * (1 - m[:rp_ifz_1][i, j]) + 0.001  <= 
        m[:flbz_front_left_bot_z][j]
    )

    @variable(m, rp_ifz_2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifz_2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbz_front_left_bot_z][j] - H * (1 - m[:rp_ifz_2][i, j])  <= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i] - 0.001
    )

    @variable(m, rp_ifz_3[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifz_3[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbz_front_left_bot_z][i] - H * (1 - m[:rp_ifz_3][i, j]) + 0.001 <= 
        m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j]
    )

    @variable(m, rp_ifz_4[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifz_4[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbz_front_left_bot_z][j] + m[:hob_height_of_box][j] - H * (1 - m[:rp_ifz_4][i, j])  <= 
        m[:flbz_front_left_bot_z][i] + m[:hob_height_of_box][i] - 0.001
    )


    #Check if flbxi < flbxj < flbxi +xcoveri OR flbxi < flbxj+xcover < flbxi +xcoveri
    @variable(m, rp_ifx_1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifx_1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbx_front_left_bot_x][i] - L * (1 - m[:rp_ifx_1][i, j]) + 0.001 <= 
        m[:flbx_front_left_bot_x][j]
    )

    @variable(m, rp_ifx_2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifx_2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbx_front_left_bot_x][j] - L * (1 - m[:rp_ifx_2][i, j])  <= 
        m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i] - 0.001
    )

    @variable(m, rp_ifx_3[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifx_3[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbx_front_left_bot_x][i] - L * (1 - m[:rp_ifx_3][i, j]) + 0.001 <= 
        m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j]
    )

    @variable(m, rp_ifx_4[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifx_4[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flbx_front_left_bot_x][j] + m[:box_x_axis_cover][j] - L * (1 - m[:rp_ifx_4][i, j])  <= 
        m[:flbx_front_left_bot_x][i] + m[:box_x_axis_cover][i] - 0.001
    )


    #Check if flbyi < flbyj < flbyi +ycoveri OR flbyi < flbyj+ycover < flbyi +ycoveri
    @variable(m, rp_ify_1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cify_1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flby_front_left_bot_y][i] - W * (1 - m[:rp_ify_1][i, j]) + 0.001 <= 
        m[:flby_front_left_bot_y][j]
    )

    @variable(m, rp_ify_2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cify_2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flby_front_left_bot_y][j] - W * (1 - m[:rp_ify_2][i, j])  <= 
        m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i] - 0.001
    )

    @variable(m, rp_ify_3[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cify_3[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flby_front_left_bot_y][i] - W * (1 - m[:rp_ify_3][i, j]) + 0.001 <= 
        m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j]
    )

    @variable(m, rp_ify_4[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cify_4[i=1:length(boxes)-2, j=(i+1):length(boxes)-1],  
        m[:flby_front_left_bot_y][j] + m[:box_y_axis_cover][j] - W * (1 - m[:rp_ify_4][i, j])  <= 
        m[:flby_front_left_bot_y][i] + m[:box_y_axis_cover][i] - 0.001
    )

    # AND Z
    @variable(m, rp_ifz_and1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifz_and1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ifz_1][i, j] + m[:rp_ifz_2][i, j] >= 
        2 * m[:rp_ifz_and1][i, j]
    )

    @variable(m, rp_ifz_and2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifz_and2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ifz_3][i, j] + m[:rp_ifz_4][i, j] >= 
        2 * m[:rp_ifz_and2][i, j]
    )

    #OR Z between flbz and flbzheight
    @variable(m, rp_ifz_or[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifz_or[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ifz_and1][i, j] + m[:rp_ifz_and2][i, j] >= 
        m[:rp_ifz_or][i, j]
    )

    # AND X
    @variable(m, rp_ifx_and1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifx_and1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ifx_1][i, j] + m[:rp_ifx_2][i, j] >= 
        2 * m[:rp_ifx_and1][i, j]
    )

    @variable(m, rp_ifx_and2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifx_and2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ifx_3][i, j] + m[:rp_ifx_4][i, j] >= 
        2 * m[:rp_ifx_and2][i, j]
    )

    #OR X between flbx and flbxcover
    @variable(m, rp_ifx_or[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cifx_or[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ifx_and1][i, j] + m[:rp_ifx_and2][i, j] >= 
        m[:rp_ifx_or][i, j]
    )

    # AND Y
    @variable(m, rp_ify_and1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cify_and1[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ify_1][i, j] + m[:rp_ify_2][i, j] >= 
        2 * m[:rp_ify_and1][i, j]
    )

    @variable(m, rp_ify_and2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cify_and2[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ify_3][i, j] + m[:rp_ify_4][i, j] >= 
        2 * m[:rp_ify_and2][i, j]
    )

    #OR Y between flby and flbycover
    @variable(m, rp_ify_or[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], Bin)
    @constraint(m, rp_cify_or[i=1:length(boxes)-2, j=(i+1):length(boxes)-1], 
        m[:rp_ify_and1][i, j] + m[:rp_ify_and2][i, j] >= 
        m[:rp_ify_or][i, j]
    )

    return m
end

end


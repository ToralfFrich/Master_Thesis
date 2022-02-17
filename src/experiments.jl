using JuMP, Gurobi

include("./master.jl")
include("./basic_model/constants.jl")
using Master
using Constants

function experiments()

    main(1)

end

experiments()
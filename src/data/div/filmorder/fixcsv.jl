using CSV
using DataFrames
using JSON

whitelist = CSV.File("/home/sondre/currence/currence/grab-high-level/kurant/fakewms/data/whitelist.csv", normalizenames=true)
whitedict = Dict([r.id => r for r in whitelist])

coltypes = vcat([String, String, Int, String, Int], repeat(vcat(repeat([Float64], 3), [Bool]), 5))
order = DataFrame(CSV.File("filmordre_semi.csv", normalizenames=true, delim=';', decimal=',', types=coltypes))

new_df = DataFrame(
    Lokasjon=String[],
    Varenr_=Int[],
    Vare=String[],
    x=Float64[],
    y=Float64[],
    z=Float64[],
    depth=Float64[],
    width=Float64[],
    height=Float64[],
    )

for row in eachrow(order)
    for i in 1:row.Antall
        isrotated = getproperty(row, Symbol("rot$i"))
        mindim, maxdim = extrema((whitedict[row.Varenr_].depth, whitedict[row.Varenr_].width))
        depth, width = isrotated ? (maxdim, mindim) : (mindim, maxdim)
        z = max(0.0, getproperty(row, Symbol("z$i")) - 15.0) # z-pos was measured including pallet
        push!(new_df, [row.Lokasjon, row.Varenr_, row.Vare,
                        getproperty(row, Symbol("x$i")),
                        getproperty(row, Symbol("y$i")),
                        z,
                        depth,
                        width,
                        whitedict[row.Varenr_].height,
                        ]
        )
    end
end


CSV.write("filmordre_flat.csv", new_df)

new_df = DataFrame(CSV.File("filmordre_flat.csv", normalizenames=true))

jsondict = map(collect(eachrow(new_df))) do box
                return Dict(
                    "type"=>"box",
                    "score" => 0,
                    "dimensions" => Dict("d" => box.depth, "w" => box.width, "h" => box.height),
                    "position" => Dict(
                        "x" => (box.x/100 + box.depth / 2),
                        "y" => (box.y/100 + box.width / 2),
                        "z" => (box.z/100 + box.height / 2),
                    ),
                    "stack_height" => 0,
                    "approach" => Dict("x" => 0, "y" => 0, "z" => 0),
                    )
                end

open("human.json", "w") do f
    write(f, JSON.json(jsondict, 4))
end

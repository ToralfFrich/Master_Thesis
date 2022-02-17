module Oke2

include("./../../basic_model/constants.jl")
using JSON
using .Constants

using JSON


json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/pool.json")

add = sum(json["items_to_stack"][i]["weight"] for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])
print(add, '\n')

add = sum(json["items_to_stack"][i]["width"] for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])
print(add, '\n')

add = sum(json["items_to_stack"][i]["depth"] for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])
print(add, '\n')

add = sum(json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])
print(add, '\n')

add = sum(json["items_to_stack"][i]["width"]*100*json["items_to_stack"][i]["depth"]*100*json["items_to_stack"][i]["height"]*100 for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = sum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = maximum(json["items_to_stack"][i]["width"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = maximum(json["items_to_stack"][i]["depth"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = maximum(json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = minimum(json["items_to_stack"][i]["width"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = minimum(json["items_to_stack"][i]["depth"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = minimum(json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')

add = minimum(json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')


liste = [json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"])]
sort!(liste)
maks = liste[length(liste)]
andmaks = liste[length(liste)-1]
diff = maks - andmaks
diff = round(diff; digits=4)
print(diff, '\n')

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])
print(add, '\n')




end

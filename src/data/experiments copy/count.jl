module Okei

using JSON
using Statistics

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox9/10box9.json")

lengde = length(json["items_to_stack"])

add = sum(json["items_to_stack"][i]["weight"] for i in 1:lengde)/lengde
print(add, '\n')

w = sum(json["items_to_stack"][i]["width"] for i in 1:lengde)/lengde
print(w, '\n')

d = sum(json["items_to_stack"][i]["depth"] for i in 1:lengde)/lengde
print(d, '\n')

h = sum(json["items_to_stack"][i]["height"] for i in 1:lengde)/lengde
print(h, '\n')
print('\n')

vol = sum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:lengde)
print(vol, '\n')
print('\n')

liste = []
for i in 1:lengde
    append!(liste, Float64(json["items_to_stack"][i]["width"]))
end

print(maximum(liste), '\n')
print(minimum(liste), '\n')

liste = []
for i in 1:lengde
    append!(liste, Float64(json["items_to_stack"][i]["depth"]))
end

print(maximum(liste), '\n')
print(minimum(liste), '\n')

liste = []
for i in 1:lengde
    append!(liste, Float64(json["items_to_stack"][i]["height"]))
end

print(maximum(liste), '\n')
print(minimum(liste), '\n')
print(std(liste), '\n')
end

module Oke3

include("./../../basic_model/constants.jl")
using JSON
using .Constants

using JSON


json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox1/30box1.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox2/30box2.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox3/30box3.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox4/30box4.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox5/30box5.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox6/30box6.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox7/30box7.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox8/30box8.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox9/30box9.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox10/30box10.json")

d = Dict()
for i in 1:length(json["items_to_stack"])
    tup = (json["items_to_stack"][i]["width"], json["items_to_stack"][i]["depth"], json["items_to_stack"][i]["height"])
    if get(d, tup, -1) == -1
        get!(d, tup, 1)
    else
        val = d[tup]
        #print(get(d, tup, -1), '\n')
        val = val + 1
        d[tup] = val
    end
end
print(sum(values(d))/length(d))
print('\n')

end

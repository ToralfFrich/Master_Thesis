module BoxChar

include("./../../constraints/geometric/constants.jl")
using JSON
using .Constants

using JSON

"""
json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox6/30box6.json")

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


print('\n')


json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox7/30box7.json")

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

print('\n')


json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox8/30box8.json")

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

print('\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox9/30box9.json")

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


print('\n')


json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox10/30box10.json")

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

print('\n')
"""

"""
json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox1/30box1.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox2/30box2.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox3/30box3.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox4/30box4.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox5/30box5.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox6/30box6.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox7/30box7.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox8/30box8.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox9/30box9.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')

json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox10/30box10.json")

wd = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["depth"]) for i in 1:length(json["items_to_stack"])]
wh = [abs(json["items_to_stack"][i]["width"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]
dh = [abs(json["items_to_stack"][i]["depth"] - json["items_to_stack"][i]["height"]) for i in 1:length(json["items_to_stack"])]

add = sum((wd[i] + wh[i] + dh[i])/3 for i in 1:length(json["items_to_stack"]))/length(json["items_to_stack"])

print(add, '\n')


json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox1/7box1.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')



json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox2/7box2.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')




json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox3/7box3.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')


json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox4/7box4.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')



json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox5/7box5.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')



json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox6/7box6.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')



json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox7/7box7.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')



json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox8/7box8.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')



json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox9/7box9.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')



json = JSON.parsefile("/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments//Nbox10/7box10.json")

add = minimum(json["items_to_stack"][i]["width"]*json["items_to_stack"][i]["depth"]*json["items_to_stack"][i]["height"] for i in 1:length(json["items_to_stack"]))
print(add, '\n')


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


"""

end

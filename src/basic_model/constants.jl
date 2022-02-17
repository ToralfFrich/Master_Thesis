module Constants

include("./read_json.jl")
using JSON
using .ReadJson

export setFileName, boxes, area_of_box, L, W, H, pb_ss_var, max_LW, lin_plus, lin_plus_2, lin_min, lin_min_2, guillotine_ds_var, masses, sum_of_masses, cm_x_interval_1, cm_x_interval_2, cm_y_interval_1, cm_y_interval_2, guillotine_fix_var, mass_density, max_allowed_weight, max_allowed_weight_constant, mult_boxes_ss_var, number_of_boxes, lb_number_of_boxes, mass_volume, resultfile, resultjson, filename

clusterpath = "/cluster/home/tcfrich"

#JSON
filename = "/Users/Toralf/Desktop/Master/Package/Master/src/data/experiments/Nbox10/3box10.json"
json = ReadJson.get_data_from_json(filename)
boxes = ReadJson.set_boxes(json)
masses = ReadJson.set_masses(json)
L = ReadJson.set_pallet_length(json)
W = ReadJson.set_pallet_width(json)
H = 2
resultfile = "/Users/Toralf/Desktop/Master/Package/Master/src/results/results.txt"
resultjson = "/Users/Toralf/Desktop/Master/Package/Master/src/results/results.json"


#VARIABLES 

# ====== TESTING START =====

# A box is made up of its [length, width, height]. The last box is the sentinel => Height = 0
#boxes = [[1, 1, 1], [1, 1, 1], [1, 1, 0]]
#boxes = [[1, 1, 1], [1, 1, 1], [1, 1, 1], [2, 2, 0]]
#boxes = [[3, 3, 1], [1, 1, 1], [3, 3, 0]]
#boxes = [[1, 1, 1], [2, 2, 2], [2, 2, 0]]
#boxes = [[10, 5, 7], [7, 8, 3], [3, 3, 3]]


# A box must have a mass (in kg)
#masses = [1, 1, 1, 0]
#masses = [3, 1, 0]


#Euro pallet dimensions: H must be somewhat larger than the total height of the boxes as some error can occur.
#L = 2.1
#W = 2.1
#H = 3.1

# ===== TESTING FINISHED =====

#partial base static stability variable. The one that decides how much static stability there should be.
pb_ss_var = 0.7
mult_boxes_ss_var = 0.05
number_of_boxes = 2

#guillotine_cut_variable. The one that decides how many percentages of H are allowed as a guillotine cut
guillotine_ds_var = 0.6
guillotine_fix_var = 0.05

#load balancing area. Can be split into two more variables to have separate for x and y. 
load_balancing_lower = 0.4
load_balancing_upper = 0.6


#load bearing. Relationship between area and load bearing. 2 = 1*1 box able to carry 2 kg. 
#CHOOSE THIS OR NEXT ONE IN SIMPLE LB CALC
load_bearing_factor = 1000
max_allowed_weight = [load_bearing_factor * (boxes[i][1] * boxes[i][2]) for i in 1:length(boxes)-1]
lb_number_of_boxes = 3

# In this calc, it doesn't depend on the size of box, but rather on the box walls and how many layers they consist of.
max_allowed_weight_constant = 30


#CONSTANTS 

area_of_box = [boxes[i][1]*boxes[i][2] for i in 1:length(boxes)]

cm_x_interval_1 = load_balancing_lower * boxes[length(boxes)][1]
cm_x_interval_2 = load_balancing_upper * boxes[length(boxes)][1]
cm_y_interval_1 = load_balancing_lower * boxes[length(boxes)][2]
cm_y_interval_2 = load_balancing_upper * boxes[length(boxes)][2]

#linearisation constants
max_LW = max(L, W)
lin_plus = [i*(0.5*(L+W))/9 for i in 1:9]
lin_plus_2 = [lin_plus[i]^2 for i in 1:9]
lin_min = [
    -0.5*max_LW, 
    -0.7*0.5*max_LW, 
    -0.4*0.5*max_LW, 
    -0.1*0.5*max_LW, 
    0.1*0.5*max_LW, 
    0.3*0.5*max_LW, 
    0.4*0.5*max_LW, 
    0.7*0.5*max_LW, 
    0.5*max_LW
    ]
lin_min_2 = [lin_min[i]^2 for i in 1:9]

sum_of_masses = sum(masses)
mass_density = [masses[i]/(boxes[i][1] * boxes[i][2]) for i in 1:length(boxes)]
mass_volume = [(boxes[i][1]*10 * boxes[i][2]*10 * boxes[i][3]*10) for i in 1:length(boxes)]

end
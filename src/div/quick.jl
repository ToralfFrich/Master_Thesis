using Gurobi, JuMP

boxes = [[1, 1, 1], [2, 2, 2]]

hei = 3

@show hei .>= [boxes[i][1] + boxes[i][2] for i in 1:length(boxes)]

print([boxes[i][1] + boxes[i][2] for i in 1:length(boxes)])
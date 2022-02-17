module ReadJson

using JSON

function get_data_from_json(filename)
    return JSON.parsefile(filename)
end

function set_pallet_length(json)
    return get(json, "pallet_width", 0)
end

function set_pallet_width(json)
    return get(json, "pallet_depth", 0)
end

function set_boxes(json)
    dict_boxes = get(json, "items_to_stack", 0)
    list = [[get(dict_boxes[i], "width", 0), get(dict_boxes[i], "depth", 0), get(dict_boxes[i], "height", 0)] for i in 1:length(dict_boxes)]
    push!(list, [set_pallet_length(json), set_pallet_width(json), 0])
    return list
end

function set_masses(json)
    dict_boxes = get(json, "items_to_stack", 0)
    list = [get(dict_boxes[i], "weight", 0) for i in 1:length(dict_boxes)]
    push!(list, 0)
    return list
end

end

------------ MAP A0001 ------------

local map = {}

map.size = {width = 960, height = 640}
map.imageName = "MapA0001Bg.png"

local objects = {}

local object = {
    points = {
        {x=400,  y=400}, {x=520,  y=520},
     }
}
objects["path:1"] = object

local object = {
    radius = 51,
    tag = 0,
    x = 300,
    y = 301,
}
objects["range:21"] = object



----

map.objects = objects

return map

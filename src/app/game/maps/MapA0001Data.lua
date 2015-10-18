
------------ MAP A0001 ------------

local map = {}

map.size = {width = 960, height = 640}
map.imageName = "Map/level1-A0001.tmx"

local objects = {}

local object = {
    points = {
        {x = 510, y = 252}, {x = 459, y = 312},
        {x = 546, y = 301},
    }
}
objects["path:22"] = object

----

local object = {
    radius = 51,
    tag = 0,
    x = 300,
    y = 301,
}
objects["range:21"] = object


map.objects = objects

return map

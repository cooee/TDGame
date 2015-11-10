
------------ MAP A0001 ------------

local map = {}

map.size = {width = 960, height = 640}
map.imageName = "Map/level1-A0001.tmx"

local objects = {}

local object = {
    points = {
        {x = 200, y = 520}, {x = 202, y = 439},
        {x = 120, y = 439}, {x = 122, y = 208},
        {x = 192, y = 203}, {x = 205, y = 122},
        {x = 434, y = 120}, {x = 444, y = 202},
        {x = 842, y = 207},
    }
}
objects["path:26"] = object

----

local object = {
    radius = 51,
    tag = 0,
    x = 842,
    y = 207,
}
objects["range:21"] = object

----

local object = {
    defineId = "IncreaseHp",
    flipSprite = false,
    tag = 0,
    x = 860,
    y = 255,
}
objects["static:23"] = object

----

local object = {
    defineId = "IncreaseHp",
    flipSprite = false,
    tag = 0,
    x = 203,
    y = 519,
}
objects["static:25"] = object

----

map.objects = objects

return map

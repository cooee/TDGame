
------------ MAP A0002 ------------

local map = {}

map.size = {width = 960, height = 640}
map.imageName = "MapA0002Bg.png"

local objects = {}

local object = {
    points = {
        { 200,  520}, { 199,  448}, { 125,  447}, { 123,  202}, { 195,  201}, { 194,  116},
        { 440,  120}, { 438,  206}, { 838,  204},
     }
}
objects["path:3"] = object

----

local object = {
    radius = 32,
    tag = 0,
    x = 837,
    y = 205,
}
objects["range:28"] = object

----

local object = {
    radius = 38,
    tag = 0,
    x = 542,
    y = 1111,
}
objects["range:30"] = object

----

local object = {
    behaviors = {
        "CampBehavior",
        "CollisionBehavior",
        "DestroyedBehavior",
        "FireBehavior",
        "TowerBehavior",
        "TowerDecorateBehavior",
        "UpgradeBehavior",
    },
    campId = 1,
    collisionEnabled = true,
    defineId = "Tower02",
    flipSprite = false,
    tag = 0,
    towerId = "Tower02L01",
    x = 200,
    y = 360,
}
objects["static:31"] = object

----

map.objects = objects

return map


--[[--

定义了所有的静态对象

]]

local MapConstants = require("app.game.map.MapConstants")

local MoveObjectsProperties = {}

local defines = {}


----------------------------------------

local object = {
    classId       = "move",
    imageName     =  "temp.png",
    radius        = 40,
    radiusOffsetY = 30,
    framesTime    = 0.25,
    scale         = 1.2,
    behaviors     = {"NPCBehavior"},
}

defines["move"] = object

----------------------------------------

function MoveObjectsProperties.getAllIds()
    local keys = table.keys(defines)
    table.sort(keys)
    return keys
end

function MoveObjectsProperties.get(defineId)
    assert(defines[defineId], string.format("MoveObjectsProperties.get() - invalid defineId %s", tostring(defineId)))
    return clone(defines[defineId])
end

function MoveObjectsProperties.isExists(defineId)
    return defines[defineId] ~= nil
end

return MoveObjectsProperties

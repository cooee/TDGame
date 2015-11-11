
--[[--

定义了所有的静态对象

]]

local MapConstants = require("app.game.map.MapConstants")

local MoveObjectsProperties = {}

local defines = {}


----------------------------------------

local object = {
    classId       = "move", -- 类型
    npcId         = "NPC002", ---控制npc数据
    behaviors     = {"EnemyBehavior"},
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

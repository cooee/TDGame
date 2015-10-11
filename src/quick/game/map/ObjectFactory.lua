
local StaticObject = require("game.map.StaticObject")
local MoveObject = require("game.map.MoveObject")
local Path         = require("game.map.Path")
local Range        = require("game.map.Range")

local ObjectFactory = {}

function ObjectFactory.newObject(classId, id, state, map)
    local debug = map:isDebug()
    local object

    if classId == "static" then
        object = StaticObject.new(id, state, map)
        object:init()
        if debug then
            object:bindBehavior("StaticObjectEditorBehavior")
        end
    elseif classId == "move" then
        object = MoveObject.new(id, state, map)
        object:init()
        if debug then
            object:bindBehavior("StaticObjectEditorBehavior")
        end
    elseif classId == "path" then
        object = Path.new(id, state, map)
        object:init()
        if debug then
            object:bindBehavior("PathEditorBehavior")
        end

    elseif classId == "range" then
        object = Range.new(id, state, map)
        object:init()
        if debug then
            object:bindBehavior("RangeEditorBehavior")
        end

    else
        assert(false, string.format("Map:newObject() - invalid classId %s", tostring(classId)))
    end

    return object
end

return ObjectFactory

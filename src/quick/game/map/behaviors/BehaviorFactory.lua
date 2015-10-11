
local behaviorsClass = {
    CollisionBehavior          = require("game.map.behaviors.CollisionBehavior"),
    CampBehavior               = require("game.map.behaviors.CampBehavior"),
    DecorateBehavior           = require("game.map.behaviors.DecorateBehavior"),
    BuildingBehavior           = require("game.map.behaviors.BuildingBehavior"),
    FireBehavior               = require("game.map.behaviors.FireBehavior"),
    MovableBehavior            = require("game.map.behaviors.MovableBehavior"),
    DestroyedBehavior          = require("game.map.behaviors.DestroyedBehavior"),
    TowerBehavior              = require("game.map.behaviors.TowerBehavior"),
    NPCBehavior                = require("game.map.behaviors.NPCBehavior"),

    PathEditorBehavior         = require("game.map.behaviors.PathEditorBehavior"),
    RangeEditorBehavior        = require("game.map.behaviors.RangeEditorBehavior"),
    StaticObjectEditorBehavior = require("game.map.behaviors.StaticObjectEditorBehavior"),

    ----------------------myc
    
    BloodBehavior              = require("game.map.behaviors.BloodBehavior"),
    RapidBehavior              = require("game.map.behaviors.RapidBehavior"),
    TowerDecorateBehavior      = require("game.map.behaviors.TowerDecorateBehavior"),
    UpgradeBehavior            = require("game.map.behaviors.UpgradeBehavior"),
    
}

local BehaviorFactory = {}

function BehaviorFactory.createBehavior(behaviorName)
    local class = behaviorsClass[behaviorName]
    assert(class ~= nil, string.format("BehaviorFactory.createBehavior() - Invalid behavior name \"%s\"", tostring(behaviorName)))
    return class.new()
end

local allStaticObjectBehaviors = {
    BuildingBehavior  = true,
    CampBehavior      = true,
    CollisionBehavior = true,
    DecorateBehavior  = true,
    DestroyedBehavior = true,
    FireBehavior      = true,
    MovableBehavior   = true,
    NPCBehavior       = true,
    TowerBehavior     = true,
    
    BloodBehavior     = true,
    TowerDecorateBehavior     = true,
    UpgradeBehavior  = true,
}

function BehaviorFactory.getAllStaticObjectBehaviorsName()
    return table.keys(allStaticObjectBehaviors)
end

function BehaviorFactory.isStaticObjectBehavior(behaviorName)
    return allStaticObjectBehaviors[behaviorName]
end

return BehaviorFactory

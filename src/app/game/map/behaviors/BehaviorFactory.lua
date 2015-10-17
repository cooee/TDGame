
local behaviorsClass = {
    CollisionBehavior          = import(".CollisionBehavior"),
    CampBehavior               = import(".CampBehavior"),
    DecorateBehavior           = import(".DecorateBehavior"),
    BuildingBehavior           = import(".BuildingBehavior"),
    FireBehavior               = import(".FireBehavior"),
    MovableBehavior            = import(".MovableBehavior"),
    DestroyedBehavior          = import(".DestroyedBehavior"),
    TowerBehavior              = import(".TowerBehavior"),
    NPCBehavior                = import(".NPCBehavior"),

    PathEditorBehavior         = import(".PathEditorBehavior"),
    RangeEditorBehavior        = import(".RangeEditorBehavior"),
    StaticObjectEditorBehavior = import(".StaticObjectEditorBehavior"),

    ----------------------myc
    
    BloodBehavior              = import(".BloodBehavior"),
    RapidBehavior              = import(".RapidBehavior"),
    TowerDecorateBehavior      = import(".TowerDecorateBehavior"),
    UpgradeBehavior            = import(".UpgradeBehavior"),
    
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

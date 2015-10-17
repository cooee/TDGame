
--[[--

定义了所有的静态对象

]]

local MapConstants = import("..map.MapConstants")

local StaticObjectsProperties = {}

local defines = {}

----------------------------------------

local object = {
    classId      = "static",
    framesName   = "IncreaseHp%04d.png",
    framesBegin  = 1,
    framesLength = 28,
    framesTime   = 1.0 / 28,
    radius       = 60,
    scale        = 2.0,
    offsetY      = 20,
    zorder       = 30000,
    viewZOrdered = false,
}
defines["IncreaseHp"] = object

----------------------------------------

-- local object = {
--     classId     = "static",
--     imageName   = "#Building01.png",
--     radius      = 60,
--     offsetX     = -10,
--     offsetY     = 35,
--     decorations = {},
--     campId      = MapConstants.ENEMY_CAMP,
-- }
-- defines["Building01"] = object

----------------------------------------

local object = {
    classId     = "static",
    imageName   = {"#PlayerTower0101.png", "#PlayerTower0102.png"},
    radius      = 32,
    offsetX     = {-15, -16, -16},
    offsetY     = {3, 3, 2},
    towerId     = "PlayerTower01L01",
    decorations = {"PlayerTower01Destroyed"},
    behaviors   = {"TowerBehavior"},
    fireOffsetX = {0, 0, 0},
    fireOffsetY = {24, 24, 24},
    campId      = MapConstants.PLAYER_CAMP,
}
defines["PlayerTower01"] = object

-- local object = {
--     classId     = "static",
--     imageName   = {"#PlayerTower0201.png", "#PlayerTower0202.png"},
--     radius      = 32,
--     offsetX     = {-15, -16, -16},
--     offsetY     = {3, 3, 2},
--     towerId     = "PlayerTower02L01",
--     decorations = {"PlayerTower02Destroyed", "PlayerTower02Fire"},
--     behaviors   = {"TowerBehavior"},
--     fireOffsetX = {0, 0, 0},
--     fireOffsetY = {24, 24, 24},
--     campId      = MapConstants.PLAYER_CAMP,
-- }
-- defines["PlayerTower02"] = object

-- local object = {
--     classId     = "static",
--     imageName   = {"#gun_tower_1_1.png"},
--     radius      = 32,
--     -- offsetX     = {-15, -16, -16},
--     -- offsetY     = {3, 3, 2},
--     towerId     = "PlayerTower02L01",
--     decorations = {"PlayerTower02Destroyed","PlayerTower02FireAnim"},
--     behaviors   = {"TowerBehavior","TowerDecorateBehavior"},
--     fireOffsetX = {0, 0, 0},
--     fireOffsetY = {24, 24, 24},
--     campId      = MapConstants.PLAYER_CAMP,
-- }
-- defines["PlayerTower02"] = object


local object = {
    classId     = "static",
    imageName   = {"#gun_tower_1_1.png"},
    radius      = 32,
    -- offsetX     = {-15, -16, -16},
    -- offsetY     = {3, 3, 2},
    towerId     = "Tower02L01",
    decorations = {"PlayerTower02Destroyed","Tower02L01FireAnim","Tower02L02FireAnim"},
    behaviors   = {"TowerBehavior","TowerDecorateBehavior", "UpgradeBehavior"},
    fireOffsetX = {0, 0, 0},
    fireOffsetY = {24, 24, 24},
    campId      = MapConstants.PLAYER_CAMP,
}
defines["Tower02"] = object


local object = {
    classId     = "static",
    imageName   = {"#ShellTower_Level_2_1_attackAni_1.png"},
    radius      = 32,
    towerId     = "Tower03L01",
    decorations = {"PlayerTower02Destroyed"},
    behaviors   = {"TowerBehavior","TowerDecorateBehavior"},
    fireOffsetX = {0, 0, 0},
    fireOffsetY = {24, 24, 24},
    campId      = MapConstants.PLAYER_CAMP,
}
defines["Tower03"] = object

----------------------------------------

-- local object = {
--     classId       = "static",
--     imageName     = "#EnemyShip01.png",
--     radius        = 40,
--     radiusOffsetY = 30,
--     offsetY       = 33,
--     decorations   = {"ShipWavesUp", "ShipWaves"},
--     behaviors     = {},
-- }
-- defines["EnemyShip01"] = object


-- local object = {
--     classId       = "static",
--     imageName     = "tower/magic_tower20.png",
--     radius        = 40,
--     radiusOffsetY = 30,
--     offsetY       = 33,
--     behaviors     = {},
-- }

local object = {
    classId     = "static",
    imageName   = "#light_tower_2_1.png",
    radius      = 40,
    offsetX     = {0, 0, 0},
    offsetY     = {0, 0, 0},
    towerId     = "PlayerTower03L01",
    decorations = {"PlayerTower02Destroyed", "PlayerTower03L01FireAnim"},
    behaviors   = {"TowerBehavior","TowerDecorateBehavior","UpgradeBehavior"},
    fireOffsetX = {0, 0, 0},
    fireOffsetY = {0, 0, 0},
    campId      = MapConstants.PLAYER_CAMP,
}
defines["PlayerTower03"] = object

----------------------------------------

function StaticObjectsProperties.getAllIds()
    local keys = table.keys(defines)
    table.sort(keys)
    return keys
end

function StaticObjectsProperties.get(defineId)
    assert(defines[defineId], string.format("StaticObjectsProperties.get() - invalid defineId %s", tostring(defineId)))
    return clone(defines[defineId])
end

function StaticObjectsProperties.isExists(defineId)
    return defines[defineId] ~= nil
end

return StaticObjectsProperties

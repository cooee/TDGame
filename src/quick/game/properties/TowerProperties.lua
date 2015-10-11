
local BulletType = require("game.map.BulletType")

local TowerProperties = {}

local TOWER01_FIRE_RANGE = 175
local TOWER02_FIRE_RANGE = 160

local defines = {}

----------------------------------------

local tower = {
    towerName     = "箭塔",
    towerType     = 1,      -- 炮台类型， 1 = 箭塔, 2 = 火炮
    maxHp         = 2000,   -- 最大 HP
    maxArmor      = 0,      -- 最大装甲
    minDamage     = 70,     -- 对目标的最小伤害
    maxDamage     = 70,     -- 对目标的最大伤害
    cooldown      = 1.5,      -- 开火冷却时间
    fireRange     = TOWER01_FIRE_RANGE, -- 射程
    critical      = 10,     -- 暴击率
    hitrate       = 80,     -- 命中率
    criticalPower = 1.5,    -- 暴击伤害的威力 150%
    bulletType    = BulletType.ARROW, -- 子弹类型
    staticIndex   = 1,
}
defines["PlayerTower01L01"] = tower -- 箭塔第1级

local tower = {
    towerName     = "箭塔",
    towerType     = 1,
    maxHp         = 2800,
    maxArmor      = 20,
    minDamage     = 126,
    maxDamage     = 126,
    cooldown      = 1,
    fireRange     = TOWER01_FIRE_RANGE,
    critical      = 10,
    hitrate       = 80,
    criticalPower = 1.5,
    bulletType    = BulletType.ARROW,
    staticIndex   = 1,
}
defines["PlayerTower01L02"] = tower -- 箭塔第2级

----------------------------------------

local tower = {
    towerName     = "火炮",
    towerType     = 2,      -- 炮台类型， 1 = 箭塔, 2 = 火炮
    maxHp         = 2000,   -- 最大 HP
    maxArmor      = 0,      -- 最大装甲
    minDamage     = 70,     -- 对目标的最小伤害
    maxDamage     = 70,     -- 对目标的最大伤害
    cooldown      = 1.85,      -- 开火冷却时间
    fireRange     = TOWER02_FIRE_RANGE, -- 射程
    critical      = 10,     -- 暴击率
    hitrate       = 80,     -- 命中率
    criticalPower = 1.5,    -- 暴击伤害的威力 150%
    bulletType    = BulletType.CANNON, -- 子弹类型
    staticIndex   = 1,
}
defines["PlayerTower02L01"] = tower -- 箭塔第1级

local tower = {
    towerName     = "火炮",
    towerType     = 2,
    maxHp         = 2800,
    maxArmor      = 20,
    minDamage     = 126,
    maxDamage     = 126,
    cooldown      = 1,
    fireRange     = TOWER02_FIRE_RANGE,
    critical      = 10,
    hitrate       = 80,
    criticalPower = 1.5,
    bulletType    = BulletType.CANNON,
    staticIndex   = 1,
}
defines["PlayerTower02L02"] = tower -- 箭塔第2级


local tower = {
    towerName     = "闪电塔",
    towerType     = 3,      -- 炮台类型， 1 = 箭塔, 2 = 火炮
    maxHp         = 2000,   -- 最大 HP
    maxArmor      = 0,      -- 最大装甲
    minDamage     = 140,     -- 对目标的最小伤害
    maxDamage     = 160,     -- 对目标的最大伤害
    cooldown      = 2,      -- 开火冷却时间
    fireRange     = TOWER01_FIRE_RANGE, -- 射程
    critical      = 10,     -- 暴击率
    hitrate       = 80,     -- 命中率
    criticalPower = 1.5,    -- 暴击伤害的威力 150%
    bulletType    = BulletType.Light, -- 子弹类型
    staticIndex   = 1,
}
defines["PlayerTower03L01"] = tower -- 箭塔第1级

local tower = {
    towerName     = "爆裂塔",
    towerType     = 2,      -- 炮台类型， 1 = 箭塔, 2 = 火炮
    maxHp         = 2000,   -- 最大 HP
    maxArmor      = 0,      -- 最大装甲
    minDamage     = 300,     -- 对目标的最小伤害
    maxDamage     = 400,     -- 对目标的最大伤害
    cooldown      = 1.85,      -- 开火冷却时间
    fireRange     = 140, -- 射程
    critical      = 10,     -- 暴击率
    hitrate       = 100,     -- 命中率
    criticalPower = 1.5,    -- 暴击伤害的威力 150%
    bulletType    = BulletType.CANNON, -- 子弹类型
    staticIndex   = 1,
}
defines["Tower02L01"] = tower -- 箭塔第1级

local tower = {
    towerName     = "爆裂塔",
    towerType     = 2,      -- 炮台类型， 1 = 箭塔, 2 = 火炮
    maxHp         = 2000,   -- 最大 HP
    maxArmor      = 0,      -- 最大装甲
    minDamage     = 300,     -- 对目标的最小伤害
    maxDamage     = 400,     -- 对目标的最大伤害
    cooldown      = 1.85,      -- 开火冷却时间
    fireRange     = 150, -- 射程
    critical      = 10,     -- 暴击率
    hitrate       = 100,     -- 命中率
    criticalPower = 1.5,    -- 暴击伤害的威力 150%
    bulletType    = BulletType.CANNON, -- 子弹类型
    staticIndex   = 1,
}
defines["Tower02L02"] = tower -- 箭塔第1级


local tower = {
    towerName     = "爆裂塔",
    towerType     = 2,      -- 炮台类型， 1 = 箭塔, 2 = 火炮
    maxHp         = 2000,   -- 最大 HP
    maxArmor      = 0,      -- 最大装甲
    minDamage     = 300,     -- 对目标的最小伤害
    maxDamage     = 400,     -- 对目标的最大伤害
    cooldown      = 1.85,      -- 开火冷却时间
    fireRange     = 150, -- 射程
    critical      = 10,     -- 暴击率
    hitrate       = 100,     -- 命中率
    criticalPower = 1.5,    -- 暴击伤害的威力 150%
    bulletType    = BulletType.CANNON, -- 子弹类型
    staticIndex   = 1,
}
defines["Tower03L01"] = tower -- 箭塔第1级

----------------------------------------

function TowerProperties.get(id)
    return clone(defines[id])
end

return TowerProperties

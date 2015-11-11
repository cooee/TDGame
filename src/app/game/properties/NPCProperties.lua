
local BulletType = require("app.game.map.BulletType")

local NPCProperties = {}

local defines = {}

local npc = {
    maxHp             = 100,  -- 最大 HP
    maxArmor          = 0,   -- 最大装甲
    speed             = 3700,  -- 速度
    maxMagic          = 200,  -- 最大 MP
    minDamage         = 20,  -- 火炮的最小伤害
    maxDamage         = 80,  -- 火炮的最大伤害
    cooldown          = 2.5,  -- 火炮冷却时间
    critical          = 5,   -- 暴击率
    hitrate           = 60,   -- 命中率
    heavyArmorDamage  = 100,  -- 对重甲炮台的伤害（100%）
    lightArmorDamage  = 100,  -- 对轻甲炮台的伤害（100%）
    magicShieldDamage = 100,  -- 对魔法炮台的伤害（100%）
    criticalPower     = 1.5,  -- 暴击伤害的威力 150%
    fireRange         = 130,  -- 射程
    money             = 50,
    bulletType        = BulletType.CANNON, -- 子弹类型
    genius = {A01 = 4, A02 = 4, A03 = 4},
}
defines["NPC001"] = npc


local npc = {
    imageName         =  "temp.png",
    radius        = 40,
    radiusOffsetY = 30,
    framesTime    = 0.25,
    scale         = 1.5,

    maxHp             = 100,  -- 最大 HP
    maxArmor          = 0,   -- 最大装甲
    speed             = 370,  -- 速度
    maxMagic          = 200,  -- 最大 MP
    minDamage         = 20,  -- 火炮的最小伤害
    maxDamage         = 80,  -- 火炮的最大伤害
    cooldown          = 2.5,  -- 火炮冷却时间
    critical          = 5,   -- 暴击率
    hitrate           = 60,   -- 命中率
    heavyArmorDamage  = 100,  -- 对重甲炮台的伤害（100%）
    lightArmorDamage  = 100,  -- 对轻甲炮台的伤害（100%）
    magicShieldDamage = 100,  -- 对魔法炮台的伤害（100%）
    criticalPower     = 1.5,  -- 暴击伤害的威力 150%
    fireRange         = 130,  -- 射程
    money             = 50,
    bulletType        = BulletType.CANNON, -- 子弹类型
    genius = {A01 = 4, A02 = 4, A03 = 4},
}
defines["NPC002"] = npc


function NPCProperties.get(id)
    return clone(defines[id])
end

return NPCProperties

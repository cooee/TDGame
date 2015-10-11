
local BulletType   = require("game.map.BulletType")
local ArrowBullet  = require("game.map.bullets.ArrowBullet")
local CannonBullet = require("game.map.bullets.CannonBullet")
local LightBullet = require("game.map.bullets.LightBullet")

local BulletFactory = {}

function BulletFactory.newBullets(bulletType, source, target, delay)
    if bulletType == BulletType.ARROW then
        return {ArrowBullet.new(source, target, delay)}
    elseif bulletType == BulletType.CANNON then
        return {CannonBullet.new(source, target, delay)}
    elseif bulletType == BulletType.Light then
        return {LightBullet.new(source, target, delay)}
    end

    echoError("BulletFactory.newBullets() - invalid bullet type %s", tostring(bulletType))
end

return BulletFactory

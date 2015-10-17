
local BulletType   = import(".BulletType")
local ArrowBullet  = import(".bullets.ArrowBullet")
local CannonBullet = import(".bullets.CannonBullet")
local LightBullet 	= import(".bullets.LightBullet")

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

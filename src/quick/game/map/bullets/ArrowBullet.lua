
local CurvedBulletBase = require("game.map.bullets.CurvedBulletBase")
local ArrowBullet = class("ArrowBullet", CurvedBulletBase)

function ArrowBullet:ctor(source, target, delay)
    local params = {
        flyTime    = 0.5,
        g          = -1800,
        isRotation = true,
        delay      = delay or 0,
    }
    local sprite = display.newSprite("arrow_bullet30.png")
    sprite:setVisible(params.delay == 0)
    local streak = CCMotionStreak:create(0.5, 10, 10, ccc3(0, 255, 0), "arrow_bullet40.png");   
    target.map_:getBatchLayer():addChild(streak);
    -- sprite:addChild(streak)
    -- streak:setPosition(source.x_,source.y_);
    self.streak = streak;

    return ArrowBullet.super.ctor(self, source, target, sprite, params)
end

function ArrowBullet:fireBegan()
    ArrowBullet.super.fireBegan(self)
    self.sprite_:setVisible(true)
end

function ArrowBullet:tick(dt)
    ArrowBullet.super.tick(self,dt);
    local x, y = self.sprite_:getPosition()
    self.streak:setPosition(x,y);
    self.streak:setVisible(true);
    -- self.streak:setPosition(self.sprite_:convertToWorldSpace(ccp(x,y)));
end

function ArrowBullet:hit()
    -- local arrow = display.newSprite("#BrokenArrow01.png")
    -- arrow.hideDelay_ = 2.4
    -- local rotation = self.sprite_:getRotation()
    -- local x, y = self.sprite_:getPosition()
    -- if rotation > 90 then
    --     rotation = rotation - math.random(10, 30)
    -- else
    --     rotation = rotation + math.random(10, 30)
    -- end
    -- arrow:setRotation(rotation)

    local target = self.target_
    -- local targetView = target:getView()
    -- targetView:addChild(arrow)

    target:blood(5);
    self.streak:removeFromParent();

    -- local tx, ty = target.x_, target.y_
    -- local cw, ch = target.spriteSize_[1], target.spriteSize_[2]
    -- cw = cw / 2
    -- ch = ch / 2

    -- if target.flipSprite_ then
    --     x = tx - x + cw
    -- else
    --     x = x - tx + cw
    -- end
    -- arrow:setPosition(x, y - ty - target.offsetY_ + ch)

    -- transition.fadeOut(arrow, {
    --     time = 0.3,
    --     delay = math.random(50, 100) / 100,
    --     onComplete = function()
    --         if not tolua.isnull(arrow) then
    --             arrow:removeSelf()
    --         end
    --     end
    -- })
end

return ArrowBullet

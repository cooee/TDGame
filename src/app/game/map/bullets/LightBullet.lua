
local math2d          = import("...math2d")
local radians4point   = math2d.radians4point
local radians2degrees = math2d.radians2degrees
local degrees2radians = math2d.degrees2radians
local pointAtCircle   = math2d.pointAtCircle
local dist            = math2d.dist

local BulletBase = import(".BulletBase")
local LightBullet = class("LightBullet", BulletBase)
local TowerAnim = import("..TowerAnim");
local Decoration = import("..Decoration")


function LightBullet:ctor(source, target, delay)
    local params = {
        flyTime    = 0.8,
        isRotation = true,
        delay      = delay or 0,
    }
    local anim2 = Decoration.new("LightBulletAnim",1);
    anim2:createView(target.map_:getBatchLayer());
    anim2:getView():setPosition(source.x_,source.y_ + 30);
    anim2:getView():setAnchorPoint(ccp(0,0.5));
    anim2:setVisible(false);
    local sprite = anim2:getView();
    anim2:playAnimationOnce(function()
        anim2:setVisible(false);
    end);
    self.anim = anim2;
    sprite:setZOrder(21000);


    LightBullet.super.ctor(self, source, target, sprite, params.delay)
    self.flyTime_    = checknumber(params.flyTime)
    self.isRotation_ = checkbool(params.isRotation)
    self.startX_ = source.x_;
    self.startY_ = source.y_;
end

function LightBullet:fireBegan()
    LightBullet.super.fireBegan(self)
    self.anim:setVisible(true);
    self.anim:playAnimationOnce(function()
        self.anim:setVisible(false);
    end);
    self.timeOffset_ = self.delay_
end

function LightBullet:tickBullet(dt)
    local time = self.time_ - self.timeOffset_

    -- local x = self.startX_ + time * self.offsetX_
    -- local y = self.startY_ + time * self.offsetY_ + self.g_ * time * time / 2
    -- self.sprite_:setPosition(x, y)

    if self.isRotation_ then
        local x,y = self.target_.x_,self.target_.y_;
        local degrees = radians2degrees(radians4point(self.startX_, self.startY_, x, y))
        self.sprite_:setRotation(degrees)
        local d = dist(self.startX_, self.startY_, x, y);
        self.sprite_:setScaleX(d/80)

    end

    if time >= self.flyTime_ then
        self.over_ = true
    end
end

function LightBullet:checkHit()
    self:hit()
    return true;
end

function LightBullet:hit()
    local object = self.source_;
    if object:hasBehavior("TowerDecorateBehavior") then
        local decorationName = object:getDefineId() .. "FireAnim"    
        if object:isDecorationExists(decorationName) then
            local decoration = object:getDecoration(decorationName)
            decoration:setDisplayFrameIndex(1)
               
        end    
    end
end

return LightBullet


local MoveObjectsProperties = require("game.properties.MoveObjectsProperties")

local ObjectBase = require("game.map.ObjectBase")
local MoveObject = class("MoveObject", ObjectBase)

MOVEDOWN    = 1;
MOVELEFT    = 2;
MOVERIGHT   = 3;
MOVEUP      = 4;

function MoveObject:ctor(id, state, map)
    assert(state.defineId ~= nil, "MoveObject:ctor() - invalid state.defineId")
    local define = MoveObjectsProperties.get(state.defineId)
    for k, v in pairs(define) do
        if state[k] == nil then
            state[k] = v
        end
    end

    MoveObject.super.ctor(self, id, state, map)

    self.radiusOffsetX_ = checkint(self.radiusOffsetX_)
    self.radiusOffsetY_ = checkint(self.radiusOffsetY_)
    self.radius_        = checkint(self.radius_)
    self.flipSprite_    = checkbool(self.flipSprite_)
    self.visible_       = true
    self.valid_         = true
    self.sprite_        = nil
    self.spriteSize_    = nil
    self.direction_     = nil;
    -- self.framesTime_    =0.8
    if self.direction_ == nil then
        -- self.direction_ = MOVEDOWN;
    end
    self.isMoveObject = true;
    self.actions_ = {};
    -- dump(self);
end

function MoveObject:createMoveSprite(file)
    print("file " .. file);
    local pHeroTexture = nil;
    if CCTextureCache:sharedTextureCache():textureForKey(file) then
        pHeroTexture = CCTextureCache:sharedTextureCache():textureForKey(file);
    else
        pHeroTexture = CCTextureCache:sharedTextureCache():addImage(file);
    end
    
    local size = pHeroTexture:getContentSize();
    local cellWidth,cellHeight = size.width/4,size.height/4;
    local firstFrame = nil;
    local animations = {};
    self:release();
    self.moveAnimations_ = animations;

    for k=0,3 do
        local frames = {};
        for i=0,3 do
            local frame = CCSpriteFrame:createWithTexture(pHeroTexture,cc.RectMake(cellWidth*i,k*cellHeight,cellWidth,cellHeight));
            frames[#frames + 1] = frame;
            if firstFrame == nil then
                firstFrame = frame;
            end
        end
        local animation = display.newAnimation(frames,self.framesTime_);
        animation:retain()
        table.insert(self.moveAnimations_,animation);
    end
    local sprite = display.newSprite(firstFrame);

    return sprite;

end

function MoveObject:setDirection(direction)
    if direction ~= self.direction_ and direction <=4 and direction>=1 then
        if self.sprite_ then
           self:playAnimationForever(direction);
           -- self.sprite_:stopAllActions();
           -- self.sprite_:playAnimationForever(self.moveAnimations_[direction]);
        end 
        self:onDirectionChange(direction,self.direction_);
        self.direction_ = direction;
    end
end

function MoveObject:playAnimationForever(animID)
    self:stopAnimation()
    local action = self.sprite_:playAnimationForever(self.moveAnimations_[animID])
    self.actions_[#self.actions_ + 1] = action
end

function MoveObject:stopAnimation()
    for i, action in ipairs(self.actions_) do
        if not tolua.isnull(action) then transition.removeAction(action) end
    end
    self.actions_ = {}
end

function MoveObject:onDirectionChange()

end

function MoveObject:getDirection(direction)
    return self.direction_
end

function MoveObject:getDefineId()
    return self.defineId_
end

function MoveObject:getRadius()
    return self.radius_
end

function MoveObject:isFlipSprite()
    return self.flipSprite_
end

function MoveObject:setFlipSprite(flipSprite)
    self.flipSprite_ = flipSprite
end

function MoveObject:getView()
    return self.sprite_
end

function MoveObject:createView(batch, marksLayer, debugLayer)
    MoveObject.super.createView(self, batch, marksLayer, debugLayer)

    local imageName = self.imageName_
    if type(imageName) == "table" then
            imageName = imageName[1]
    end
    self.sprite_ = self:createMoveSprite(imageName);
    local size = self.sprite_:getContentSize()
    self.spriteSize_ = {size.width, size.height}

    if self.scale_ then
        self.sprite_:setScale(self.scale_)
    end

    self.offsetY_ = self.spriteSize_[2]/2;
    self.sprite_:addNodeEventListener(cc.NODE_EVENT, function(event)
        if event.name == "exit" then
            self:release()
        end
    end)
    batch:addChild(self.sprite_);
    self:setDirection(MOVEDOWN);
end

function MoveObject:release()
    if self.moveAnimations_ then
        for i,v in ipairs(self.moveAnimations_) do
            if v then
                v:release();
            end
        end
        self.moveAnimations_ = nil;
    end
end

function MoveObject:removeView()
    self.sprite_:removeSelf()
    self:release();
    self.sprite_ = nil
    MoveObject.super.removeView(self)
end

function MoveObject:updateView()
    local sprite = self.sprite_
    sprite:setPosition(math.floor(self.x_ + self.offsetX_), math.floor(self.y_ + self.offsetY_))
    -- sprite:setFlipX(self.flipSprite_)
end

function MoveObject:fastUpdateView()
    if not self.updated__ then return end
    local sprite = self.sprite_
    sprite:setPosition(self.x_ + self.offsetX_, self.y_ + self.offsetY_)
    -- sprite:setFlipX(self.flipSprite_)
end

function MoveObject:isVisible()
    return self.visible_
end

function MoveObject:setVisible(visible)
    self.sprite_:setVisible(visible)
    self.visible_ = visible
end

function MoveObject:preparePlay()
end

function MoveObject:vardump()
    local state = MoveObject.super.vardump(self)
    state.defineId    = self.defineId_
    state.flipSprite  = self.flipSprite_
    return state
end

return MoveObject
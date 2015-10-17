
local MapConstants  = import("..MapConstants")
local BulletType    = import("..BulletType")
local BulletFactory = import("..BulletFactory")

local BehaviorBase = import(".BehaviorBase")
local BloodBehavior = class("BloodBehavior", BehaviorBase)

function BloodBehavior:ctor()
    BloodBehavior.super.ctor(self, "BloodBehavior", nil, 1)
end

function BloodBehavior:bind(object)
    object.bloodLock_ = 0;

    if not object.bloodNum_ then
       object.bloodNum_ = 1;
    end


    local function getBloodTime(object)
        return object.bloodTime_
    end
    object:bindMethod(self, "getBloodTime", getBloodTime)

    local function addBloodLock(object)
        object.bloodLock_ = object.bloodLock_ + 1
    end
    object:bindMethod(self, "addBloodLock", addBloodLock)

    local function removeBloodLock(object)
        object.bloodLock_ = object.bloodLock_ - 1
        assert(object.collisionLock_ >= 0,
               "BloodBehavior.removeFireLock() - object.fireLock_ must >= 0")
    end
    object:bindMethod(self, "removeBloodLock", removeBloodLock)

    local function getBloodEnabled(object)
        return object.bloodEnabled_
    end
    object:bindMethod(self, "getFireEnabled", getFireEnabled)

    local function setBloodEnabled(object, enabled)
        object.bloodEnabled_ = enabled
    end
    object:bindMethod(self, "setFireEnabled", setFireEnabled)

    local function blood(object, bloodNum)
        if not object.bloodEnabled_ then
            echoError("BloodBehavior.blood() - fire disabled")
            return
        end


        if object.bloodTime_ > 0 then
            return
        end
        if object.bloodSprite_ then
            object.bloodSprite_:setVisible(true);
        end
        object.bloodNum_ = (bloodNum ~= nil) and bloodNum or 1;

        object.bloodTime_ = object.cooldown_ * math.random(80, 120) / 100
    end
    object:bindMethod(self, "blood", blood)

    local function tick(object, dt)
        local bloodTime_ = object.bloodTime_
        if bloodTime_ > 0 then
            bloodTime_ = bloodTime_ - dt
            if bloodTime_ <= 0 then
                bloodTime_ = 0;
                if object.bloodSprite_ then
                    object.bloodSprite_:setVisible(false);
                end
            end
            object.bloodTime_ = bloodTime_
            if object:hasBehavior("DestroyedBehavior") then
                object:decreaseHp(object.bloodNum_)
                if object:isDestroyed() then
                    print("object:isDestroyed()")
                    g_eventManager:dispatchEvent("destroyed", object);
                    object.bloodTime_ = 0;
                end
            end 
        end
    end
    object:bindMethod(self, "tick", tick);

    local function createView(object, batch, marksLayer, debugLayer)
        object.bloodSprite_ = display.newSprite("effect/iconHeart.png");
        -- dump(object.bloodSprite_);
        marksLayer:addChild(object.bloodSprite_, MapConstants.HP_BAR_ZORDER)
        object.bloodSprite_:align(display.CENTER, 0, 0);
        object.bloodSprite_:setVisible(false);
    end
    object:bindMethod(self, "createView", createView)

    local function removeView(object)
        object.bloodSprite_:removeFromParent();
        object.bloodSprite_ = nil;
    end
    object:bindMethod(self, "removeView", removeView, true)

    local function updateView(object)
        if object.bloodSprite_ then
            local x, y = object.x_, object.y_
            local size =object:getView():getContentSize();
            object.bloodSprite_:setPosition(x, y);
        end
    end

    local function fastUpdateView(object)
        updateView(object)
    end
    object:bindMethod(self, "fastUpdateView", fastUpdateView)

    object:bindMethod(self, "updateView", updateView)

    self:reset(object)
end

function BloodBehavior:unbind(object)
    object.bloodTime_      = nil
    object.bloodEnabled_   = nil
    object.bloodLock_ = nil;
    object:unbindMethod(self, "getBloodTime")
    object:unbindMethod(self, "addBloodLock")
    object:unbindMethod(self, "removeBloodLock")
    object:unbindMethod(self, "getBloodEnabled")
    object:unbindMethod(self, "setBloodEnabled")

    object:unbindMethod(self, "createView")
    object:unbindMethod(self, "fastUpdateView")
    object:unbindMethod(self, "updateView")
    object:unbindMethod(self, "removeView")

    object:unbindMethod(self, "blood")
    object:unbindMethod(self, "tick")
end

function BloodBehavior:reset(object)

    object.cooldown_      = checknumber(object.state_.cooldown)
    object.bloodTime_  = 0
    object.bloodEnabled_   = true


    if type(object.bloodEnabled_) ~= "boolean" then
        object.bloodEnabled_ = true
    end
end

return BloodBehavior

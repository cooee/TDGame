--极速攻击 --myc

local BehaviorBase = import(".BehaviorBase")
local RapidBehavior = class("RapidBehavior", BehaviorBase)

function RapidBehavior:ctor()
    RapidBehavior.super.ctor(self, "RapidBehavior", nil, 1)
    self.rapidTime_ = 1.0;
end

function RapidBehavior:bind(object)
    object.rapidLock_ = 0;

    local function addRapidLock(object)
        object.rapidLock_ = object.rapidLock_ + 1
    end
    object:bindMethod(self, "addRapidLock", addRapidLock)

    local function removeRapidLock(object)
        object.rapidLock_ = object.rapidLock_ - 1
        assert(object.rapidLock_ >= 0,
               "RapidBehavior.removeFireLock() - object.rapidLock_ must >= 0")
    end
    object:bindMethod(self, "removeRapidLock", removeRapidLock)

    local function getRapidEnabled(object)
        return object.rapidEnabled_
    end
    object:bindMethod(self, "getRapidEnabled", getRapidEnabled)

    local function setRapidEnabled(object, enabled)
        object.rapidEnabled_ = enabled
    end
    object:bindMethod(self, "setRapidEnabled", setRapidEnabled)

    --急速攻击
    local function rapid(object)
        if not object.rapidEnabled_ then
            echoError("RapidBehavior.rapid() - fire disabled")
            return
        end

        math.newrandomseed();
        local randomNum = math.random(1,100);
        if randomNum <70 then
            return;
        end

        if self.rapidTime_ > 0 then
            return
        end
        self.fireCooldown_ =  object.fireCooldown_;
        self.rapidTime_ = 0.2; 
    end
    object:bindMethod(self, "rapid", rapid)

    local function tick(object, dt)
        local rapidTime_ = self.rapidTime_
        if rapidTime_ > 0 then
            rapidTime_ = rapidTime_ - dt
            object.fireCooldown_ = 0;
            if rapidTime_ <= 0 then
                rapidTime_ = 0
                object.fireCooldown_ = self.fireCooldown_;
            end
            self.rapidTime_ = rapidTime_
        end
    end
    object:bindMethod(self, "tick", tick)

    self:reset(object)
end

function RapidBehavior:unbind(object)
    object.rapidEnabled_   = nil
    object.rapidLock_ = nil;
    object:unbindMethod(self, "addRapidLock")
    object:unbindMethod(self, "removeRapidLock")
    object:unbindMethod(self, "getRapidEnabled")
    object:unbindMethod(self, "setRapidEnabled")
    object:unbindMethod(self, "rapid")
    object:unbindMethod(self, "tick")
end

function RapidBehavior:reset(object)
    self.rapidTime_        = 0
    object.rapidEnabled_   = true;
end

return RapidBehavior

local TowerProperties = require("app.game.properties.TowerProperties")
local BehaviorBase = import(".BehaviorBase")
local UpgradeBehavior = class("UpgradeBehavior", BehaviorBase)

function UpgradeBehavior:ctor()
    UpgradeBehavior.super.ctor(self, "UpgradeBehavior", nil, 1)
    self.level = 1;
end

function UpgradeBehavior:bind(object)
    local function upgrade(object)
        local DefineId = object:getDefineId();
        local level = object:getLevel();
        local towerID = string.format(DefineId .. "L%02d",level);
        -- local define1 = TowerProperties.get(towerID)
        level = level + 1;
        -- dump(define1)

        
        
        local towerID = string.format(DefineId .. "L%02d",level);
        -- _LogI("level" .. towerID)
        -- local msgTab = {};
        local define = TowerProperties.get(towerID)
        -- for k,v in pairs(define1) do
        --     if v ~= define[k] then
        --         msgTab[#msgTab +1] = " + " .. (define[k] - v)
        --     end
        -- end
        -- dump(define)
        if define then
            object:setTowerId(towerID);
            object:setLevel(level);
            g_Toast:showMsg("升级成功",ccp(object.x_,object.y_ + 50));

            if object:hasBehavior("TowerDecorateBehavior") then
            local decorationName = object:getDecorationName();
            if object:isDecorationExists(decorationName) then
                local decoration = object:getDecoration(decorationName)
                decoration:setDisplayFrameIndex(1)
            end
        end

        else
            _LogI("maxLevel")
            g_Toast:showError("maxLevel");
        end
        

    end
    object:bindMethod(self, "upgrade", upgrade)


    local function getLevel(object)
        return self.level;
    end
    object:bindMethod(self, "getLevel", getLevel)

    local function setLevel(object,level)
        self.level = level;
    end
    object:bindMethod(self, "setLevel", setLevel)

   

    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)
end

function UpgradeBehavior:unbind(object)
    object:unbindMethod(self, "upgrade")
    object:unbindMethod(self, "vardump")
end

return UpgradeBehavior

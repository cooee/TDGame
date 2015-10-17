
local MapConstants = import("..MapConstants")
local Decoration = import("..Decoration")
local TowerAnim = import("..TowerAnim")

local BehaviorBase = import(".BehaviorBase")
local TowerDecorateBehavior = class("TowerDecorateBehavior", BehaviorBase)

function TowerDecorateBehavior:ctor()
    TowerDecorateBehavior.super.ctor(self, "TowerDecorateBehavior", nil, 1)
end

function TowerDecorateBehavior:bind(object)
    object.decorations_ = {}
    for i,k in ipairs(checktable(object.state_.decorations)) do
        object.decorations_[k] = false
    end

    local function isDecorationExists(object, decorationName)
        return object.decorations_[decorationName] ~= nil
    end
    object:bindMethod(self, "isDecorationExists", isDecorationExists)

    local function getDecoration(object, decorationName)
        return object.decorations_[decorationName]
    end
    object:bindMethod(self, "getDecoration", getDecoration)

    local function getDecorationName(object)
        local level = string.format("L%02d",object:getLevel());
        local decorationName = object:getDefineId() .. level .. "FireAnim"
        return decorationName;
    end
    object:bindMethod(self, "getDecorationName", getDecorationName)


    local function updateView(object)
        local objectZOrder = object:getView():getZOrder()
        local view         = object:getView();
        local x, y         = object.x_, object.y_
        local flip         = object.flipSprite_

        local function updateView_(source)
            if not source then return end
            for decorationName, decoration in pairs(source) do
                if not decoration then
                    decoration = TowerAnim.new(decorationName, object.staticIndex_)
                    source[decorationName] = decoration
                    decoration:bindView(view)
                end
            end
        end
        updateView_(object.decorations_)
    end
    object:bindMethod(self, "updateView", updateView)

    local function removeView(object)
        local function removeView_(source)
            if not source then return end
            for decorationName, decoration in pairs(source) do
                if decoration then decoration:removeView() end
                source[decorationName] = false
            end
        end
        removeView_(object.decorations_)
    end
    object:bindMethod(self, "removeView", removeView)


    local function vardump(object, state)
        return state
    end
    object:bindMethod(self, "vardump", vardump)
    -- self:createDecorate(object);
end

-- function TowerDecorateBehavior:createDecorate(object)
--     local source = object.decorations_;
--     local view = object:getView();
--     for decorationName, decoration in pairs(source) do
--         if not decoration then
--             decoration = TowerAnim.new(decorationName, object.staticIndex_)
--             source[decorationName] = decoration
--             decoration:createAnim(view)
--         end
--     end
-- end

function TowerDecorateBehavior:unbind(object)
    object.decorations_ = nil

    object:unbindMethod(self, "isDecorationExists")
    object:unbindMethod(self, "getDecoration")
    object:unbindMethod(self, "getDecorationName")
    object:unbindMethod(self, "updateView")
    object:unbindMethod(self, "fastUpdateView")
    object:unbindMethod(self, "removeView")
    object:unbindMethod(self, "setVisible")
    object:unbindMethod(self, "fadeTo")
    object:unbindMethod(self, "vardump")
end

return TowerDecorateBehavior

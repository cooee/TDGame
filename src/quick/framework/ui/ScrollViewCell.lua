
local ScrollViewCell = class("ScrollViewCell", function(w,h)
    local node = g_UICreator:createNode(0, 0, w, h)
    -- if contentSize then node:setContentSize() end
    node:showRect();
    node:setNodeEventEnabled(true)
    cc(node):addComponent("components.behavior.EventProtocol"):exportMethods()
    return node
end)

function ScrollViewCell:onTouch(event, x, y)
end

function ScrollViewCell:enableBoundle()
end

function ScrollViewCell:onTap(x, y)
end

function ScrollViewCell:onExit()
    self:removeAllEventListeners()
end

return ScrollViewCell

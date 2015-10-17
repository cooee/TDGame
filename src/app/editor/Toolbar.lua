
local AutoLayout = import(".AutoLayout")
local ToolBase   = import(".ToolBase")

local Toolbar = class("Toolbar")

function Toolbar:ctor(map)
  

    self.map_                = map
    self.tools_              = {}
    self.toolsName_          = {}

    self.toolbarHeight_      = 0
    self.defaultTouchTool_   = nil

    self.currentToolName_    = nil
    self.currentButtonIndex_ = nil
    self.mView               = nil

    self.isDefaultTouch_     = false
end

function Toolbar:onTouch(event, x, y)
    if y > self.toolbarHeight_ then
        local ret
        if self.isDefaultTouch_ then
            ret = self.tools_[self.defaultTouchTool_]:onIgnoredTouch(event, x, y, true)
            if ret == ToolBase.DEFAULT_TOUCH_ENDED then
                self.isDefaultTouch_ = false
                ret = false
            end
        else
            ret = self.tools_[self.currentToolName_]:onTouch(event, x, y)
            if ret == ToolBase.TOUCH_IGNORED and self.defaultTouchTool_ then
                ret = self.tools_[self.defaultTouchTool_]:onIgnoredTouch(event, x, y, true)
                if ret == true then
                    self.isDefaultTouch_ = true
                end
            end
        end
        return ret
    end
end

function Toolbar:onButtonTap(selectedTool, selectedButton)
    print("selectedTool:getName() " ..selectedTool:getName())
    for toolName, tool in pairs(self.tools_) do
        if tool ~= selectedTool then
            for i, buttonSprite in ipairs(tool.buttonsSprite) do
                buttonSprite:setSelected(false)
            end
        end
        for buttonIndex, button in ipairs(tool.buttons) do
            if button == selectedButton then
                self.currentButtonIndex_ = buttonIndex
            elseif button.sprite:isSelected() then
                button.sprite:setSelected(false)
            end
        end
    end

    self.currentToolName_ = selectedTool:getName()
    selectedButton.sprite:setSelected(true)
    selectedTool:selected(selectedButton.name)

    -- self:dispatchEvent({
    --     name       = "SELECT_TOOL",
    --     toolName   = self.currentToolName_,
    --     buttonName = selectedButton.name,
    -- })

end

function Toolbar:createView(parent, bgImageName, padding, scale, toolbarLines)
    if self.mView then return end
    scale = 1.5;

    self.mView = display.newNode()
    local bg = g_UICreator:createImage(bgImageName);
    bg:setContentSize(display.width,96);
    bg:setScale9Rect(5,5,5,5);
    bg:align(display.CENTER_BOTTOM, display.cx, 0)
    self.toolbarHeight_ = bg:getContentSize().height
    self.mView:addChild(bg)

    parent:addChild(self.mView)

    local menu = display.newNode()
    local items = {}
    for toolIndex, toolName in ipairs(self.toolsName_) do
        if toolbarLines > 1 and toolIndex == 3 then
            items[#items + 1] = "#"
        elseif toolIndex > 1 then
            items[#items + 1] = "-"
        end

        local tool = self.tools_[toolName]
        tool.buttonsSprite = {}
        for buttonIndex, button in ipairs(tool.buttons) do
            dump(button);
            button.sprite = g_UICreator:createCheckBox({
                on = button.image,
                off = button.imageSelected,
                cross = button.imageSelected,
            })
            button.sprite:addClickEventListener(function() self:onButtonTap(tool, button) end)
            button.sprite:setScale(scale)
            button.sprite:setSelected(false)
            menu:addChild(button.sprite)
            tool.buttonsSprite[#tool.buttonsSprite + 1] = button.sprite
            items[#items + 1] = button.sprite
        end
    end

    self.mView:addChild(menu)
    AutoLayout.alignItemsHorizontally(items, padding * scale, self.toolbarHeight_ / 2, padding * scale, toolbarLines)

    -- 放大缩小按钮
    -- local zoomInButton = ui.newImageMenuItem({
    --     image    = "#ZoomInButton.png",
    --     x        = display.right - 72 * scale,
    --     y        = self.toolbarHeight_ / 2,
    --     listener = function()
    --         local scale = self.map_:getCamera():getScale()
    --         if scale < 2.0 then
    --             scale = scale + 0.5
    --             if scale > 2.0 then scale = 2.0 end
    --             self.map_:getCamera():setScale(scale)
    --             self.map_:updateView()
    --             self.scaleLabel_:setString(string.format("%0.2f", scale))
    --         end
    --     end
    -- })
    local zoomInButton = g_UICreator:createButton("#ZoomInButton.png");
    zoomInButton:move(display.right - 72 * scale,self.toolbarHeight_ / 2)
    zoomInButton:setScale(scale)
    zoomInButton:addTo(self.mView)
    -- local zoomOutButton = ui.newImageMenuItem({
    --     image    = "#ZoomOutButton.png",
    --     x        = display.right - 28 * scale,
    --     y        = self.toolbarHeight_ / 2,
    --     listener = function()
    --         local scale = self.map_:getCamera():getScale()
    --         if scale > 0.5 then
    --             scale = scale - 0.5
    --             if scale < 0.5 then scale = 0.5 end
    --             self.map_:getCamera():setScale(scale)
    --             self.map_:updateView()
    --             self.scaleLabel_:setString(string.format("%0.2f", scale))
    --         end
    --     end
    -- })
    -- zoomOutButton:setScale(scale)

    -- local zoombar = ui.newMenu({zoomInButton, zoomOutButton})
    -- self.mView:addChild(zoombar)

    -- self.scaleLabel_ = ui.newTTFLabel({
    --     text  = "1.00",
    --     font  = ui.DEFAULT_TTF_FONT,
    --     size  = 24 * scale,
    --     color = ccc3(255, 255, 255),
    --     align = ui.TEXT_ALIGN_RIGHT,
    --     x     = display.right - 96 * scale,
    --     y     = self.toolbarHeight_ / 2,
    -- })
    -- self.mView:addChild(self.scaleLabel_)

 

    -- self.mView:addNodeEventListener(cc.NODE_EVENT, function(event)
    --     if event.name == "exit" then
    --         self:removeAllEventListeners()
    --     end
    -- end)

    return self.mView
end

function Toolbar:getView()
    return self.mView
end

function Toolbar:addTool(tool)
    self.tools_[tool:getName()] = tool
    self.toolsName_[#self.toolsName_ + 1] = tool:getName()
end

function Toolbar:getToolByName(toolName)
    return self.tools_[toolName]

end

function Toolbar:setDefaultTouchTool(toolName)
    self.defaultTouchTool_ = toolName
end

function Toolbar:selectButton(toolName, buttonIndex)
    assert(self.mView, "Toolbar sprites not created")
    self:onButtonTap(self.tools_[toolName], self.tools_[toolName].buttons[buttonIndex])
end

function Toolbar:getSelectedButtonName()
    return self.tools_[self.currentToolName_].buttons[self.currentButtonIndex_].name
end

function Toolbar:showNotice(text, fontsize, delay)
    local label = g_UICreator:createLabelTTF({
        text = "Save map ok",
        size = fontsize or 96,
        color = ccc3(100, 255, 100),
        align = cc.TEXT_ALIGNMENT_CENTER,
    });


    label:setPosition(display.cx, display.cy)
    self:getView():addChild(label)

    transition.moveBy(label, {y = 20, time = 1.0, delay = delay or 0.5})
    transition.fadeOut(label, {time = 1.0, delay = delay or 0.5, onComplete = function()
        label:removeSelf()
    end})
end

return Toolbar
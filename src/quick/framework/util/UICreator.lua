
local UICreator = class("UICreator");
function UICreator:ctor()
	print("UICreator:ctor")
    self.mTag = 0x1000;
end

function UICreator:autoCreateTag()
    self.mTag = self.mTag + 1;
    return self.mTag;
end

function UICreator:show()
    print("UICreator:ctor")
end


-- dragMap:loadTextureNormal("DragMapButton.png",1)
-- cc.SpriteFrameCache:getInstance():addSpriteFrames("SheetEditor.plist")
-- dragMap:loadTexturePressed("DragMapButtonSelected.png",1)
-- dragMap:loadTextureDisabled("Default/Button_Disable.png",0)
-- dragMap:setTitleFontSize(14)
-- dragMap:setTitleColor(cc.c3b(65, 65, 70))
-- dragMap:setScale9Enabled(true)
-- dragMap:setCapInsets(cc.rect(5,5,30,30))
-- dragMap:setLayoutComponentEnabled(true)
-- dragMap:setName("dragMap")
-- dragMap:setTag(28)
-- dragMap:setCascadeColorEnabled(true)
-- dragMap:setCascadeOpacityEnabled(true)
-- dragMap:setPosition(48.0000, 48.0000)
local Button = ccui.Button

function Button:setScaleRect(left,top,right,bottom)
    self:setScale9Enabled(true)
    local size = self:getVirtualRendererSize()
    dump(size)
    local w,h = size.width,size.height;
    self:setCapInsets(cc.rect(left,top,w-left-right,h-top-bottom))
end

function UICreator:createButton(file)
    local btn = ccui.Button:create()
    btn:ignoreContentAdaptWithSize(true)
    if type(file) == "table" then
        local name = file.name;
        if name then
            btn:setName(name);
        end
        local normal = file.normal;
        local pressed = file.pressed;
        local disabled = file.disabled;
        if normal then
            btn:loadTextureNormal(normal,1);
        end
        if pressed then
            btn:loadTexturePressed(pressed,1);
        end
        if disabled then
            btn:loadTextureDisabled(disabled,1);
        end


    elseif type(file) == "string" then
        btn:loadTextureNormal(file,1);
        btn:setName(file);
    end

    btn:setCascadeColorEnabled(true)
    btn:setCascadeOpacityEnabled(true)
    if x then
        btn:move(x, y)
    end
    return btn;
end

return UICreator;

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
    return btn;
end


function UICreator:createImage(file)
    local img = ccui.ImageView:create()
    img:ignoreContentAdaptWithSize(true)
    if type(file) == "table" then

        local name = file.name;
        if name then
            img:setName(name);
        end
        if file.file then
           img:loadTexture(file.file,1);
        end
        dump(file)
        if file.scale9Rect then
            dump(file.scale9Rect)
            img:setScale9Rect(unpack(file.scale9Rect));
        end
    elseif type(file) == "string" then
        img:loadTexture(file,1);
        img:setName(file);
    end
    img:setCascadeColorEnabled(true)
    img:setCascadeOpacityEnabled(true)
    return img;
end


function UICreator:createNode(x,y,w,h)
    local node = cc.Node:create()
    if x then
        node:move(x,y);
    end
    if w and h then
        node:setContentSize(w,h)
    end
end

function UICreator:createCheckBox(file)
    local btn = ccui.CheckBox:create()
    btn:ignoreContentAdaptWithSize(true)
    if type(file) == "table" then
        dump(file)
        local name = file.name;
        if name then
            btn:setName(name);
        end
        local normal = file.normal;
        local pressed = file.pressed;
        local disabled = file.disabled;
        if normal then
            local source = normal;
            local isCache = 0;
            if string.byte(source) == 35 then
                source = string.sub(source, 2);
                isCache = 1;
            else
                isCache = 0;
            end
            btn:loadTextureBackGround(source,isCache);
        end
        if pressed then
            local source = pressed;
            local isCache = 0;
            if string.byte(source) == 35 then
                source = string.sub(source, 2);
                isCache = 1;
            else
                isCache = 0;
            end
            btn:loadTextureBackGroundSelected(source,isCache);
        end
        if disabled then
            local source = disabled;
            local isCache = 0;
            if string.byte(source) == 35 then
                source = string.sub(source, 2);
                isCache = 1;
            else
                isCache = 0;
            end
            btn:loadTextureBackGroundDisabled(source,isCache);
        end

    elseif type(file) == "string" then
        btn:loadTextureBackGround(file,0);
        btn:setName(file);
    end

    btn:setCascadeColorEnabled(true)
    btn:setCascadeOpacityEnabled(true)
    return btn;
end

        -- local sourceType = type(source)
        -- if sourceType == "string" then
        --     if string.byte(source) == 35 then -- first char is #
        --         -- create sprite from spriteFrame
        --         if not scale9 then
        --             sprite = spriteClass:createWithSpriteFrameName(string.sub(source, 2))
        --         else
        --             sprite = spriteClass:createWithSpriteFrameName(string.sub(source, 2), params.capInsets)
        --         end
        --         break
        --     end

-- local CheckBox_1 = ccui.CheckBox:create()
-- CheckBox_1:ignoreContentAdaptWithSize(false)
-- CheckBox_1:loadTextureBackGround("Default/CheckBox_Normal.png",0)
-- CheckBox_1:loadTextureBackGroundSelected("Default/CheckBox_Press.png",0)
-- CheckBox_1:loadTextureBackGroundDisabled("Default/CheckBox_Disable.png",0)
-- CheckBox_1:loadTextureFrontCross("Default/CheckBoxNode_Normal.png",0)
-- CheckBox_1:loadTextureFrontCrossDisabled("Default/CheckBoxNode_Disable.png",0)
-- CheckBox_1:setSelected(true)
-- CheckBox_1:setLayoutComponentEnabled(true)
-- CheckBox_1:setName("CheckBox_1")
-- CheckBox_1:setTag(13)
-- CheckBox_1:setCascadeColorEnabled(true)
-- CheckBox_1:setCascadeOpacityEnabled(true)




return UICreator;
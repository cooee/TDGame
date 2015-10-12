
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




return UICreator;
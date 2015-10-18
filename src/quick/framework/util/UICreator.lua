
local UICreator = class("UICreator");


local checkFile = function(file)
    local source = file;
    local isCache = 0;
    if source then
        if string.byte(source) == 35 then
            source = string.sub(source, 2);
            isCache = 1;
        end
    end
    return source,isCache;
end

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
        local normal,isCache = checkFile(file.normal);
        if normal then
            btn:loadTextureNormal(normal,isCache);
        end
        local pressed,isCache = checkFile(file.pressed);
        if pressed then
            btn:loadTexturePressed(pressed,isCache);
        end
        local disabled,isCache = checkFile(file.disabled);
        if disabled then
            btn:loadTextureDisabled(disabled,isCache);
        end
    elseif type(file) == "string" then
        local source,isCache = checkFile(file)
        btn:loadTextureNormal(source,isCache);
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
            local source,isCache = checkFile(file.file)
            img:loadTexture(source,isCache);
        end
        if file.scale9Rect then
            img:setScale9Rect(unpack(file.scale9Rect));
        end
    elseif type(file) == "string" then  
        local source,isCache = checkFile(file)
        img:loadTexture(source,isCache);
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
        -- dump(file)
        local name = file.name;
        if name then
            btn:setName(name);
        end
        local on,isCache = checkFile(file.on);
        if on then
            btn:loadTextureBackGround(on,isCache);
        end
        local off,isCache = checkFile(file.off);
        if off then
            btn:loadTextureBackGroundSelected(off,isCache);
        end

        local cross,isCache = checkFile(file.cross);
        if cross then
            btn:loadTextureFrontCross(cross,isCache);
        end

        local crossDisabled,isCache = checkFile(file.crossDisabled);
        if crossDisabled then
            btn:loadTextureFrontCrossDisabled(cross,isCache);
        end

        local disabled,isCache = checkFile(file.disabled);
        if disabled then
            btn:loadTextureBackGroundDisabled(disabled,isCache);
        end

    elseif type(file) == "string" then
        local source,isCache = checkFile(file)
        btn:loadTextureBackGround(source,isCache);
        btn:setName(file);
    end
    btn:setCascadeColorEnabled(true)
    btn:setCascadeOpacityEnabled(true)
    return btn;
end


function UICreator:createLabelTTF(str)
    local label = nil;
    

    if type(str) == "table" then
        local params = str;
        local text       = tostring(params.text)
        local font       = params.font or display.DEFAULT_TTF_FONT
        local size       = params.size or display.DEFAULT_TTF_FONT_SIZE
        local color      = params.color or display.COLOR_WHITE
        local textAlign  = params.align or cc.TEXT_ALIGNMENT_CENTER
        -- local textValign = params.valign or ui.TEXT_VALIGN_CENTER
        local x, y       = params.x, params.y
        -- local dimensions = params.dimensions
        label = cc.LabelTTF:create(text,font,size)
        -- static LabelTTF * create(const std::string& string, const std::string& fontName, float fontSize,
        --                      const Size& dimensions = Size::ZERO, TextHAlignment hAlignment = TextHAlignment::CENTER,
        --                      TextVAlignment vAlignment = TextVAlignment::TOP);
    else
        label = cc.LabelTTF:create()
        label:setString(str);
    end
    return label;
end

function UICreator:showMsg(text, fontsize, delay)
    local label = g_UICreator:createLabelTTF({
        text = text,
        size = fontsize or 48,
        color = ccc3(100, 255, 100),
        align = cc.TEXT_ALIGNMENT_CENTER,
    });


    label:setPosition(display.cx, display.cy)
    display:getRunningScene():addChild(label)

    transition.moveBy(label, {y = 20, time = 1.0, delay = delay or 0.5})
    transition.fadeOut(label, {time = 1.0, delay = delay or 0.5, onComplete = function()
        label:removeSelf()
    end})
end



return UICreator;
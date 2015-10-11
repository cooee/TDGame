local XNode = require("app.framework.ui.XNode");
local XSprite = require("app.framework.ui.XSprite");
local XButton = require("app.framework.ui.XButton");
local MMShader = require("app.framework.util.MMShader");
local AutoScrollLabel = require("app.framework.ui.AutoScrollLabel");
local UICreator = class("UICreator");

MMShader.new("outline", "shader/stroke.vert", "shader/stroke.frag")

function UICreator:ctor()
	print("UICreator:ctor")
end


--[[--
创建并返回一个 NODE （矩形）对象。
]]
function UICreator:createNode(x,y,w,h)
	local node = XNode.new();
	if x and y  then
		node:pos(x, y);
	end
    if w and h then
        node:setContentSize(cc.size(w, h));
    end
	return node;
end


function UICreator:creatAutoScrollLabel(x,y,w,h)
    local node = AutoScrollLabel.new(x,y,w,h);
    return node;
end

function UICreator:createButton(path,x,y,w,h)
    local btn = XButton.new(path)
        :onButtonPressed(function(event)
            event.target:setScale(1.2)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
        :align(display.CENTER,x,y);
        -- btn:showRect()
    return btn;
end

function UICreator:createSprite(filename,x,y)
    local sprite = XSprite.new(filename)
        :align(display.CENTER,x,y);
    return sprite;
end

function UICreator:createScale9Sprite(pngRes,insectRect,preferrSize,anchorPoint)
    local sprite=CCSprite:create(pngRes);
    local size=sprite:getContentSize();
    local sprite9=CCScale9Sprite:create(pngRes,CCRectMake(0,0,size.width,size.height),
        CCRectMake(insectRect.origin.x,insectRect.origin.y,
        size.width-insectRect.size.width-insectRect.origin.x,
        size.height-insectRect.size.height-insectRect.origin.y)
        );
        
    sprite:release();
    if preferrSize then
        sprite9:setPreferredSize(preferrSize)
    end

    if anchorPoint then
        sprite9:setAnchorPoint(anchorPoint);
    end
    
    return sprite9;
end

function UICreator:createLabel(text,fontSize,x,y,fontName,createStroke)
    if text == nil then
        return;
    end
    fontSize = fontSize or 20;
    x = x or 0;
    y = y or 0;

    fontName = fontName or DEFAULT_FONT;
    local label = XLabelTTF:create(text,fontName, fontSize);
    label:pos(x, y);
    if createStroke ~= false then
       label:createStrokeEx(ccc3(56, 28, 10),2);
    end

    return label;
end

-- local refOutLineShader = MMShader.new("outline", "shader/stroke.vert", "shader/stroke.frag")
    
--     label:setColor(ccc3(0, 0, 0));
--     -- label:createStrokeEx(ccc3(0, 0, 0),1);
--     label:setPosition(ccp(display.cx,display.bottom + 24));
--     self:addChild(label)



return UICreator;
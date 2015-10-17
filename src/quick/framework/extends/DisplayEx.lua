---描述信息
--@module button
--@author myc
--@license myc

function display.newTilesSprite(filename, rect)
    if not rect then
        rect = CCRect(0, 0, display.width, display.height)
    end
    local sprite = CCSprite:create(filename, rect)
    if not sprite then
        printError("display.newTilesSprite() - create sprite failure, filename %s", tostring(filename))
        return
    end

    local tp = {}
    tp.minFilter = 9729
    tp.magFilter = 9729
    tp.wrapS = 10497
    tp.wrapT = 10497
    sprite:getTexture():setTexParameters(tp.minFilter, tp.magFilter, tp.wrapS, tp.wrapT);

    sprite:align(display.LEFT_BOTTOM, 0, 0)

    return sprite
end


function display.newDrawNode()
	return cc.DrawNode:create()
end

--[[--

Create a circle or a sector or a pie by CCDrawNode

Creation: 2014-03-11

@author zrong(zengrong.net)

@param mixed filename As same a the first parameter for display.newSprite
@param table params As same as the third parameter for display.newFilteredSprite

@return An instance of CCFilteredSprite

]]
function display.newSolidCircle(radius, params)
	local circle = display.newDrawNode()
	circle:drawCircle(radius, params)
	local x,y = 0,0
	if params then
		x = params.x or x
		y = params.y or y
	end
	circle:pos(x,y)
	return circle
end

--[[--

创建并返回一个 CCCircleShape （圆）对象。

@param number radius

@return CCCircleShape

@see CCShapeNode

]]
function display.newCircle(radius, params)
    local draw = cc.DrawNode:create()
    local x,y = 0,0;
    if params then
		x = params.x or x
		y = params.y or y
	end
	draw:drawCircle(cc.p(x ,y), radius, math.pi/2, 30, true,
	cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))
	return draw
end

--[[--

创建并返回一个 CCPolygonShape （多边形）对象。

~~~ lua

local points = {
    {10, 10},  -- point 1
    {50, 50},  -- point 2
    {100, 10}, -- point 3
}
local polygon = display.newPolygon(points)
polygon:setClose(true) -- 将第一个点和最后一个点相连

~~~

@param table points 包含多边形每一个点坐标的表格对象
@param number scale 缩放比例

@return CCPolygonShape CCPolygonShape对象

@see CCShapeNode

]]
function display.newPolygon(points, scale)

    -- local vertices = { cc.p(0,0), cc.p(50,50), cc.p(100,50), cc.p(100,100), cc.p(50,200) }
    -- dump(vertices)
    -- dump(points)
	local draw = cc.DrawNode:create()
    draw:drawPoly(points, #points, false, cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))  
	return draw
end

function display.newTTFLabelWithOutline(params)
    assert(type(params) == "table",
           "[framework.ui] newTTFLabelWithShadow() invalid params")

    local color        = params.color or display.COLOR_WHITE
    local outlineColor = params.outlineColor or display.COLOR_BLACK
    local x, y         = params.x, params.y

    local g = display.newNode()
    params.size  = params.size
    params.color = outlineColor
    params.x, params.y = 0, 0
    g.shadow1 = ui.newTTFLabel(params)
    g.shadow1:realign(1, 0)
    g:addChild(g.shadow1)
    g.shadow2 = ui.newTTFLabel(params)
    g.shadow2:realign(-1, 0)
    g:addChild(g.shadow2)
    g.shadow3 = ui.newTTFLabel(params)
    g.shadow3:realign(0, -1)
    g:addChild(g.shadow3)
    g.shadow4 = ui.newTTFLabel(params)
    g.shadow4:realign(0, 1)
    g:addChild(g.shadow4)

    params.color = color
    g.label = ui.newTTFLabel(params)
    g.label:realign(0, 0)
    g:addChild(g.label)

    function g:setString(text)
        g.shadow1:setString(text)
        g.shadow2:setString(text)
        g.shadow3:setString(text)
        g.shadow4:setString(text)
        g.label:setString(text)
    end

    function g:getContentSize()
        return g.label:getContentSize()
    end

    function g:setColor(...)
        g.label:setColor(...)
    end

    function g:setOutlineColor(...)
        g.shadow1:setColor(...)
        g.shadow2:setColor(...)
        g.shadow3:setColor(...)
        g.shadow4:setColor(...)
    end

    function g:setOpacity(opacity)
        g.label:setOpacity(opacity)
        g.shadow1:setOpacity(opacity)
        g.shadow2:setOpacity(opacity)
        g.shadow3:setOpacity(opacity)
        g.shadow4:setOpacity(opacity)
    end

    if x and y then
        g:setPosition(x, y)
    end

    return g
end

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

    -- draw:drawSolidCircle(cc.p(x,y), radius, math.pi/2, 50, 1.0, 1.0, cc.c4f(1,0,0,0.2))
	draw:drawCircle(cc.p(x ,y), radius, math.pi/2, 3000, false,
	cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))
	return draw
end

function display.newSolidCircle(radius, params)
    local draw = cc.DrawNode:create()
    local x,y = 0,0;
    if params then
        x = params.x or x
        y = params.y or y
    end
    draw:drawSolidCircle(cc.p(x,y), radius, math.pi/2, 50, 1.0, 1.0, cc.c4f(1,0,0,0.2))
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
	local draw = cc.DrawNode:create()
    local color = cc.c4f(1, 1,0, 1);
    -- dump(color)
    draw:drawPoly(points, #points, false, color) 
    -- draw:setLineWidth(2)
	return draw
end

-- function display.newRect(width, height)
--     local draw = cc.DrawNode:create()
--     local color = cc.c4f(1, 1,0, 1);
--     -- dump(color)
--     -- draw:drawPoly(points, #points, false, color)
--     draw:drawRect(cc.p(0,0), cc.p(width,height), cc.c4f(1,0,0,0.3))
--     return draw
-- end

function display.newRect(width, height,params)
    local draw = cc.DrawNode:create()
    local color = cc.c4f(1, 1, 0, 0.5);   
    local isFill = false;
    if params then
        color = params.color or color
        isFill = params.isFill or isFill;
    end

    if isFill == true then
        draw:drawSolidRect(cc.p(0,0), cc.p(width,height), color)
    else
        draw:drawRect(cc.p(0,0), cc.p(width,height), color)
    end
    return draw
end


       
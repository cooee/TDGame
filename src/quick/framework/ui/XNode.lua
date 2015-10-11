local XNode = class("XNode", function()
	return display.newNode()
end)

function XNode:ctor()
end

function XNode:showRect() 
	local size = self:getContentSize();
	local params = {
		color = ccc4f(1, 0, 0, 1);
	};
	local rect = display.newRect(size.width, size.height, params);
	rect:setAnchorPoint(ccp(0, 0));
	self:addChild(rect,1000);
end
return XNode;
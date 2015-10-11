local AutoScrollLabel = class("AutoScrollLabel", function()
	return display.newNode()
end)

function AutoScrollLabel:ctor(x,y,w,h)
	local node = display.newClippingRegionNode(cc.rect(-1,-1,w+1,h+1));
	self:addChild(node,1001);
	self.clipNode = node;
	self:setContentSize(cc.size(w,h));
	self:setPosition(ccp(x,y));
	self.moveSpeed = 70;
end

function AutoScrollLabel:setText(str)
	if self.scrollLabel and str ~= nil then
		self.scrollLabel:setString(str);
	elseif self.scrollLabel == nil  then
		local node = g_UICreator:createLabel("测1试2啊3啊4啊5啊6啊", 26,100,100);
		self:addScrollNode(node, true);
	end
end

function AutoScrollLabel:setColor(color)
	if self.scrollLabel then
		self.scrollLabel:setColor(color);
	end
end

function AutoScrollLabel:addScrollNode(node,autoCenter) 
	if node then
		self.clipNode:addChild(node);
		local size = self:getContentSize();
		if autoCenter then
			node:setPosition(size.width *0.5, size.height * 0.5)
		end		
		if self.scrollLabel then
			self.scrollLabel:removeFromParent();
		end
		self.scrollLabel = node;
		self:changeInterface();
		self:startScroll();
	end
end

function AutoScrollLabel:changeInterface() 
	if self.scrollLabel then
		if self.scrollLabel.setString then
			local func = self.scrollLabel.setString;
			self.scrollLabel.setString = function(object,str)
				func(object,str);
				self:startScroll();
			end
		end
	end
end

function AutoScrollLabel:startScroll(tempSpeed) 
	if self.scrollLabel then
		if self.scrollLabel.scrollAction then
			self.scrollLabel:stopAction(self.scrollLabel.scrollAction);
			self.scrollLabel.scrollAction = nil;
		end
		local node = self.scrollLabel;
		local size = self:getContentSize();
		local nodeX,nodeY = node:getPosition();
		local speed = tempSpeed and tempSpeed or self.moveSpeed;
		local size1 = node:getContentSize();
		if true and size.width < size1.width then
			node:setAnchorPoint(ccp(0,0.5));
			node:setPositionX(0);
			local seq = transition.sequence({
            	CCMoveBy:create(size1.width/speed, ccp(-size1.width,0)),
           	 	CCPlace:create(ccp(size1.width,nodeY)),
            	CCMoveBy:create(size1.width/speed,ccp(-size1.width,0) ),
            });
        	local moveAction = CCRepeatForever:create(seq)
        	node.scrollAction = moveAction;
        	local action = node:runAction(moveAction)
		end
	end
end

function AutoScrollLabel:showRect() 
	local size = self:getContentSize();
	local params = {
		color = ccc4f(1, 0, 0, 1);
	};
	local rect = display.newRect(size.width, size.height, params);
	rect:setAnchorPoint(ccp(0, 0));
	self.clipNode:addChild(rect,1000);
end

return AutoScrollLabel;
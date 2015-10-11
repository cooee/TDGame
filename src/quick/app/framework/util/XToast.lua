local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local XToast = class("XToast");

function XToast:showMsg(msg,pos)
	local topLayer = display.getRunningScene();
	local x,y = 480,320;
	if pos == nil then
		x = display.cx;
		y = display.cy;                 
	else
		x = pos.x;
		y = pos.y;
	end
	local str = "";
	local color = g_ColorManager.WHITE;
	local fontSize = 26;

	if type(msg) == "string" then
		str = msg;
	else
		str = msg.text;
		fontSize = msg.fontSize and msg.fontSize or fontSize;
		color = msg.color and msg.color or g_ColorManager.WHITE;
	end

	local test = g_UICreator:createLabel(str,fontSize,x,y);
	test:setColor(color);
    topLayer:addChild(test,1000);
    test:runAction(transition.sequence({
        CCMoveBy:create(0.6, ccp(0,125)),
        CCScaleTo:create(0.1, 1.2),
        CCScaleTo:create(0.1, 1.0),
        CCCallFunc:create(function()
            test:removeFromParent();
    end)}));
end


function XToast:showError(msg)
	local topLayer = display.getRunningScene();
	local x,y = display.cx,display.cy;               
	local str = msg;
	local color = g_ColorManager.RED;
	local fontSize = 26;
	if self.errorLabel then
		self.errorLabel:stopAllActions();
		self.errorLabel:runAction(transition.sequence({
        CCScaleTo:create(0.1, 1.2),
        CCScaleTo:create(0.1, 1.0),
        CCDelayTime:create(0.5),
        CCFadeOut:create(0.3),
        CCCallFunc:create(function()
        	
            self.errorLabel:removeFromParent();
            self.errorLabel = nil;
    	end)}));
    	return;
	end

	local test = g_UICreator:createLabel(str,fontSize,x,y);
	test:setColor(color);
    topLayer:addChild(test,1000);
    self.errorLabel = test;
    test:runAction(transition.sequence({
        CCScaleTo:create(0.1, 1.2),
        CCScaleTo:create(0.1, 1.0),
        CCDelayTime:create(0.5),
        CCFadeOut:create(0.3),
        CCCallFunc:create(function()
            self.errorLabel:removeFromParent();
            self.errorLabel = nil;
    end)}));
end

function XToast:clear()
	self.index = 1;
	self.msgArr = {};
	self.msgLen = 1;
end

function XToast:showMsgArray(msgArr,pos)
	local len   = #msgArr;
	self.index  = 1;
	self.msgArr = msgArr;
	self.msgLen = len;
	if len > 1 then
		self.timeHandler = scheduler.scheduleGlobal(function()
			self.index = self.index + 1;
			if self.index > self.msgLen then
				scheduler.unscheduleGlobal(self.timeHandler);
				self:clear();
				return;
			end
			self:showMsg(msgArr[self.index],pos);
		end,0.3)
	end
	self:showMsg(msgArr[self.index],pos);
end

return XToast;
local XButton = class("XButton", cc.ui.UIPushButton)
local UIPushButton = cc.ui.UIPushButton;

function XButton:ctor(images,options)
	XButton.super.ctor(self,images, options);
end

function XButton:setFile(file)
	self:setButtonImage(UIPushButton.NORMAL, file, true);
	self.images_[UIPushButton.PRESSED] = image
end

function XButton:getSize()
	if self.sprite_ then
		local state = self.fsm_:getState()
		local index = 1;
		for i,v in ipairs(self.images_) do
			if v==state then
				index = i;
				break;
			end
		end
		local size = self.sprite_[index]:getContentSize()
		return size;
	end
end

function XButton:getContentSize()
	return self:getSize();
end

function XButton:showRect() 
	local size = self:getContentSize();
	local params = {
		color = ccc4f(1, 0, 0, 1);
	};
	local rect = display.newRect(size.width, size.height, params);
	rect:setAnchorPoint(ccp(0.5, 0.5));
	self:addChild(rect,1000);
end
return XButton;
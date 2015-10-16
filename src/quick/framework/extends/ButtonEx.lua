---描述信息
--@module button
--@author myc
--@license myc

local Button = ccui.Button

function Button:setScale9Rect(left,top,right,bottom)
    self:setScale9Enabled(true)
    local size = self:getVirtualRendererSize()
    dump(size)
    local w,h = size.width,size.height;
    self:setCapInsets(cc.rect(left,top,w-left-right,h-top-bottom))
end

local CheckBox = ccui.CheckBox

function CheckBox:setBackgroundSelected(flag)
	if self.mBackgroundSelected ~= flag then
		self.mBackgroundSelected = flag;
		local sprite = self:getRendererBackground();
		sprite:setVisible(flag)
	end
end

function CheckBox:isBackgroundSelected()
	return self.mBackgroundSelected or false;
end
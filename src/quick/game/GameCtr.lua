local GameCtr = class("GameCtr");

function GameCtr:ctor()
	self:addListener()
end

function GameCtr:addListener()
	-- g_eventManager:addEventListener("touchMap", function(sender,event, x, y)
	-- 	self.map_.meta_:setVisible(true);
		
	-- end,self);

	-- g_eventManager:addEventListener("showTowerInfo", function(sender,event, x, y)
	-- 	self.map_.meta_:setVisible(false);

	-- end,self);
end

function GameCtr:removeListener()
	-- body
end

function GameCtr:release()
	self:removeListener();
end

return GameCtr;
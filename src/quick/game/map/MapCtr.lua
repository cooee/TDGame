MapCtr = class("MapCtr");

function MapCtr:ctor()
	self:addListener();
end

function MapCtr:free()
end

function MapCtr:addListener()
	g_eventManager:addEventListener("touchMap", function(sender,event, x, y)
		self.map_.meta_:setVisible(true);

	end,self);

	g_eventManager:addEventListener("showTowerInfo", function(sender,event, x, y)
		self.map_.meta_:setVisible(false);

	end,self);

	g_eventManager:addEventListener(g_Event.ONSETBTNCLICK, function(sender)
		self:upgrade();
	end,self)

	-- g_eventManager:addEventListener("touchMap", function(sender,event, x, y)
	
	-- end,self)		
end

function MapCtr:removeListener()
	g_eventManager:removeListenerWithTarget(self);
end

function MapCtr:setMap(map)
	self.map_ = map;
end

function MapCtr:getMap(map)
	return self.map_;
end

function MapCtr:upgrade()
	if self.map_ then
		local objects = self.map_:getAllObjects();
		for i,object in pairs(objects) do
			_LogI("MYC")
			if object:hasBehavior("UpgradeBehavior") then
				object:upgrade();
			end
		end
	end
end

return MapCtr;


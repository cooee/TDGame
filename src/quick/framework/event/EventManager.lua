local EventManager = class("EventManager");

function EventManager:ctor()
	self._observerList = {}
	self._eventPair = {}
end

function EventManager:addEventListener(event, fun, target)
	if event == nil or fun == nil then
		return false
	end

	if target == nil then
		return false
	end
	
	if self:_findEventListener(event, fun, target) then
		return true
	end

	return self:_addListener(event, fun, target)
end

function EventManager:removeListenerWithTarget( target )
	if target == nil then 
		return false
	end

	local eventArr = self._eventPair[target]
	if eventArr == nil then 
		return true
	end

	for key, value in pairs(eventArr) do  
		if value ~= nil then 
			self:removeListenerWithEvent(target, value)
		end
    end
    self._eventPair[target] = nil

    return true
end

function EventManager:_findEventListener( event, fun, target )
	if event == nil or fun == nil then 
		assert(0, "invalid param")
		return true
	end

	local obj = self._observerList[event]
	if obj == nil or type(obj) ~= "table" then 
		return false
	end

	for key, value in pairs(obj) do  
		if key == target and value == fun then 
			return true
		end
    end

    return false
end

function EventManager:_addListener( event, fun, target )
	if event == nil or fun == nil then 
		assert(0, "invalid param")
		return true
	end

	local obj = self._observerList[event]
	if obj == nil or type(obj) ~= "table" then 
		self._observerList[event] = {}
		obj = self._observerList[event];
	end
	obj[#obj + 1] = {target, fun};


	if target ~= nil then
		local obj = self._eventPair[target]
		if obj == nil or type(obj) ~= "table" then 
			self._eventPair[target] = {}
			obj = self._eventPair[target];
		end
		obj[#obj + 1] = event;

		-- local len = 1
		-- if self._eventPair[target] == nil or
		--    type(self._eventPair[target]) ~= "table" then
		-- 	self._eventPair[target] = {}
		-- else
		-- 	len = table.getn(self._eventPair[target]) + 1
		-- end
		-- table.insert(self._eventPair[target], len, event)
	end
	
	return true
end

function EventManager:_removeListener( target )
	if target == nil then 
		return false
	end

	local eventArr = self._eventPair[target]
	if eventArr == nil then 
		return true
	end

	for key, value in pairs(eventArr) do  
		if value ~= nil then 
			self:removeListenerWithEvent(target, value)
		end
    end
    self._eventPair[target] = nil

    return true
end

function EventManager:removeListenerWithEvent( target, event )
	if target == nil or event == nil then 
		return false
	end

	local eventObserver = self._observerList[event]
	if eventObserver == nil then 
		return true
	end

	for key, value in pairs(eventObserver) do  
		if type(value) == "table" and table.getn(value) >= 2 and value[1] == target then 
			self._observerList[event][key] = nil
		end
    end

    return true
end

function EventManager:dispatchEvent( event,... )
	if event == nil then 
		return nil
	end
	local args = {...}
	self:_doDispatchEvent(event, args)
end

function EventManager:_doDispatchEvent( event, args )
	local eventObserver = self._observerList[event]
	if eventObserver == nil then 
		return false
	end

	for key, value in pairs(eventObserver) do  
		if value ~= nil and type(value) == "table" and table.getn(value) >= 2 then 
			if value[1] ~= nil and value[2] ~= nil then 
				value[2](value[1], unpack(args))
			elseif value[2] ~= nil then
				value[2](unpack(args))
			end
		end
    end
end


return EventManager
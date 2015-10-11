local PlayerInfo = class("PlayerInfo");

function PlayerInfo:ctor()
	self.money = 0;
	self.level = 0;
end

function PlayerInfo:getMoney()
	return self.money;
end

function PlayerInfo:setMoney(money)
	self.money = money;
end

function PlayerInfo:decreaseMoney(money)
	local temp = self.money - money;
	self:setMoney(temp);
	return temp;
end
function PlayerInfo:increaseMoney(money)
	local temp = self.money + money;
	self:setMoney(temp);
	return temp;
end


function PlayerInfo:getLevel()
	return self.level;
end


function PlayerInfo:setLevel(level)
	self.level = level;
end

return PlayerInfo;
local XNode = require("app.framework.ui.XNode");
local GameInfoUI = class("TowerInfoUI",XNode)

function GameInfoUI:ctor()
	GameInfoUI.super.ctor(self);
	self:addListener();

	local bg = g_UICreator:createSprite("Hud/hud_statusbar.png", 480, 33);
	self:addChild(bg);
	local size = bg:getContentSize();
	self:setContentSize(size)
	bg:setVisible(false);
	self:pos(display.left, display.top - size.height);


	local rightPos = 85;
	local settingBtn = g_UICreator:createButton("Hud/playset.png", display.right - rightPos, 36);
	self:addChild(settingBtn);
	self.settingBtn = settingBtn;
	settingBtn:onButtonClicked(function(params)
		g_eventManager:dispatchEvent(g_Event.ONSETBTNCLICK);
	end);

	rightPos = rightPos + settingBtn:getContentSize().width + 20;
	

	local pauseBtn = g_UICreator:createButton("Hud/playpauseitem.png", display.right - rightPos , 36);
	self:addChild(pauseBtn);
	self.pauseBtn = pauseBtn;
	pauseBtn:setTag(1);
	pauseBtn:onButtonClicked(function(params)
		if self.pauseBtn:getTag() == 1 then
			self.pauseBtn:setFile("Hud/playresumeItem.png");
			self.pauseBtn:setTag(2);
		else
			self.pauseBtn:setFile("Hud/playpauseitem.png");
			self.pauseBtn:setTag(1);
		end
	end);

	rightPos = rightPos + pauseBtn:getContentSize().width + 30;

	local playscaleBtn = g_UICreator:createButton("Hud/playscaleOneItem.png", display.right - rightPos , 36);
	self:addChild(playscaleBtn);
	self.playscaleBtn = playscaleBtn;
	playscaleBtn:setTag(1);
	playscaleBtn:onButtonClicked(function(params)
		if self.playscaleBtn:getTag() == 1 then
			self.playscaleBtn:setFile("Hud/playscaleTwoItem.png");
			self.playscaleBtn:setTag(2);
			CCDirector:sharedDirector():getScheduler():setTimeScale(2);
		else
			self.playscaleBtn:setFile("Hud/playscaleOneItem.png");
			self.playscaleBtn:setTag(1);
			CCDirector:sharedDirector():getScheduler():setTimeScale(1);
		end
	end);

	rightPos = rightPos + playscaleBtn:getContentSize().width + 40;

	local playnimbus = g_UICreator:createSprite("Hud/playnimbus.png", display.right - rightPos, 36);
	self:addChild(playnimbus);

	local meneyLabel = g_UICreator:createLabel("5000", 24, 100, 26);
	playnimbus:addChild(meneyLabel);
	meneyLabel:setColor(g_ColorManager.GREEN);
	self.meneyLabel = meneyLabel;


end

function GameInfoUI:refreshMoney(data)
	if data then
		self.meneyLabel:setString(data);
	end
end

function GameInfoUI:addListener()
	g_eventManager:addEventListener("objectDestroyed", function(sender,object)
		local killMoney = object.money_;
		if killMoney then
			killMoney = g_PlayerInfo:increaseMoney(killMoney);
			self:refreshMoney(killMoney);
		end
	end,self);
end

function GameInfoUI:removeListener()
end

return GameInfoUI;
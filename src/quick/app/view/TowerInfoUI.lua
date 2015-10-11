local XNode = require("app.framework.ui.XNode");
local TowerInfoUI = class("TowerInfoUI",XNode)

function TowerInfoUI:ctor()
	print("TowerInfoUI:ctor");
	local width = 400;
	local height = 300;
	local bg = display.newSprite("#EditorPanelBg.png")
    local size = bg:getContentSize()
    self.posx = display.width - width;
    self.posy = display.height;
    bg:align(display.LEFT_TOP, self.posx, self.posy)
    bg:setScaleX(width / size.width)
    bg:setScaleY(height / size.height)
    self:addChild(bg);
    self:setContentSize(width,height);
    self:setVisible(false);
    self:addListener();
    self.bg_ = bg;
    -- self.bg_:setVisible(false);

	local uiSize = self:getContentSize();
    local panel = g_UICreator:createNode(0, 0,uiSize.width, uiSize.height);
    self:addChild(panel)
    self.panel_ = panel
    panel:align(display.LEFT_TOP, self.posx, self.posy)
end

function TowerInfoUI:addListener()
	g_eventManager:addEventListener("showTowerInfo", function(sender,object)
		self:setVisible(true)
		self:showTowerInfo(object);
	end,self)

	g_eventManager:addEventListener("touchMap", function(sender,event, x, y)
		self:setVisible(false)
	end,self)
end

function TowerInfoUI:removeListener()
	g_eventManager:removeListenerWithTarget(self);
end

function TowerInfoUI:showTowerInfo(object)

	if self.panel_ then
	 	self.panel_:removeAllChildren();
	end
	local panel = self.panel_;
	-- panel:showRect();
    local lines = {}
    local text   = object.towerName_;
    local label = g_UICreator:createLabel(text, 30, 200, 270);
    label:setColor(ccc3(0, 255, 0));
    panel:addChild(label)

    if object:hasBehavior("FireBehavior") then
    	local damage = (object.minDamage_ + object.maxDamage_) / 2;
        lines[#lines + 1] = {
            name  = "攻击力 ",
            value = damage,
        }
    end


    if object:hasBehavior("FireBehavior") then
        lines[#lines + 1] = {
            name  = "攻击范围",
            value = object:getFireRange(),
        }
    end
    lines[#lines + 1] = {
            name  = "攻击间隔",
            value = object:getCooldown() .. "秒",
    }

    lines[#lines + 1] = {
            name  = "攻击特效",
            value = "持续掉血",
    }

    lines[#lines + 1] = {
            name  = "升级花费",
            value = "持续掉血",
    }

    local labelX = 0;
    local labelY = 270 - 40;
    local maxWidth = 100;
    for i, pair in ipairs(lines) do
        local prefix = string.rep(" ", 25 - string.len(pair.name)) .. pair.name
        local text   = string.format("%s : %s", tostring(prefix), tostring(pair.value))
        local label = g_UICreator:createLabel(text, 24, labelX, labelY);
        label:setAnchorPoint(ccp(0,0.5));
        panel:addChild(label)

        labelY = labelY - 24 - 5
        local size = label:getContentSize()
        if size.width > maxWidth then
            maxWidth = size.width
        end
    end

end

return TowerInfoUI;
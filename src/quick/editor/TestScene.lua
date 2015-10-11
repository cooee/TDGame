
--[[--

编辑器场景

]]
local AutoScrollLabel = require("app.framework.ui.ScrollView");

local RichLabel = require("app.framework.ui.RichLabel");
local TestScene = class("TestScene", function()
    return display.newScene("TestScene")
end)


function TestScene:ctor()
	display.addSpriteFramesWithFile("tower/Tower_03_Arrow.plist", "tower/Tower_03_Arrow.png");
end
function TestScene:onEnter()

    local winSize = display.size;
    local sp = g_UICreator:createSprite("00081.jpg");
    sp:align(display.LEFT_BOTTOM, 0, 0);
    self:addChild(sp);
    self.bg = sp;



    local sp = g_UICreator:createSprite("akn_d_u_a2a_i04_t_.png");
    sp:align(display.LEFT_BOTTOM, winSize.width-sp:getContentSize().width, 0);
    self:addChild(sp);

    local sp = g_UICreator:createSprite("story_talk_bg.png");
    sp:align(display.LEFT_BOTTOM, 0, 0);
    self:addChild(sp);

    local btnSp = g_UICreator:createSprite(g_load_ui .. "refreshBtn1.png");
    btnSp:align(display.CENTER, 100, 300);
    self:addChild(btnSp);
    btnSp:setScale(0.5);


    local str = "[color=ffFFff number=998 id=1]1.何为富文本？笔者的理解是有着丰富文本的展示方式[/color][type=image]face/wsk1.png[/type][color=F0FF00]效果还ok吧[/color]"
    --[[
        str:字符串 fontSize:字体大小  rowWidth:行宽 rowSpace:行间距
    --]]
    local rowWidth = winSize.width - 400;
    local ricLab = RichLabel.new({str=str, font="FZZhunYuan-M02S", fontSize=32, rowWidth=rowWidth, rowHeight = 160,rowSpace = 0})
    ricLab:setAnchorPoint(ccp(0.5,0.5));
    ricLab:setPosition(ccp(400*0.5 + rowWidth*0.5,100))
    -- self:addChild(ricLab)
    -- ricLab:showRect();
    self.ricLab = ricLab;

    local btn = g_UICreator:createButton(g_load_ui .. "refreshBtn1.png", 100, 500);
    self:addChild(btn);
    btn:onButtonClicked(function()
        local str = "[type=text color=ff00ff id=1]自定义lua富文本[/type][type=br]1[/type][type=text]1.何为富文本？笔者的理解是有着丰富文本的展示方式，比如可以展示[/type][type=text color=1523ff]颜色文本、[/type][type=text]图片[/type][type=image]face/wsk1.png[/type][type=text]、动画、还有超链接的这种就叫富文本。[/type]"
        local tab = {
            {type="text",color = ccc3(255,123,255),text = "阿棍:"},
            {type="br",text = 1},
            {type="space",text = 8},
            {type="text",text = "一切都没有改变，永远都不会改变，这样"},
            {type="text",color =ccc3(255, 255, 0),text = "温暖",event = "changeBG"},
            {type="text",text = "而又幸福的日子能继续的话就够了________"},
            {type="image",text = "face/1.png"},
        }
        self.ricLab:reloadData(tab);
        transition.scaleTo(btnSp, {scale = 1,time = 0.8,easing="BACKOUT"});
        -- ricLab:showRect();
    end)

        -- 添加事件监听函数
    local function listener(button, params)
        dump(params);
        if params.event == "changeBG" then
            self.bg:removeFromParentAndCleanup(true);
            local sp = g_UICreator:createSprite("00080.jpg");
            sp:align(display.LEFT_BOTTOM, 0, 0);
            self:addChild(sp,-1);
            self.bg = sp;
        end
    end
    ricLab:setClickEventListener(listener)

    local emptyNode = cc.Node:create()
    emptyNode:addChild(ricLab)

    local bound = ricLab:getBoundingBox()
    bound = cc.rect(bound.origin.x, bound.origin.y, bound.size.width, bound.size.height)

    cc.ui.UIScrollView.new({viewRect = bound})
        :addScrollNode(emptyNode)
        :setDirection(1)
        -- :onScroll(handler(self, self.scrollListener))
        :addTo(self)
    -- ricLab:setRichChildTouchEnable(false);






    --     self.lv = cc.ui.UIListView.new {
    --     viewRect = cc.rect(40, 160, 200, 200),
    --     direction = cc.ui.UIScrollView.DIRECTION_VERTICAL}
    --     :addTo(self)

    --    local content = display.newNode()
    --     local item = self.lv:newItem()
    --     item:addContent(content)
    --     item:setItemSize(200, 200)
    --     local str = "[type=text number=998 id=1]1.何为富文本？笔者的理解是有着丰富文本的展示方式[/type]"
    -- --[[
    --     str:字符串 fontSize:字体大小  rowWidth:行宽 rowSpace:行间距
    -- --]]
    -- local ricLab = RichLabel.new({str=str, font="FZZhunYuan-M02S", fontSize=32, rowWidth=200, rowHeight = 200,rowSpace = 0})
    -- ricLab:setAnchorPoint(ccp(0.5,0.5));
    -- ricLab:setPosition(ccp(40,80))
    -- ricLab:setTouchEnabled(true);

    -- content:addChild(ricLab)
    --     self.lv:addItem(item);
    --     self.lv:reload()
end

function TestScene:testScollView()
	local ScrollViewCell = require("app.framework.ui.ScrollViewCell")

	local ScrollView = require("app.framework.ui.PageControl")
	local scrollView = ScrollView.new(100, 100, 200, 200,ScrollView.DIRECTION_HORIZONTAL);
	self:addChild(scrollView);
	scrollView:showRect();

	for i = 1,10 do
		local cell = ScrollViewCell.new(200,200);
		local label = g_UICreator:createLabel(i, 25, 100, 100);
		cell:addChild(label);
		scrollView:addCell(cell);
	end

	self.scrollView = scrollView;

end

function TestScene:showMsg(msg,pos)
	local topLayer = display.getRunningScene();
	local test = g_UICreator:createLabel(msg, 26,480,320);
    topLayer:addChild(test,1000);
    test:runAction(transition.sequence({
        CCMoveBy:create(0.6, ccp(0,125)),
        CCScaleTo:create(0.1, 1.2),
        CCScaleTo:create(0.1, 1.0),

        CCCallFunc:create(function()
            test:removeFromParent();
    end)}));
end

function TestScene:showMsgArray(msgArr,pos)
	local len = #msgArr;
	self.index = 1;
	self.msgArr = msgArr;
	self.msgLen = len;
	if len > 1 then
		self.timeHandler = scheduler.scheduleGlobal(function()
			self.index = self.index + 1;
			if self.index > self.msgLen then
				scheduler.unscheduleGlobal(self.timeHandler);
				return;
			end
			self:showMsg(msgArr[self.index]);
		end,0.3)
	end
	self:showMsg(msgArr[self.index]);
end

function TestScene:onExit()

end

return TestScene


local LEVEL_ID = "A0001"

local EditorConstants = import(".EditorConstants")

--[[--

编辑器场景

]]
local EditorScene = class("EditorScene", function()
    return display.newScene("EditorScene")
end)


function EditorScene:ctor()

    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end

    -- 根据设备类型确定工具栏的缩放比例
    self.toolbarLines = 1
    self.editorUIScale = 1
    if (device.platform == "ios" and device.model == "iphone") or device.platform == "android" then
        self.editorUIScale = 1
        self.toolbarLines = 1
    end

    cc.SpriteFrameCache:getInstance():addSpriteFrames("SheetEditor.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("SheetMapBattle.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("tower/tower.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("tower/Tower_02_Shell.plist")
    
    -- local btn = g_UICreator:createImage({file = "DragMapButton.png",scale9Rect={5,5,5,5}});
    -- btn:move(100,100);
    -- btn:addTo(self);
    
    -- btn:setContentSize(64,64);

    -- self.gameCtr = GameCtr.new();

    local bg = display.newTilesSprite("EditorBg.png")
    self:addChild(bg)

    -- mapLayer 包含地图的整个视图
    self.mapLayer_ = display.newNode()
    self.mapLayer_:align(display.LEFT_BOTTOM, 0, 0)
    self:addChild(self.mapLayer_)

    -- -- touchLayer 用于接收触摸事件
    self.touchLayer_ = display.newLayer()
    self:addChild(self.touchLayer_)

    -- uiLayer 用于显示编辑器的 UI（工具栏等）
    self.uiLayer_ = display.newNode()
    self.uiLayer_:setPosition(0, 0)
    self:addChild(self.uiLayer_)



    -- 创建地图对象
    self.map_ = require("app.game.map.Map").new(LEVEL_ID, true) -- 参数：地图ID, 是否是编辑器模式
    self.map_:init()
    self.map_:createView(self.mapLayer_)

    -- self.mapCtr = MapCtr.new();
    -- self.mapCtr:setMap(self.map_);


    -- 创建工具栏
    self.toolbar_ = require("app.editor.Toolbar").new(self.map_)
    self.toolbar_:addTool(require("app.editor.GeneralTool").new(self.toolbar_, self.map_))
    self.toolbar_:addTool(require("app.editor.ObjectTool").new(self.toolbar_, self.map_))
    self.toolbar_:addTool(require("app.editor.PathTool").new(self.toolbar_, self.map_))
    -- self.toolbar_:addTool(require("app.editor.RangeTool").new(self.toolbar_, self.map_))
    -- cc.SpriteFrameCache:getInstance():addSpriteFrames("SheetEditor.plist")
    -- 创建工具栏的视图
    self.toolbarView_ = self.toolbar_:createView(self.uiLayer_, "#ToolbarBg.png", EditorConstants.TOOLBAR_PADDING, self.editorUIScale, self.toolbarLines)
    self.toolbarView_:setPosition(display.left, display.bottom)
    -- dump(self.toolbar_ )
    -- self.toolbar_:setDefaultTouchTool("GeneralTool")
    -- self.toolbar_:selectButton("GeneralTool", 1)

    -- -- 创建对象信息面板
    -- local objectInspectorScale = 1
    -- -- if self.editorUIScale > 1 then
    -- --     objectInspectorScale = 1.5
    -- -- end
    -- self.objectInspector_ = require("editor.ObjectInspector").new(self.map_, objectInspectorScale, self.toolbarLines)
    -- self.objectInspector_:addEventListener("UPDATE_OBJECT", function(event)
    --     self.toolbar_:dispatchEvent(event)
    -- end)
    -- self.objectInspector_:createView(self.uiLayer_)

    -- -- 创建地图名称文字标签
    -- self.mapNameLabel_ = ui.newTTFLabelWithOutline({
    --     text  = string.format("module: %s, image: %s", self.map_.mapModuleName_, self.map_.imageName_),
    --     size  = 16 * self.editorUIScale,
    --     align = ui.TEXT_ALIGN_LEFT,
    --     x     = display.left + 10,
    --     y     = display.bottom + EditorConstants.MAP_TOOLBAR_HEIGHT * self.editorUIScale * self.toolbarLines + 20,
    -- })
    -- self.mapLayer_:addChild(self.mapNameLabel_)

    -- -- 注册工具栏事件
    -- self.toolbar_:addEventListener("SELECT_OBJECT", function(event)
    --     self.objectInspector_:setObject(event.object)
    -- end)
    -- self.toolbar_:addEventListener("UPDATE_OBJECT", function(event)
    --     self.objectInspector_:setObject(event.object)
    -- end)
    -- self.toolbar_:addEventListener("UNSELECT_OBJECT", function(event)
    --     self.objectInspector_:removeObject()
    -- end)
    -- self.toolbar_:addEventListener("PLAY_MAP", function()
    --     self:playMap()
    -- end)

    -- -- 创建运行地图时的工具栏
    -- local toggleDebugButton = ui.newImageMenuItem({
    --     image         = "#ToggleDebugButton.png",
    --     imageSelected = "#ToggleDebugButtonSelected.png",
    --     x             = display.left + 32 * self.editorUIScale,
    --     y             = display.top - 32 * self.editorUIScale,
    --     listener      = function()
    --         self.map_:setDebugViewEnabled(not self.map_:isDebugViewEnabled())
    --     end
    -- })
    -- toggleDebugButton:setScale(self.editorUIScale)

    -- local stopMapButton = ui.newImageMenuItem({
    --     image         = "#StopMapButton.png",
    --     imageSelected = "#StopMapButtonSelected.png",
    --     x             = display.left + 32 * self.editorUIScale,
    --     y             = display.top - 88 * self.editorUIScale,
    --     listener      = function() self:editMap() end
    -- })
    -- stopMapButton:setScale(self.editorUIScale)

    -- self.playToolbar_ = ui.newMenu({toggleDebugButton, stopMapButton})
    -- self.playToolbar_:setVisible(false)
    -- self:addChild(self.playToolbar_)

    -- local node  = g_UICreator:createNode(0, 0);
    -- self.topLayer = node;
    -- self:addChild(node,1);

    -- local TowerInfoUI = require("app.view.TowerInfoUI");
    -- local towerInfoUI = TowerInfoUI.new();
    -- self.uiLayer_:addChild(towerInfoUI,10);

    -- local GameInfoUI = require("app.view.GameInfoUI");
    -- local gameInfoUI = GameInfoUI.new();
    -- self.uiLayer_:addChild(gameInfoUI);


    self:editMap()

    self:addListener();

    self:enableNodeEvents()
  
end

function EditorScene:addListener()

    ---开始游戏
    g_EventManager:addEventListener(Event.PLAY_MAP, function()
        self:playMap();
    end, self)

    --炮塔位置不合法
    g_EventManager:addEventListener(Event.TowerPosNotValid, function()
        g_UICreator:showMsg("炮塔位置不合法",{color = cc.c3b(255, 0, 0),delay=1})
    end, self)
end

function EditorScene:removeListener()

end



-- 开始运行地图
function EditorScene:playMap()
    CCDirector:sharedDirector():setDisplayStats(true)

    -- 隐藏编辑器界面
    self.toolbar_:getView():setVisible(false)

    -- 保存地图当前状态
    self.mapState_ = self.map_:vardump()
    -- self.playToolbar_:setVisible(true)
    -- self.mapNameLabel_:setVisible(false)

    self.map_:setDebugViewEnabled(false)
    self.map_:getBackgroundLayer():setVisible(true)
    self.map_:getBackgroundLayer():setOpacity(255)
    self.map_.meta_:setVisible(false);


    local camera = self.map_:getCamera()
    camera:setMargin(0, 0, 0, 0)
    camera:setOffset(0, 0)

    -- 强制垃圾回收
    collectgarbage()
    collectgarbage()

    -- 开始执行地图
    self.mapRuntime_ = require("app.game.map.MapRuntime").new(self.map_)
    self.mapRuntime_:preparePlay()
    self.mapRuntime_:startPlay()
    self:addChild(self.mapRuntime_)
end

-- 开始编辑地图
function EditorScene:editMap()
    -- CCDirector:sharedDirector():setDisplayStats(false)

    if self.mapRuntime_ then
        self.mapRuntime_:stopPlay()
        self.mapRuntime_:removeSelf()
        self.mapRuntime_ = nil
    end

    self.map_:setDebugViewEnabled(true)
    self.map_.meta_:setVisible(true);
    if self.mapState_ then
        -- 重置地图状态
        self.map_:reset(self.mapState_)
        self.map_:createView(self.mapLayer_)
        self.mapState_ = nil
    end
    self.toolbar_:getToolByName("ObjectTool"):reset();
    self.toolbar_:getView():setVisible(true)
    -- self.playToolbar_:setVisible(false)
    -- self.mapNameLabel_:setVisible(true)

    local camera = self.map_:getCamera()
    camera:setMargin(EditorConstants.MAP_PADDING,
                     EditorConstants.MAP_PADDING,
                     EditorConstants.MAP_PADDING + EditorConstants.MAP_TOOLBAR_HEIGHT * self.editorUIScale * self.toolbarLines + 20,
                     EditorConstants.MAP_PADDING)
    camera:setMargin(0,0,0,0)

    camera:setScale(1)
    camera:setOffset(0, 0)

    -- 强制垃圾回收
    collectgarbage()
    collectgarbage()
end

function EditorScene:tick(dt)
    -- dump(dt)
    if self.mapRuntime_ and self.mapRuntime_.tick then
        for i=1,1 do
            self.mapRuntime_:tick(dt)
        end   
    end
end

function EditorScene:onTouch(event, x, y)
    if self.mapRuntime_ then
        -- 如果正在运行地图，将触摸事件传递到地图
        if self.mapRuntime_:onTouch(event, x, y, map) == true then
            return true
        end

        if event == "began" then
            self.drag = {
                startX  = x,
                startY  = y,
                lastX   = x,
                lastY   = y,
                offsetX = 0,
                offsetY = 0,
            }
            return true
        end

        if event == "moved" then
            self.drag.offsetX = x - self.drag.lastX
            self.drag.offsetY = y - self.drag.lastY
            self.drag.lastX = x
            self.drag.lastY = y
            self.map_:getCamera():moveOffset(self.drag.offsetX, self.drag.offsetY)

        else -- "ended" or CCTOUCHCANCELLED
            self.drag = nil
        end

        return
    end

    -- 如果没有运行地图，则将事件传递到工具栏
    x, y = math.round(x), math.round(y)
    -- if event == "began" then
    --     if self.objectInspector_:getView():isVisible() and self.objectInspector_:checkPointIn(x, y) then
    --         return self.objectInspector_:onTouch(event, x, y)
    --     end
    -- end

    return self.toolbar_:onTouch(event, x, y)
end

function EditorScene:onEnter()
    self.touchLayer_:onTouch(function(event)
        return self:onTouch(event.name, event.x, event.y)
    end)
    -- self.touchLayer_:setTouchEnabled(true)
    -- self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate(handler(self, self.tick))
end

function EditorScene:onExit()
    if self.mapRuntime_ then
        self.mapRuntime_:stopPlay()
    end

    -- self.objectInspector_:removeAllEventListeners()
    -- self.toolbar_:removeAllEventListeners()
    -- self.gameCtr:release();
end

return EditorScene

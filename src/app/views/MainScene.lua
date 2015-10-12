
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

-- MainScene.RESOURCE_FILENAME = "MainScene_layout.csb"

-- local MainSceneEvents={["Button_1"]={["varname"]="",["events"]={{["event"]="touch",["method"]="OnBtnClick"}}}}

-- MainScene.RESOURCE_BINDING=MainSceneEvents

function MainScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))
    self:createResoueceNode2();
end

function MainScene:createResoueceNode2(resourceFilename)
	-- dump(display)

    if self.resourceNode_ then
        self.resourceNode_:removeSelf()
        self.resourceNode_ = nil
    end

    local Result = require("MainScene_layout");

    local root   = Result.create(handler(self, self.callBackProvider));
    -- root.Default:align(display.CENTER,display.cx,display.cy)
    self.resourceNode_ = root.root
    assert(self.resourceNode_, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", resourceFilename))
    self:addChild(self.resourceNode_)

    -- local dragMap = ccui.Button:create()
    -- dragMap:ignoreContentAdaptWithSize(true)
    cc.SpriteFrameCache:getInstance():addSpriteFrames("SheetEditor.plist")
    -- dragMap:loadTextureNormal("DragMapButton.png",1)
    -- -- dragMap:loadTexturePressed("DragMapButtonSelected.png",1)
    -- dragMap:setScale9Enabled(true)
    -- dragMap:setCapInsets(cc.rect(5,5,30,30))
    -- dragMap:setName("dragMap")
    -- dragMap:setTag(28)
    -- dragMap:setCascadeColorEnabled(true)
    -- dragMap:setCascadeOpacityEnabled(true)
    -- dragMap:setPosition(148.0000, 148.0000)
    -- dragMap:setContentSize(64, 64)

    -- dragMap:addTo(self);

    -- local btn = g_UICreator:createButton("DragMapButton.png");
    -- btn:move(100,100);
    -- btn:addTo(self);

    local btn = g_UICreator:createImage({file = "DragMapButton.png",scale9Rect={5,5,5,5}});
    btn:move(100,100);
    btn:addTo(self);
  
    -- local size = btn:getContentSize();
    btn:setContentSize(64,64);
    -- btn:setScale9Rect(5,5,5,5);

    dump(size)


end


function MainScene:callBackProvider(luaFileName, node, callbackName)
    dump("luaFileName",luaFileName)
    dump("node",node);
    dump("callbackName",callbackName)

    local func = nil;
    if self[callbackName] then
        func = self[callbackName];
    end
    return func;
end

function MainScene:onBtnClick2(sender)
    dump("sssssssss");
end



return MainScene

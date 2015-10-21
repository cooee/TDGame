
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

    -- local btn = g_UICreator:createImage({file = "DragMapButton.png",scale9Rect={5,5,5,5}});
    -- btn:move(100,100);
    -- btn:addTo(self);
  
    -- -- local size = btn:getContentSize();
    -- btn:setContentSize(64,64);
    -- -- btn:setScale9Rect(5,5,5,5);

    -- dump(size)
    cc.SpriteFrameCache:getInstance():addSpriteFrames("SheetEditor.plist")
    local btn = g_UICreator:createCheckBox({normal = "#DragMapButton.png",pressed = "#DragMapButtonSelected.png"});
    btn:move(100,100);
    btn:addTo(self);
    -- btn:setContentSize(64,64);
    dump(size)

    local draw = cc.DrawNode:create()
    draw:addTo(self)
    draw:setLocalZOrder(100)
    -- draw:drawCircle(cc.p(100 ,100), 110, math.pi/2, 60, false, cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))

    local o = 80
    local w = 20
    local h = 50
    local star1 = { cc.p(100,100), cc.p(120,100), cc.p(130,100)}
        
    draw:drawPolygon(star1, table.getn(star1), cc.c4f(1,0,0,0.5), 2, cc.c4f(0,0,1,1))


    local vertices3 = { cc.p(60,160), cc.p(70,190), cc.p(100,190), cc.p(90,160) }
    draw:drawSolidPoly( vertices3, 4, cc.c4f(0,0,1,1) )

    -- draw:drawSolidRect(cc.p(10,10), cc.p(20,20), cc.c4f(1,1,0,1))
    -- draw:drawCircle(cc.p(200 ,200), 100, math.pi/2, 300, true, cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))
           --draw two circle
    -- draw:drawCircle(cc.p(VisibleRect:center().x + 140 ,VisibleRect:center().y), 110, math.pi/2, 50, true, 1.0, 2.0, cc.c4f(1.0, 0.0, 0.0, 0.5))
    
    -- draw:drawCircle(cc.p(VisibleRect:center().x - 140 ,VisibleRect:center().y), 50, math.pi/2, 30, false, cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))

    local vertices = { cc.p(0,0), cc.p(50,50), cc.p(100,50), cc.p(100,100), cc.p(50,100) }
    draw:drawPoly(vertices, 5, false, cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))


    local node = display.newRect(100, 100)
    node:addTo(self);


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

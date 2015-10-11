local Resolution = {};


local director = cc.Director:getInstance()
local glview = director:getOpenGLView()

local size = glview:getFrameSize()
local w = size.width
local h = size.height


dump(CC_DESIGN_RESOLUTION)
--设计分辨率
local DESIGN_SCREEN_WIDTH = CC_DESIGN_RESOLUTION.width;
local DESIGN_SCREEN_HEIGHT = CC_DESIGN_RESOLUTION.height;


local scaleW = w/DESIGN_SCREEN_WIDTH; --屏幕宽度和设计分辨率的比值
local scaleH = h/DESIGN_SCREEN_HEIGHT;--屏幕高度和设计分辨率的比值

local scale = 0;--最小缩放比
if scaleW >= scaleH then
	scale = scaleH;
	glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH, DESIGN_SCREEN_HEIGHT, kResolutionFixedWidth)
	CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"
else
	scale = scaleW;
	glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH, DESIGN_SCREEN_HEIGHT, kResolutionFixedHeight)
	CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT"
end

print("display.contentScaleFactor" .. display.contentScaleFactor)

-- local tempScale = 1.1;
-- if scaleW >= scaleH then
-- 	glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH*tempScale, DESIGN_SCREEN_HEIGHT, kResolutionShowAll)
-- else
-- 	glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH, DESIGN_SCREEN_HEIGHT*tempScale, kResolutionShowAll)
-- end

--特殊处理
-- if display.widthInPixels == 2048 and display.heightInPixels == 1536  then
-- 	glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH, DESIGN_SCREEN_HEIGHT, kResolutionShowAll)
-- end

-- if display.widthInPixels == 1024 and display.heightInPixels == 768  then
-- 	glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH, DESIGN_SCREEN_HEIGHT, kResolutionShowAll)
-- end

-- glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH, DESIGN_SCREEN_HEIGHT, kResolutionShowAll)

if not CONFIG_SCREEN_AUTOSCALE then
    CONFIG_SCREEN_AUTOSCALE = string.upper(CONFIG_SCREEN_AUTOSCALE)
end

if CONFIG_SCREEN_AUTOSCALE then
	CONFIG_SCREEN_WIDTH = DESIGN_SCREEN_WIDTH
	CONFIG_SCREEN_HEIGHT = DESIGN_SCREEN_HEIGHT
end

local winSize = sharedDirector:getWinSize()
display.contentScaleFactor = scale
display.size               = {width = winSize.width, height = winSize.height}
display.width              = display.size.width
display.height             = display.size.height
display.cx                 = display.width / 2
display.cy                 = display.height / 2
display.c_left             = -display.width / 2
display.c_right            = display.width / 2
display.c_top              = display.height / 2
display.c_bottom           = -display.height / 2
display.left               = 0
display.right              = display.width
display.top                = display.height
display.bottom             = 0
display.widthInPixels      = display.sizeInPixels.width
display.heightInPixels     = display.sizeInPixels.height

printInfo(string.format("# CONFIG_SCREEN_AUTOSCALE      = %s", CONFIG_SCREEN_AUTOSCALE))
printInfo(string.format("# CONFIG_SCREEN_WIDTH          = %0.2f", CONFIG_SCREEN_WIDTH))
printInfo(string.format("# CONFIG_SCREEN_HEIGHT         = %0.2f", CONFIG_SCREEN_HEIGHT))
printInfo(string.format("# display.widthInPixels        = %0.2f", display.widthInPixels))
printInfo(string.format("# display.heightInPixels       = %0.2f", display.heightInPixels))
printInfo(string.format("# display.contentScaleFactor   = %0.3f", display.contentScaleFactor))
printInfo(string.format("# display.width                = %0.2f", display.width))
printInfo(string.format("# display.height               = %0.2f", display.height))
printInfo(string.format("# display.cx                   = %0.2f", display.cx))
printInfo(string.format("# display.cy                   = %0.2f", display.cy))
printInfo(string.format("# display.left                 = %0.2f", display.left))
printInfo(string.format("# display.right                = %0.2f", display.right))
printInfo(string.format("# display.top                  = %0.2f", display.top))
printInfo(string.format("# display.bottom               = %0.2f", display.bottom))
printInfo(string.format("# display.c_left               = %0.2f", display.c_left))
printInfo(string.format("# display.c_right              = %0.2f", display.c_right))
printInfo(string.format("# display.c_top                = %0.2f", display.c_top))
printInfo(string.format("# display.c_bottom             = %0.2f", display.c_bottom))
printInfo("#")

display.setBackgroundScale =function(bg)
	if scaleW >= scaleH then
		bg:setScaleX(tempScale)
		-- glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH*scale, DESIGN_SCREEN_HEIGHT, kResolutionShowAll)
	else
		bg:setScaleY(tempScale)
		-- glview:setDesignResolutionSize(DESIGN_SCREEN_WIDTH, DESIGN_SCREEN_HEIGHT*scale, kResolutionShowAll)
	end
end
return Resolution;
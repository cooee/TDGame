
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = true

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = true

local DESIGN_SCREEN_WIDTH = 1280;
local DESIGN_SCREEN_HEIGHT = 720;

-- for module display
CC_DESIGN_RESOLUTION = {
    width = DESIGN_SCREEN_WIDTH,
    height = DESIGN_SCREEN_HEIGHT,
    autoscale = "SHOW_ALL",
    callback = function(framesize)
        local scaleX, scaleY = framesize.width / DESIGN_SCREEN_WIDTH, framesize.height / DESIGN_SCREEN_HEIGHT
        local CONFIG_SCREEN_AUTOSCALE;
        if scaleX >= scaleY then
            CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"
        else
            CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT"
        end
        local ratio = framesize.width / framesize.height
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
            return {autoscale = "SHOW_ALL"}
        else
            print("CONFIG_SCREEN_AUTOSCALE " .. CONFIG_SCREEN_AUTOSCALE)
            return {autoscale = CONFIG_SCREEN_AUTOSCALE}
        end
    end
}

-- eval $(ssh-agent -s)
-- ssh-add myc_key


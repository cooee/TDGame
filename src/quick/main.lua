  
-- for CCLuaEngine
function __G__TRACKBACK__(errorMessage)
    CCLuaLog("----------------------------------------")
    CCLuaLog("LUA ERROR: "..tostring(errorMessage).."\n")
    CCLuaLog(debug.traceback("", 2))
    CCLuaLog("----------------------------------------")
end

CCFileUtils:sharedFileUtils():addSearchPath("res/")
CCLuaLoadChunksFromZIP("framework_precompiled.zip")


xpcall(function()
    require("config")

    require("framework.init")

    require("GameGlobal")
    require("Resolution")
    require("app.framework.util.Log");
    -- CCEGLView:sharedOpenGLView():setDesignResolutionSize(960,640,  kResolutionShowAll)

    display.addSpriteFramesWithFile("SheetMapBattle.plist", "SheetMapBattle.png")
    display.addSpriteFramesWithFile("SheetEditor.plist", "SheetEditor.png")

    display.addSpriteFramesWithFile("tower/tower.plist", "tower/tower.png");
    display.addSpriteFramesWithFile("tower/Tower_02_Shell.plist", "tower/Tower_02_Shell.png");

    -- display.replaceScene(require("editor.EditorScene").new())
    display.replaceScene(require("editor.TestScene").new())
    

end, __G__TRACKBACK__)

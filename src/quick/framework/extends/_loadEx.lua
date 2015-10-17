--
-- Author: Your Name
-- Date: 2015-10-12 18:30:38
--
import(".ButtonEx");
import(".ImageViewEx");

function display.newTilesSprite(filename, rect)
    if not rect then
        rect = CCRect(0, 0, display.width, display.height)
    end
    local sprite = CCSprite:create(filename, rect)
    if not sprite then
        printError("display.newTilesSprite() - create sprite failure, filename %s", tostring(filename))
        return
    end

    local tp = {}
    tp.minFilter = 9729
    tp.magFilter = 9729
    tp.wrapS = 10497
    tp.wrapT = 10497
    sprite:getTexture():setTexParameters(tp.minFilter, tp.magFilter, tp.wrapS, tp.wrapT);

    sprite:align(display.LEFT_BOTTOM, 0, 0)

    return sprite
end
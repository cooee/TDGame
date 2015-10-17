
local math2d = import("..math2d")
local ObjectBase = import(".ObjectBase")

local Path = class("Path", ObjectBase)

local unpack =function(pt)
    return pt.x,pt.y;
end

function Path:ctor(id, state, map)
    state.points = checktable(state.points)

    local x, y = 0, 0
    if #state.points > 0 then
        x, y = state.points[1].x,state.points[1].y
    end
    state.x, state.y = x, y

    Path.super.ctor(self, id, state, map)
    self.valid_ = #self.points_ > 0
end

function Path:getPoint(index)
    local pt = self.points_[index]
    return pt.x, pt.y
end

function Path:getPointsCount()
    return #self.points_
end

function Path:appendPoint(x, y)
    self.points_[#self.points_ + 1] = cc.p(x,y)
    self.valid_ = true
end

function Path:insertPointAfterIndex(index, x, y)
    assert(index >= 0 and index <= #self.points_,
           string.format("Path:insertPointAfterIndex() - invalid point index %s", tostring(index)))
    table.insert(self.points_, index + 1, cc.p(x,y))
    self.valid_ = true
end

function Path:movePoint(index, x, y)
    assert(index > 0 and index <= #self.points_,
           string.format("Path:movePoint() - invalid point index %s", tostring(index)))
    -- self.points_[index] = {math.round(x), math.round(y)}
    self.points_[index] = cc.p(math.round(x), math.round(y))
    
end

function Path:removePoint(index)
    assert(index > 0 and index <= #self.points_,
           string.format("Path:removePoint() - invalid point index %s", tostring(index)))
    table.remove(self.points_, index)
    self.valid_ = #self.points_ > 0
end

function Path:checkPointAtPoint(x, y, checkDist)
    local minDist = 999999
    local minDistIndex
    for index, pt in ipairs(self.points_) do
        local dist = math2d.dist(x, y, pt.x, pt.y)
        if dist <= checkDist and dist < minDist then
            minDist = dist
            minDistIndex = index
        end
    end
    return minDistIndex
end

function Path:checkPointAtSegment(x, y, checkDist)
    local minDist = 999999
    local minDistIndex
    for index = 1, #self.points_ - 1 do
        local ax, ay = unpack(self.points_[index])
        local bx, by = unpack(self.points_[index + 1])
        local cx, cy = math2d.pointAtLineToPoint(x, y, ax, ay, bx, by)
        local dist = math2d.dist(x, y, cx, cy)
        if dist <= checkDist and dist < minDist then
            minDist = dist
            minDistIndex = index
        end
    end

    return minDistIndex
end

function Path:vardump()
    local state = Path.super.vardump(self)
    state.points = clone(self.points_)
    state.x, state.y = nil, nil
    return state
end

function Path:dump(label)
    local state = self:vardump()

    label = label or "<var>"
    local lines = {}
    lines[#lines + 1] = string.format("%s = {", label)
    lines[#lines + 1] = "    points = {"

    local function _v(v, len)
        v = tostring(v)
        local l = string.len(v)
        return string.rep(" ", len - l) .. v
    end

    local points = {}
    local len = 0
    for i, p in ipairs(state.points) do
        local pair = string.format("{x = %s, y = %s}", _v(math.round(p.x), 1), _v(math.round(p.y), 1))
        points[#points + 1] = pair
        len = len + string.len(pair)
        if len >= 30 then
            lines[#lines + 1] = "        " .. table.concat(points, ", ") .. ","
            points = {}
            len = 0
        end
    end
    if #points > 0 then
        lines[#lines + 1] = "        " .. table.concat(points, ", ") .. ","
    end
    lines[#lines + 1] = "    }"
    lines[#lines + 1] = "}"
    local ret = table.concat(lines, "\n");

    print(ret);

    return ret
end

return Path

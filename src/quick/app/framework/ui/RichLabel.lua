--[[
2015-3-11 myc
lua 富文本
示例
 local ricLab = RichLabel.new({str=str, font="FZZhunYuan-M02S", fontSize=24, rowWidth=400, rowHeight = 240,rowSpace = 0})

类型说明和补充

[type=text]预约事件预约事件预约事[/type] -- 表示默认颜色文本
[type=text color=ff00ff id=1]预约事件预约事件预约事[/type] -- 表示自定义颜色文本
[type=br]1[/type] --br 表示换行 值（1）表示换行1次
[type=space]4[/type] --表示空格 值（4）表示4个空格

]]
local RichLabel = class("RichLabel", function()
	return display.newNode()
end)

function RichLabel:ctor(param)
	param.str = param.str or "传入的字符为nil"
	param.font = param.font or "FZZhunYuan-M02S"
	param.fontSize = param.fontSize or 14
	param.rowWidth = param.rowWidth or 280
	param.rowHeight = param.rowHeight or 280
	param.rowSpace = param.rowSpace or -4
	self.textParam = param;
	-- self:setAnchorPoint(ccp(0,1));
	self:reloadData(param.str);
	self:setTouchEnabled(true);
	self:setTouchSwallowEnabled(false);
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self,self.onTouch_));


end

function RichLabel:onTouch_(event)
	local name, x, y = event.name, event.x, event.y
	if name == "began" then
		return true
	end
	if name == "moved" then

	elseif name == "ended" then
		--todo
		local checkTouch = self:getCascadeBoundingBox():containsPoint(ccp(x, y));
		if checkTouch == true then
			for k,v in pairs(self.richChild) do
				local checkTouch = v:getCascadeBoundingBox():containsPoint(ccp(x, y));
				if checkTouch and self.listener then
					self.listener(v,v.params);
				end
			end
		end
		-- dump(event);
	end	-- body
end

-- 初始化数据
function RichLabel:initData(str, font, fontSize, rowWidth)
	local tab = self:parseString(str, {font = font, size = fontSize})
	local var = {}
	var.tab = tab         -- 文本字符
	var.width = rowWidth  -- 指定宽度
	return var
end

function RichLabel:reloadData(str)
	local param = self.textParam;
	local textTab = {};
	if type(str) == "string" then
		param.str = str;
		textTab = self:initData(param.str, param.font, param.fontSize, param.rowWidth)
	else
		if type(str) == "table" then
			textTab.tab = str;
			textTab.width = param.rowWidth;
			for i,v in pairs(str) do
				str[i].size = str[i].fontSize and str[i].fontSize or param.fontSize;
			end
		end
	end
	-- dump(textTab);
	self:loadContent(textTab);

end

-- 加载内容
function RichLabel:loadContent(textTab)
	self:removeAllChildren();
	self.richChild = {};
	local param = self.textParam;
	local ptab, copyVar = self:parseTextTable(textTab)
	local ocWidth = 0  -- 当前占宽
	local ocRow   = 1  -- 当前行
	local lastRow = 1  -- 上一行
	local ocHeight = 0 -- 当前高度
	local lastHeight = 0 -- 记录当前行的最大高度 换行时候需要以最大高度换行
	local btn,useWidth,useHeight = 0,0,0
	for k,v in pairs(copyVar) do
		local params = {}
		self:addDataToTable(params, v)
		-- 计算实际渲染宽度
		if params.row == ocRow then --同一行
			ocWidth = ocWidth+useWidth
			lastRow = ocRow;
			lastHeight = math.max(lastHeight,useHeight)
		else
			ocRow = params.row
			useHeight = math.max(lastHeight,useHeight)
			for i=1,ocRow - lastRow do
				ocWidth = 0
				-- 计算实际渲染高度
				ocHeight = ocHeight + useHeight + param.rowSpace --修正高度间距
			end
			lastRow = ocRow;
		-- print("ocHeight " .. ocHeight);
		end
		local maxsize = params.size
		params.width  = params.breadth              -- 控件宽度
		params.height = maxsize                     -- 控件高度
		params.x = ocWidth       					-- 控件x坐标
		params.y = param.rowHeight-(ocHeight)       -- 控件y坐标
		params.font = params.font and params.font or param.font
		params.size = params.size and params.size or param.fontSize
		params.scene = self
		-- dump(params)
		btn,useWidth,useHeight = self:createRichNode(params)
		params.height = useHeight                   -- 控件高度
		btn.params = params;
		table.insert(self.richChild,btn);
	end
	self:setContentSize(CCSize(param.rowWidth, param.rowHeight))
end

-- 获得字符串宽度
function RichLabel:getTextSize(str, tsize)
	local w = 0;
	local h = 0;
	local label = ui.newTTFLabel({text = str, size = tsize})
	w = label:getContentSize().width;
	h = label:getContentSize().height;
	label:release()
	return w, h;
end
-- 获得图片大小
function RichLabel:getImageSize(path)
	local aLen = 0;
	local img = display.newSprite(path);
	local w, h = img:getContentSize().width,img:getContentSize().height;
	img:release();
	return w,h;
end

function RichLabel:addDataToRenderTab(copyVar, tab, text, index, current)
	local tag = #copyVar+1
	copyVar[tag] = {}
	self:addDataToTable(copyVar[tag], tab)
	copyVar[tag].text = text
	copyVar[tag].index = index
	copyVar[tag].row = current
	if tab.image then
		copyVar[tag].breadth = self:getImageSize(tab.image);
	else
		copyVar[tag].breadth = self:getTextSize(text, tab.size)
	end
	if tab.id == nil then
		copyVar[tag].id = os.clock() * 1000;
	end
	copyVar[tag].tag = tag	-- 唯一下标
end

--[[
解析字符串拆分之后的table
主要是计算是否越界 图片判定
换行 空格等
]]
function RichLabel:parseTextTable(var)
	local allTab = {}
	local copyVar = {}
	local useLen = 0
	local str = ""
	local currentRow = 1
	local num = var.width;
	local remainWidth = 0; -- 剩余宽度
	for ktb,tab in ipairs(var.tab) do
		-- 处理图片 需要预判图片的宽度
		if tab.type and tab.type == "image" then
			-- dump(tab);
			local w, h = self:getImageSize(tab.text);
			if w <= remainWidth then -- 图片的宽度没有越界
				useLen = useLen + w;
				allTab[#allTab + 1] = tab.text;
				self:addDataToRenderTab(copyVar, tab, tab.text, 1, currentRow);
			else
				currentRow = currentRow+1
				useLen = 0
				remainWidth = num;
				str = "";
				allTab[#allTab + 1] = tab.text;
				self:addDataToRenderTab(copyVar, tab, tab.text, 1, currentRow);
			end
		else
			-- 处理换行
			if tab.type and tab.type == "br" then
				local brNum = tonumber(tab.text);
				for i=1,brNum do
					print("brNum " .. brNum);
					currentRow  = currentRow+1
					print("currentRow " .. currentRow);
					useLen = 0
					remainWidth = num;
					str = "";
				end

			else
				-- 处理空格
				if tab.type == "space" then
					local spaceNum = tonumber(tab.text);
					local spaceStr = "";
					print("spaceNum " .. spaceNum );
					for i=1,spaceNum do
						spaceStr = spaceStr .. " ";
					end
					tab.text = spaceStr;
				end

				local txtTab, member = self:cutTextToTable(tab.text)
				-- dump(txtTab);
				remainWidth = num - useLen;
				-- print("remainWidth .. " .. remainWidth);
				while true do
					local uLen,tempStr,txtTab = self:calculateWords(txtTab, tab.size, remainWidth);
					print("uLen .. " .. uLen);
					print("tempStr .. " .. tempStr);
					if tempStr == "" and uLen == 0 then
						currentRow = currentRow+1
						useLen = 0
						remainWidth = num;
						str = "";
					else
						useLen = useLen + uLen;
						-- print("useLen " .. useLen);
						-- print("tempStr .. " .. tempStr);
						remainWidth = num - useLen;
						local str = tempStr
						allTab[#allTab + 1] = str;
						self:addDataToRenderTab(copyVar, tab, str, 1, currentRow);
						if useLen > num then
							currentRow = currentRow+1
							useLen = 0
							str = ""
						end
					end
					if #txtTab <= 0  then
						break;
					end
				end

			end
		end
	end
	-- dump(allTab);
	-- dump(copyVar);
	return allTab, copyVar
end

--[[
	计算在一定宽度内能显示的文字
	param:
	strTab  文字列表
	tsize  文字大小
	width  限制宽度

	return 宽度，
]]
function RichLabel:calculateWords(strTab,tsize,Width)

	local str = "";
	for k,v in pairs(strTab) do
		str = str .. v;
	end
	local label = ui.newTTFLabel({text = str, size = tsize})
	local strWidth = label:getContentSize().width;
	label:release();

	-- 判断文字长度是否超过限制宽度
	if strWidth <= Width then
		strTab = {};
		return strWidth,str,{};
	else
		-- print("strWidth " .. strWidth);
		local list = strTab;
		local aLen = 0;
		local tempStr = "";
		local cTags = 0;
		for k,v in ipairs(list) do
			tempStr = tempStr .. v;
			-- print("tempStr .. " .. tempStr);
			local label = ui.newTTFLabel({text = tempStr, size = tsize})
			local labelW = label:getContentSize().width;
			label:release();
			-- print("labelW .. " .. (labelW));
			if labelW <= Width then
				aLen = labelW;
				cTags = k;
			else
				break;
			end
		end
		tempStr = "";
		-- print("cTags .." .. cTags);
		for i=1,cTags do
			tempStr = tempStr .. list[i];
		end
		for i=1,cTags do
			table.remove(strTab, 1);
		end
		return aLen,tempStr,strTab;
	end
	return 0,"",strTab;
end

-- 拆分出单个字符
function RichLabel:cutTextToTable(str)
	local list = {}
	local len = string.len(str)
	local i = 1
	while i <= len do
		local c = string.byte(str, i)
		local shift = 1
		if c > 0 and c <= 127 then
			shift = 1
		elseif (c >= 192 and c <= 223) then
			shift = 2
		elseif (c >= 224 and c <= 239) then
			shift = 3
		elseif (c >= 240 and c <= 247) then
			shift = 4
		end
		local char = string.sub(str, i, i+shift-1)
		i = i + shift
		table.insert(list, char)
	end
	return list, len
end

--根据解析内容创建节点
function RichLabel:createRichNode(params)
	--ui/texture/
	local node = nil;
	if params.type and params.type == "image" then
		node = display.newSprite(params.text);
		node:align(display.LEFT_TOP, params.x, params.y)
		node:addTo(params.scene)
	else
		-- dump(params)
		node = ui.newTTFLabel({
			text  = params.text,
			size  = params.size,
			color = params.color,
			font  = params.font,
		})
			:align(display.LEFT_TOP, params.x, params.y)
			:addTo(params.scene)
	end

	local useWidth = node:getBoundingBox().size.width
	local useHeight = node:getBoundingBox().size.height
	return node,useWidth,useHeight
end

function RichLabel:addDataToTable(tab, src)
	for k,v in pairs(src) do
		tab[k] = v
	end
end

-- string.split()
function RichLabel:strSplit(str, flag)
	local tab = {}
	while true do
		local n = string.find(str, flag)
		if n then
			local first = string.sub(str, 1, n-1)
			str = string.sub(str, n+1, #str)
			table.insert(tab, first)
		else
			table.insert(tab, str)
			break
		end
	end
	return tab
end

-- 解析输入的文本
function RichLabel:parseString(str, param)
	local clumpheadTab = {} -- 标签头
	for w in string.gfind(str, "%b[]") do
		if  string.sub(w,2,2) ~= "/" then-- 去尾
			table.insert(clumpheadTab, w)
		end
	end
	-- 解析标签
	local totalTab = {}
	for k,ns in pairs(clumpheadTab) do
		local tab = {}
		local tStr
		-- print("ns = " .. ns);
		-- 去掉[]
		local subStr = string.sub(ns, 2, #ns-1);
		-- print("subStr " .. subStr);
		string.gsub(ns, subStr, function (w)
			-- print("www " .. w);
			-- 第一个等号前为块标签名
			local n = string.find(w, "=")
			print("n " .. n);
			if n then
				-- 按空格拆分
				local tempTab = self:strSplit(w, " ") -- 支持标签内嵌
				for k,pstr in pairs(tempTab) do
					local keyAndValue = self:strSplit(pstr, "=")

					local pKey = keyAndValue[1]
					if k == 1 then tStr = pKey end -- 标签头

					local pValue = keyAndValue[2]
					-- [^%d] 匹配任意非数字字符
					local p = string.find(pValue, "[^%d.]")
					if not p then pValue = tonumber(pValue) end
					if pKey == "color" then --处理颜色
						tab[pKey] = self:getTextColor(pValue)
					else
						tab[pKey] = pValue
					end
				end
			end
		end)

		if tStr then
			-- 取出文本
			print("tStr " .. tStr);
			-- %b 表示匹配对称字符，注意其只能针对的ansi码单字符。
			local beginFind,endFind = string.find(str, "%b[/"..tStr.."]")
			print(beginFind,endFind)
			local endNumber = beginFind-1

			-- 取值 如[type=text]5[/type] gs=5
			local gs = string.sub(str, #ns+1, endNumber)
			print("gs " .. gs);
			-- 如果遇到[ 直接赋值
			if string.find(gs, "%[") then
				tab["text"] = gs
				print("gs1 " .. gs);
			else
				-- 确保 截取出来的值在 原始字符串内
				string.gsub(str, gs, function (w)
					tab["text"] = w
					print("w1 " .. w);
				end)
			end
			-- 截掉已经解析的字符
			str = string.sub(str, endFind+1, #str)
			if param then
				if not tab.number then  tab.number = k end -- 未指定number则自动生成
				self:addDataToTable(tab, param)
				-- dump(tab);
			end
			table.insert(totalTab, tab)
		end
	end
	-- 普通格式label显示
	if table.getn(clumpheadTab) == 0 then
		local ptab = {}
		ptab.text = str
		if param then
			param.number = 1
			self:addDataToTable(ptab, param)
		end
		table.insert(totalTab, ptab)
	end
	return totalTab
end

--[[解析16进制颜色rgb值]]
function  RichLabel:getTextColor(xStr)
	local function hexToTen(v)
		return tonumber("0x" .. v)
	end
	local b = string.sub(xStr, -2, -1)
	local g = string.sub(xStr, -4, -3)
	local r = string.sub(xStr, -6, -5)

	local red = hexToTen(r) or 0
	local green = hexToTen(g) or 0
	local blue = hexToTen(b) or 0
	return ccc3(red, green, blue)
end


-- 设置监听函数
function  RichLabel:setClickEventListener(eventName)
	self.listener = eventName
end

function RichLabel:showRect()
	local size = self:getContentSize();
	local params = {
		color = ccc4f(1, 0, 0, 1);
	};
	local rect = display.newRect(size.width, size.height, params);
	rect:setAnchorPoint(ccp(0, 0));
	self:addChild(rect,1000);
end

return RichLabel;
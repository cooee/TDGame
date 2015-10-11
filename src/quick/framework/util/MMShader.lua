--[[
  MMShader(创建一个滤镜用用CCNode的setShaderProgram将其设置到CCNode上) 
  @author 啄木鸟
]]

------------------------------------------------类的导入、类声明和继承---------------------------------------

local MMShader = class("MMShader",function ()
    return CCGLProgram()
end)

------------------------------------------------类变量---------------------------------------------

------------------------------------------------局部变量-------------------------------------------

------------------------------------------------类方法---------------------------------------------

--- 构造函数 
--  shaderName:string 要创建的shader的名字
--  vertFileName:string 顶点着色器的文件位置
--  fragFileName:string 片段着色器的文件位置
function MMShader:ctor(shaderName, vertFileName, fragFileName)
    
    if shaderName == nil then
        __Log("MMShader 中的参数 shaderName 不能为空")
        return
    end
    
    if vertFileName == nil then
        __Log("MMShader 中的参数 vertFileName 不能为空")
        return
    end
    
    if fragFileName == nil then
        __Log("MMShader 中的参数 fragFileName 不能为空")
        return
    end
    
    self:_init(shaderName, vertFileName, fragFileName);
    
end;


--- 创建一个shader对象用来实现滤镜效果
--  shaderName:string 要创建的shader的名字
--  vertFileName:string 顶点着色器的文件位置
--  fragFileName:string 片段着色器的文件位置
function MMShader:_init(shaderName, vertFileName, fragFileName)
    
    --local self =CCGLProgram()
    self:initWithVertexShaderFilename(vertFileName, fragFileName)
    
    print("kCCVertexAttrib_Position " .. kCCVertexAttrib_Position);
    -- shader代码内使用的变量与顶点属性的绑定
    self:addAttribute("a_position", kCCVertexAttrib_Position);
    self:addAttribute("a_texCoord", kCCVertexAttrib_TexCoords);
    self:addAttribute("a_color", kCCVertexAttrib_Color);
    
    self:link();
    
    self:updateUniforms();
    
    CCShaderCache:sharedShaderCache():addProgram(self, shaderName);
    
    --return CCShaderCache:sharedShaderCache():programForKey(shaderName)
    
end

--- 设置shader中的int型的变量值(变长参数的数量为1-4)(例如要传递给shader中的当前精灵的宽高)
function MMShader:setAttriI(attributeName, ...)
    
    if attributeName == nil then
        __Log("MMShader 中的参数 attributeName 不能为空")
        return
    end
    
    local arg = {...}
    
    if #arg == 0 then
        __Log("MMShader 中的参数 arg 不能为空")
        return
    end
    
    if self[attributeName] == nil then
            self[attributeName] = self:getUniformLocationForName(attributeName)
    end
    
    if #arg == 1 then
        self:setUniformLocationWith1i(self[attributeName], arg[1])
    elseif #arg == 2 then
        self:setUniformLocationWith2i(self[attributeName], arg[1], arg[2])
    elseif #arg == 3 then
        self:setUniformLocationWith3i(self[attributeName], arg[1], arg[2], arg[3])
    elseif #arg == 4 then
        self:setUniformLocationWith4i(self[attributeName], arg[1], arg[2], arg[3], arg[4])
    end
    
    
end

--- 设置shader中的float型的变量值(变长参数的数量为1-4)
function MMShader:setAttriF(attributeName, ...)
    
    if attributeName == nil then
        __Log("MMShader 中的参数 attributeName 不能为空")
        return
    end
    
    local arg = {...}
    
    if #arg == 0 then
        __Log("MMShader 中的参数 arg 不能为空")
        return
    end
    
    if self[attributeName] == nil then
            self[attributeName] = self:getUniformLocationForName(attributeName)
    end
    
    if #arg == 1 then
        self:setUniformLocationWith1f(self[attributeName], arg[1])
    elseif #arg == 2 then
        self:setUniformLocationWith2f(self[attributeName], arg[1], arg[2])
    elseif #arg == 3 then
        self:setUniformLocationWith3f(self[attributeName], arg[1], arg[2], arg[3])
    elseif #arg == 4 then
        self:setUniformLocationWith4f(self[attributeName], arg[1], arg[2], arg[3], arg[4])
    end
    
end

------------------------------------------------局部方法-------------------------------------------
return MMShader;
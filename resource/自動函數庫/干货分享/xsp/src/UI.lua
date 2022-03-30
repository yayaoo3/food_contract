local w_,h_ = getScreenSize() --w < h
local h = w_
local w = h_

local ui = require "G_ui"
ui:new(w,h)

local p = ui:newPage("【基础设置】")
p:newLine()

p:addLebel(3,1,"【功能选项】") 
p:addImage(9.9,0.5,"titlesep.png","center")


ret,results = showUI("ui.json")
if ret == 0 then lua_exit() end

_G["visibleTap"] =results["visibleTapp"]   --- 触摸可见
_G["visibleTip"] =results["visibleTipp"]   --- 脚本状态提示

print(results)
if tonumber( results["屏幕方向"]  ) == 0 then
init("",2);
else
init("",1);
end



local ret,results = ui:show()
if ret == 0 then lua_exit() end

local MarkSet = require "Setting"
MarkSet:init (results)



return 1
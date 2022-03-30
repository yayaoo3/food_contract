
require "thirdPaty"
require "DeviceCheck"


local w_,h_ = getScreenSize() --w < h
local h = w_
local w = h_

_device = getCurrentDevice()


local supportSize = (_device > 0) --检测是否支持该分辨率
if not supportSize then
  
  dialog("不支持当前分辨率".."宽:"..w..",高:"..h, 8)
  lua_exit()
end

if _device == 5 then
  -- toast("强制")
  setScreenScale(640,1136)
end

init("",1);


--------------------------------------------------------------
createMyHUD()
launchLua()     --- 启动动画
hideMyHUD()
createMyHUD()
---------------------------------------------------------------

a = require "UI"
MarkSet = require "Setting"


while (true) do 
  while (true) do
   ------------sysLog("do sth")
	 show("点击按钮"..math.random(0,1000))
	 tapbtn(0,0,1135,639)  --- 点击按钮
	 s(1000)
	  
		show("滑动测试"..math.random(0,1000))
	 tap(w/2,h/2,100) --- 以屏幕中心为中心，范围100随机点击
	 
	 s(1000)
	 
	 slide(0,100,1135,100)
	 show("随机点击"..math.random(0,1000))
	  s(1000)
		
  end
end
require "DeviceCheck"

visibleTap = 0;

local device = getCurrentDevice();

local w_,h_ = getScreenSize() --w < h
local h = w_
local w = h_
if device ==5 then 
  w = 1136
  h = 639
end


function string.split(input, delimiter)    
  input = tostring(input)  
  delimiter = tostring(delimiter)  
  if (delimiter=='') then return false end  
  local pos,arr = 0, {}  
  -- for each divider found  
  for st,sp in function() return string.find(input, delimiter, pos, true) end do  
    table.insert(arr, string.sub(input, pos, st - 1))  
    pos = sp + 1  
  end  
  table.insert(arr, string.sub(input, pos))  
  return arr  
end 

function in_array(b,list)
  
  if not list then
    return false 
  end 
  if list then
    for i=1,#list,1 do
      if list[i]== b then
        return true
      end
    end
  end
  return false
end 


function createMyHUD()
  myhud = createHUD()     --创建一个HUD
end
function hideMyHUD()
  hideHUD(myhud)     --隐藏HUD
end

function launchLua()
  
  for i=0 ,5,1 do
    if i%2 == 1 then 
      showMyHUD("")
    else
      showMyHUD("···脚本启动中···")
      
    end
    mSleep(300)
  end
  showMyHUD("")
   
   hud =  createHUD()
  for i=0 ,28,1 do
    name = "launch"
    if i< 10 then
      name ="launch_000"..i.."_"..i..".jpg"
    else
      name ="launch_00"..i.."_"..i..".jpg"
    end
    showHUD(hud,"",h/40,"0xfff62f2a",name,0, 0,0,w,h) 
    mSleep(10)
    
    
  end
  mSleep(500)
  hideHUD(hud)
  
end

function showMyHUD(str)
  
  hudw= w/5
  hudh = hudw/10
  if _G["visibleTip"] =="0" then
    showHUD(myhud,str,h/40,"0xff75bd21","0x88000000",0, 40,h-hudh,hudw,hudh)     --变更显示的HUD内容
  end
end



function randomTap(x, y,c)
  local touchid = math.random(0,9)
  ran = c or 0
  x = math.random(0-ran,ran) +x
  y = math.random(0-ran,ran) +y
  
  touchDown(touchid, x, y);
  if _G["visibleTap"] == "0" then 
    id = createHUD()     --创建一个HUD
    if x-12 <1135 and   x-12>0 then
      
      showHUD(id,"",12,"0x00ff0000","finger.png",0,x-2,y,40,48)     --变更显示的HUD内容
    end
    mSleep(math.random(100,200))
    hideHUD(id)     --隐藏HUD
  else
    mSleep(math.random(100,200))
  end
  touchUp(touchid, x, y);
end

--********滑动函数从点(x1, y1)划到到(x2, y2)*******
function slide(x1,y1,x2,y2)
  
  if _G["visibleTap"] == "0" then 
    id = createHUD()     --创建一个HUD
  end
  
  local step, x, y, index = 20, x1 , y1, math.random(1,5)
  touchDown(index, x, y)
  
  local function move(from, to) 
    if from > to then
      do 
        return -1 * step 
      end
    else 
      return step 
    end 
  end
  
  while (math.abs(x-x2) >= step) or (math.abs(y-y2) >= step) do
    if math.abs(x-x2) >= step then x = x + move(x1,x2) end
    if math.abs(y-y2) >= step then y = y + move(y1,y2) end
    if _G["visibleTap"] == "0" then 
      showHUD(id,"",12,"0x00ff0000","finger.png",0,x-2,y,40,48)     
    end
    touchMove(index, x, y)
    mSleep(20)
  end
  
  touchMove(index, x2, y2)
  mSleep(30)
  
  if _G["visibleTap"] == "0" then 
    hideHUD(id) 
  end
  touchUp(index, x2, y2)
end
--********滑动函数结束*******


function tap(x,y,c)
  randomTap(x,y,c)
end

function s(tim)
  mSleep(tim)
end

function show(str)
  showMyHUD(str)
end

--********点击按钮 x,y顶点左边  w,h 按钮高宽*******
function tapbtn(x,y,w,h)
  randomTap(x+ math.random(0,w or 80),y+math.random(0,h or 30))
end
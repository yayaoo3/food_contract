local _airtransport = {}
local Stage = require("stage")
local Common = require("common")
local GI = require("gameinterface")

local Food = 1  Ingredients = 2 Seasoning = 3



function _airtransport.Enter()
	x, y = findMultiColorInRegionFuzzy(0xfde9e0,"7|-1|0xfdebe3,15|-1|0xfdebe3,45|-11|0xfef9f6,70|-24|0xfffffe,73|-27|0xffffff,35|2|0xfce6db,46|2|0xfce6db", 95, 749, 348, 857, 420, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)				
		touchUp(1, x, y)  
		mSleep(6000)
		return true
	end
	return false
end

function _airtransport.Exit()	
	mSleep(1000)
	touchDown(1, 100, 100)
	mSleep(50)				
	touchUp(1, 100, 100)  
	mSleep(2000)
	
end

function _airtransport.DetectItemEnough(x1, y1, x2, y2,i)
	--偵測少量橘色
	x, y = findMultiColorInRegionFuzzy(0xff922f,"1|0|0xff922f", 95, x1, y1, x2, y2, 0, 0)
	if x > -1 then
		sysLog("物品不足")	
		touchDown(1, x, y)
		mSleep(50)				
		touchUp(1, x, y)  
		mSleep(2000)
		
		return false	
	end
	--偵測少量白色
	x, y = findMultiColorInRegionFuzzy(0xf6f4f2,"0|-1|0xf6f4f2", 95, x1, y1, x2, y2, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)				
		touchUp(1, x, y) 
		mSleep(1000)	
		toast("物品"..tostring(i+1).."準備裝箱")
		return true
	end
	--空箱子或已裝箱
	return nil
	
end

function _airtransport.DectetItemOnPacking(x1, y1, x2, y2, i)
	----偵測裝箱螃蟹圖案
	x, y = findMultiColorInRegionFuzzy(0xf3ece7,"1|1|0xf4ebe6,1|3|0xf4e8df,-5|3|0xf3ece6,-2|3|0xf4e8df,-1|3|0xf4e7dc,-22|12|0xf5ece5,-19|13|0xf4e8e1,-21|13|0xf2e4da", 95, 893, 469, 915, 505, 0, 0)
	if x > -1 then
		sysLog("On Packing")
		return true
	else
		sysLog("物品:"..tostring(i).." not packing")
		return false
	end
end

function _airtransport.Replenishment()
	touchDown(1, 850, 280)
	mSleep(50)				
	touchUp(1, 850, 280)
	mSleep(1500)
	
	--判斷是否是調味調不足
	--對話框 淺黃色?
	x, y = findMultiColorInRegionFuzzy(0xf6eede,"0|15|0xf6eede,-10|68|0xf6eede,-5|89|0xf6eede,-10|135|0xf6eede,-7|167|0xf6eede", 95, 305, 237, 655, 444, 0, 0)
	if x > -1 then			
		sysLog("調味料不足")
		return Seasoning
	end
	
	--料理數量不足
	--料理研究	
	x, y = findMultiColorInRegionFuzzy(0xffc256,"0|5|0xffc056,0|10|0xffbd56,0|19|0xffb655", 95, 546, 319, 634, 354, 0, 0)
	if x > -1 then
		sysLog("料理數量不足")
		touchDown(1, x, y)
		mSleep(50)				
		touchUp(1, x, y)		
		mSleep(1500)		
		--偵測小部分紅色 材料不足
		x, y = findMultiColorInRegionFuzzy(0xd85553,"0|1|0xd34241", 95, 329,389,537,409, 0, 0)
		--x, y = findMultiColorInRegionFuzzy(0xd85553,"0|1|0xd34241", 95, 325, 389, 542, 411, 0, 0)
		if x > -1 then
			sysLog("料理所需材料不足:"..tostring(x)..","..tostring(y))
			touchDown(1, x, y-50)
			mSleep(50)				
			touchUp(1, x, y-50)
			mSleep(1000)
			local _ef = Stage.Enter()			
			if _ef then
				sysLog("Common.config.SweepTime:"..tostring(Common.config.SweepTime))
				Stage.runTask(Common.config.SweepTime)
				if Common.config.EnergyEnough == 1 then
					return Ingredients
				else
					return false
				end
			
			end
		else	
			sysLog("製作料理")
			mSleep(1000)
			if Common.config.CookNum == Common.Cook.TenCook then
				--做<10次
				x, y = findMultiColorInRegionFuzzy(0xff9c54,"3|9|0xfe974c,-2|21|0xfd8d3e", 95, 503, 436, 625, 477, 0, 0)
				if x > -1 then
					touchDown(1, x, y)
					mSleep(50)				
					touchUp(1, x, y)
					mSleep(2000)	
				end
			elseif Common.config.CookNum == Common.Cook.OneCook then
				--做1次
				--
				x, y = findMultiColorInRegionFuzzy(0xffc050,"-1|9|0xffbb4a,-1|16|0xffb542", 95, 334, 438, 459, 478, 0, 0)
				if x > -1 then
					touchDown(1, x, y)
					mSleep(50)				
					touchUp(1, x, y)
					mSleep(2000)
				end
			end		
			
			--
			--恭喜獲得 --確認btn
			x, y = findMultiColorInRegionFuzzy(0xffbf56,"-3|15|0xffb450,-3|5|0xffbd56", 95, 437, 454, 523, 492, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)				
				touchUp(1, x, y)
				mSleep(2000)
				_airtransport.Exit()
				return Food
			end
			
		end
		
	else
		--材料不足 去完成
		x, y = findMultiColorInRegionFuzzy(0xffbf56,"-3|15|0xffb450,-3|5|0xffbd56", 95, 546, 244, 633, 282, 0, 0)
		if x > -1 then
			local _ef = Stage.Enter()			
			if _ef then
				Stage.runTask(Common.config.SweepTime)
				if Common.config.EnergyEnough == 1 then
					return Ingredients
				else
					return false
				end
			end
		else
			toast("未解鎖")
			return nil
		end
	end
	return false
end



function _airtransport.ScanItemToPack()
	local xa,xb = 300,370 --位置0
	--503,220,559,236 --位置5
	local i=0
	repeat 
		local x1 = xa + (i%4) * 100
		local x2 = xb + (i%4) * 100
		local y1 ,y2 = 220 ,235
		if i>3 then
			y1 ,y2 = 320 ,335 
		end
		--偵測少量橘色
		local _dief = _airtransport.DetectItemEnough(x1, y1, x2, y2,i)		
		if _dief then
			--物品足夠 或 已裝箱
			----偵測裝箱螃蟹圖案
			local _diopf = _airtransport.DectetItemOnPacking(x1+30, y1-40, x2, y1,i)
			if _diopf == false then
				mSleep(1000)
				--裝箱Btn			
				x, y = findMultiColorInRegionFuzzy(0xffbd56,"-6|14|0xffb351,3|12|0xffb554,7|3|0xffbc55", 95, 782, 483, 864, 518, 0, 0)
				sysLog(tostring(x)..tostring(y))
				if x > -1 then
					touchDown(1, x, y)
					mSleep(50)				
					touchUp(1, x, y)  
					mSleep(1000)
					local _gaf = Stage.GetAward()
					if _gaf == false then
						toast("Packing error")					
						sysLog("Packing error")
					end
				end
			end			
		elseif _dief == false then
			--有體力才做
			if Common.config.EnergyEnough == 1 then
				local _r = _airtransport.Replenishment()
				--重新偵測物品數量
				--材料不足 return true && 重新判斷
				if _r == Food or _r == Ingredients then
					i = i - 1
					_airtransport.Exit()
				elseif _r == Seasoning then					
					_airtransport.BackToHomePage()
					return false
				elseif _r == false then
				--無體力情況，沒有補過東西					
					sysLog("_r:"..tostring(_r))
					_airtransport.BackToHomePage()
					return false
				else
				--關卡未解鎖					
					_airtransport.BackToHomePage()	
					return false
				end
			end
		end
		
		i=i+1
	until i>=8
	return true
end

function _airtransport.DoFly()
	x, y = findMultiColorInRegionFuzzy(0xffc156,"2|10|0xffba54,3|20|0xffb556", 95, 893, 469, 915, 505, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)				
		touchUp(1, x, y)  
		mSleep(10000)
		local _gaf = Stage.GetAward()
		if _gaf == false then
			toast("DoFly error")					
			sysLog("DoFly error")
		end
	end
end

function _airtransport.BackToHomePage()
	local _ohpf = false
	while(_ohpf==false)
	do			
		sysLog("_ohpf:"..tostring(_ohpf))
		_ohpf = GI.OnHomePage()
		if _ohpf == false then
			_airtransport.Exit()
		end
	end
end


function _airtransport.runTask()
	local _ef = _airtransport.Enter()
	if _ef then
		local _sitpf = _airtransport.ScanItemToPack()
		if _sitpf then
			_airtransport.DoFly()
		end
		_airtransport.BackToHomePage()	
	end
	
end


return _airtransport
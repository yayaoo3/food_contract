local _D = {};
local Common = require("common")
local GI = require("gameinterface")
local Stage = require("stage")

function _D.RunTask()
	if Common.config.DeliveryNum > 0 then
		local myCar = _D.GetAwardThenGetCarAvailable()
		local mMap = 1
		--車隊最大數目3
		--根據每張地圖來判斷發車隊伍
		--[非常的Hard Code]
		-- 3 -  myCar = 發了幾隊車 
		if myCar > 0 then
			while( ( 3 - myCar) < Common.config.DeliveryNum )
			do
				sysLog("3-"..tostring(myCar).."="..tostring(3-myCar))
				GI.ChangeMap(mMap)
				_D.SearchToDelivery()
				mMap = mMap + 1
				myCar = _D.GetAwardThenGetCarAvailable()
				if(mMap>=4) then
					toast("無外賣單")
					break
				end
				
			end
		end
	end
end

function _D.GetAwardThenGetCarAvailable()
	
	local _ohpf = GI.OnHomePage()
	local num = 0
	if _ohpf then
		toast("進入訂單")
		touchDown(1, 920, 340)
		mSleep(50)
		touchUp(1, 920, 340) 	
		mSleep(2500)	
		
		repeat						
			x, y = findMultiColorInRegionFuzzy(0xe73e4d,"10|-1|0xe73d4a", 90, 682, 111, 742, 171, 0, 0)
			if x > -1 then
				x, y = findMultiColorInRegionFuzzy(0xfdb154,"0|12|0xffbd56,2|27|0xffb455", 95, 861, 117, 943, 154, 0, 0)
				if x > -1 then					
					touchDown(1, x, y)
					mSleep(50)
					touchUp(1, x, y) 
					mSleep(2500)
					x, y = findMultiColorInRegionFuzzy(0xfdb154,"0|12|0xffbd56,2|27|0xffb455", 95, 437, 455, 521, 487, 0, 0)
					if x > -1 then						
						touchDown(1, x, y)
						mSleep(50)
						touchUp(1, x, y) 
						GI.GetAward()
					end
				end
			end
			mSleep(15)
		until x<=-1
		
		local i=0
		
		
		touchDown(1, 700, 400)
		mSleep(50)
		touchMove(1, 700, 300)
		mSleep(50)
		touchMove(1, 700, 100)
		mSleep(50)
		touchUp(1, 700, 100)  
		mSleep(3000)
		local y_a = 220
		--[[679,450,810,520
		677,340,813,410
		675,220,812,290]]
		repeat
			_y = y_a + i * 120
			--偵測車子
			x, y = findMultiColorInRegionFuzzy(0x372f29,"5|4|0x352d28,13|-22|0xb4392a,19|-25|0xfcd377,58|-31|0xf14431,82|-17|0xef4e3a,96|-1|0xd83631,83|7|0x3e3732,72|4|0x352d27", 95, 675, _y, 820, _y+70, 0, 0)
			if x > -1 then
				num = num + 1
			end
			sysLog("_y:"..tostring(_y).." num:"..tostring(num))
			i=i+1
		until i>=3
		
		--Back page		
		touchDown(1, 80, 100)
		mSleep(50)
		touchUp(1, 80, 100) 
		mSleep(1500)
	end		
	
	toast("空車數量.."..tostring(num))
	return num
	
end

function _D.SearchToDelivery()
	local _ohpf = GI.OnHomePage()
	if _ohpf then
		--搜尋地圖紅色?號
		x, y = findMultiColorInRegionFuzzy(0xd01f1f,"8|1|0xd01f1f,9|4|0xd01f1f,6|6|0xd01f1f,5|9|0xd01f1f,4|16|0xd01f1f", 95, 341, 51, 907, 453, 0, 0)
		if x > -1 then
			toast("發現外賣")
			touchDown(1, x, y+50)
			mSleep(50)
			touchUp(1, x, y+50) 
			mSleep(2500)
			local _rf = false
			repeat
				_rf = _D.Replenishment()
				if Common.config.EnergyEnough == 0 then
					break
				end
			until (_rf)
			sysLog(tostring(_rf))
			--料理無缺則配送
			if _rf then
				x, y = findMultiColorInRegionFuzzy(0xffc156,"-1|10|0xffb137,6|17|0xffb554", 95, 716, 451, 799, 489, 0, 0)
				if x > -1 then
					toast("配送")
					touchDown(1, x, y)
					mSleep(50)
					touchUp(1, x, y) 
					mSleep(2500)
					_D.DetermineTeam(x,y)
				end
			end
			
		else
			sysLog("Deliver nothing")
		end
	end
end

function _D.DetermineTeam(p,q)
	local i = 0
	repeat	
		--first team
		x, y = findMultiColorInRegionFuzzy(0xfbd890,"6|-7|0xefd891,1|7|0xfddb90,9|10|0xfff0af", 95, 22, 146, 54, 184, 0, 0)
		if x > -1 then
			--非第一隊
		else
			toast("第一隊伍,換隊伍")
			touchDown(1, 420, 165)
			mSleep(50)
			touchUp(1,420, 165) 
			mSleep(1500)			
		end	
		
		--toast("嘗試配送")
		touchDown(1, p, q)
		mSleep(50)
		touchUp(1,p, q) 
		mSleep(1500)		
		local _ohpf = GI.OnHomePage()
		if _ohpf then
			toast("配送成功")		
			return 
		end		
		
		x, y = findMultiColorInRegionFuzzy(0xffbf56,"-1|7|0xffb23b,-1|13|0xffb451", 95, 9, 163, 92, 194, 0, 0)
		if x > -1 then
			--體力不足
			--Back page
			toast("體力不足")
			touchDown(1, 80, 100)
			mSleep(50)
			touchUp(1, 80, 100) 
			mSleep(1500)
		else
			toast("隊伍配送中")
		end
		
		toast("換隊伍")
		touchDown(1, 420, 165)
		mSleep(50)
		touchUp(1,420, 165) 
		mSleep(1500)
		local _ohpf = GI.OnHomePage()
		if _ohpf then
			toast("無隊伍可用")		
			return 
		end			
		
		i=i+1
	until i>5
end

function _D.Replenishment()
	
	mSleep(1500)
	x, y = findMultiColorInRegionFuzzy(0xd85553,"0|1|0xd34241", 95, 557,196,797,224, 0, 0)
	--x, y = findMultiColorInRegionFuzzy(0xd85553,"0|1|0xd34241", 95, 325, 389, 542, 411, 0, 0)
	if x > -1 then
		toast("料理不足")
		touchDown(1, x, y-20)
		mSleep(50)
		touchUp(1, x, y-20) 
		mSleep(2500)
		local _gmd = _D.GoMakeDish()	
		if _gmd then
			--Back page
			touchDown(1, 80, 100)
			mSleep(50)
			touchUp(1, 80, 100) 
			mSleep(1500)
		end
	else
		toast("料理充足")
		return true
	end
	return false
end

function _D.GoMakeDish()	
	--料理數量不足
	--料理研究	
	x, y = findMultiColorInRegionFuzzy(0xffc256,"0|5|0xffc056,0|10|0xffbd56,0|19|0xffb655", 95, 546, 319, 634, 354, 0, 0)
	if x > -1 then		
		touchDown(1, x, y)
		mSleep(50)				
		touchUp(1, x, y)		
		mSleep(1500)
		local _dief = _D.DetectIngredientsEnough()
		if _dief then
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
			else
				sysLog("Something error _D.DetectIngredientsEnough()")
			end		
			
			--
			--恭喜獲得 --確認btn
			x, y = findMultiColorInRegionFuzzy(0xffbf56,"-3|15|0xffb450,-3|5|0xffbd56", 95, 437, 454, 523, 492, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)				
				touchUp(1, x, y)
				mSleep(2000)				
				return true
			end		
			
		end
	end	
	return false
end

function _D.DetectIngredientsEnough()
	--偵測小部分紅色 材料不足
	x, y = findMultiColorInRegionFuzzy(0xd85553,"0|1|0xd34241", 95, 329,389,537,409, 0, 0)
	if x > -1 then
		sysLog("料理所需材料不足:"..tostring(x)..","..tostring(y))
		touchDown(1, x, y-50)
		mSleep(50)				
		touchUp(1, x, y-50)
		mSleep(1000)
		local _gsf = _D.GoSweeping()
		if _gsf then
		end
		
		return false
	else
		return true
	end
end

function _D.GoSweeping()
	local _ef = Stage.Enter()			
	if _ef then
		sysLog("Common.config.SweepTime:"..tostring(Common.config.SweepTime))
		Stage.runTask(Common.config.SweepTime)
		if Common.config.EnergyEnough == 1 then
			return true
		else
			return false
		end		
	end
end

return _D
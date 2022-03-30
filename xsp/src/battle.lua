local mbattle = {};
local Login = require("login")
function mbattle.victoryExit()
	
	mSleep(1000)
	-- 離開勝利畫面，點擊空白處
	-- 探險戰鬥 剛好會有退出按鈕
	touchDown(1, 726, 503)
	mSleep(50)
	touchUp(1, 726, 503)
	sysLog("離開勝利")
	
end

function mbattle.checkWordWithVictory()
	mSleep(1000)
	
	x, y = findMultiColorInRegionFuzzy(0x8f2001,"-5|9|0x942400,-10|20|0x9b2b01,-16|28|0x9e3005,-19|30|0xa03508", 95, 728, 80, 825, 193, 0, 0)

	--x, y = findMultiColorInRegionFuzzy(0xc45c04,"41|-2|0xc15601,62|-7|0xca6308,61|-31|0xba530a,60|-56|0xa9430d,61|-89|0xac4308,60|-111|0x8d1c00", 95, 621, 25, 883, 303, 0, 0)
	if x > -1 then
		sysLog("偵測出現Victory")
		return true
		
	end
	return false
end

function mbattle.checkWordWithGiveUp()
	mSleep(1000)	
	x, y = findMultiColorInRegionFuzzy(0xfae7c6,"-6|14|0xfbddb8,-65|-1|0xfbe8c6,-61|8|0xfcd7ac", 95, 309, 372, 394, 408, 0, 0)
	--x, y = findMultiColorInRegionFuzzy(0xc45c04,"41|-2|0xc15601,62|-7|0xca6308,61|-31|0xba530a,60|-56|0xa9430d,61|-89|0xac4308,60|-111|0x8d1c00", 95, 621, 25, 883, 303, 0, 0)
	if x > -1 then
		sysLog("偵測出現放棄")		
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)
		sysLog("點擊放棄，進入失敗畫面")
		return true
		
	end
	return false
end


function mbattle.checkWordWithDefeat()
	mSleep(1000)
	
	x, y = findMultiColorInRegionFuzzy(0xbbc4d5,"-1|24|0xb9c2d4,-4|46|0xc0c8d8,-2|67|0xc4cada,-2|95|0xcacfde,-2|119|0xcacfde,-7|141|0xcbd0df", 95, 557, 52, 743, 319, 0, 0)

	if x > -1 then
		sysLog("偵測出現Defeat")
		toast("巭孬嫑夯尻")
		return true
		
	end
	return false
end


function mbattle.checkButtonWithExit()
	mSleep(3000)
	sysLog("check 退出button")
	--退出按鈕
	x, y = findMultiColorInRegionFuzzy(0xffc156,"0|13|0xffb342,3|17|0xffb551,0|20|0xffb453", 95, 849, 488, 934, 523, 0, 0)
	if x > -1 then
		mSleep(1000)
		-- 離開勝利畫面
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)
		toast("點擊退出")				
				
		return true
	end	
	return false
end


function mbattle.ExploreRun()
	local i=0
	repeat 

		local flag = mbattle.checkWordWithVictory()	
		sysLog("Battle running flag:"..tostring(flag))		
		if flag then
			mSleep(3000)
			sysLog("flag next")
			mbattle.victoryExit()
			return true
			--[[
			local f = mbattle.checkButtonWithExit()
			if f then
				sysLog("Finish Battle")
				--return true
				--break
			else
				sysLog("Vetory偵測錯誤，重新偵測")
			end
			]]
		end
		
		local x, y = findMultiColorInRegionFuzzy(0xfcc809,"-13|2|0xbc2000,-25|-1|0xfab709,-27|16|0xd74100,-14|21|0xdc4500", 95, 3,225,528,527, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 		
			toast("燒毀")
		end
		
	i=i+1
	--防呆
	until i==30
	return false
end

function mbattle.run(mTime)
	
	if Login.DetectAnswerQ() then
		Login.Restart()
		return false
	end

	local i=0
	repeat 
		sysLog("run")
		local flag = mbattle.checkWordWithVictory()	
		sysLog("flag:"..tostring(flag))
		if flag then
			sysLog("flag next")
			mbattle.victoryExit()
			mSleep(2000)			
		end
				
		local f = mbattle.checkButtonWithExit()
		if f then
			sysLog("Finish Battle")
			mSleep(1500)
			local zz = mbattle.checkButtonWithExit()
			if zz == false then
				toast("戰鬥結束")
				return true		
			end
		end
		
		mbattle.checkWordWithGiveUp()
		
		local _df = mbattle.checkWordWithDefeat()		
		if _df then
			sysLog("Defeat next")
			x, y = findMultiColorInRegionFuzzy(0xffc156,"0|11|0xffb344,-3|22|0xffb456", 95, 709, 493, 794, 526, 0, 0)
			if x > -1 then
				-- 離開失敗畫面
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y)
				sysLog("點擊退出，離開失敗")
				return false
			end
		end
		
	i=i+1
	--防呆
	until i == mTime
	--戰鬥時間過長
	return false
end



return mbattle


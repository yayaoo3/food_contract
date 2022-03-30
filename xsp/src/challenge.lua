local Schoolsupply = require("schoolsupply")
local Battle = require("battle")
local Cthulhu = require("CthulhuRuin")
local GI = require("gameinterface")
local PVP = require("pvp")
local mchallenge = {};


function mchallenge.enter()
	local _ohpf = GI.OnHomePage()
	if _ohpf then
		--尋找歷練圖示
		x, y = findMultiColorInRegionFuzzy(0xfff7cb,"4|3|0xffef00,7|-3|0xfff5bf,11|-1|0xffd200,-16|-15|0x42496f,-14|-11|0x404b70", 95, 879, 160, 953, 446, 0, 0)
		if x > -1 then
			mSleep(1000)
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y)
			sysLog("進入歷練")
			mSleep(3000)
		else
			toast("找不到歷練圖示")
		end		
	else
	sysLog("非主畫面，不執行歷練任務")
	end
	
end


function mchallenge.exit()
	
	mSleep(1000)
	-- 離開歷練
	touchDown(1, 50, 39)
	mSleep(50)
	touchUp(1, 50, 39)
	sysLog("離開歷練")
	mSleep(5000)
end

function mchallenge.OnHomePage()
	mSleep(500)
	x, y = findMultiColorInRegionFuzzy(0x816c41,"38|-3|0x8b7a50,124|-8|0xa07635,182|-23|0x99502a,264|-10|0x9c7437,375|-3|0x847149,409|-3|0x816c41,240|34|0xbb3a24,162|42|0xca3b1e", 95, 186, 2, 749, 95, 0, 0)
	if x > -1 then
		toast("進入歷練主畫面")
		return true
	end
	return false
end

function mchallenge.runSchoolTask()
	mchallenge.enter()
	mSleep(1000)
	local _f = mchallenge.OnHomePage()
	if _f then
		Schoolsupply.run()
		mchallenge.exit()
	end
end

function mchallenge.runCthulhuTask()
	mchallenge.enter()
	local _f = mchallenge.OnHomePage()
	if _f then
		Cthulhu.run()		
	end
	--Cthulhu.run()
end

function mchallenge.runPVPTask()
	
	mchallenge.enter()
	local _f = mchallenge.OnHomePage()
	if _f then
		PVP.run()		
	end
	
end

return mchallenge

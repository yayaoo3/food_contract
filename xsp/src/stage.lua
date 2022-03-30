--遊戲function (關卡掃蕩,恭喜獲得物品,)
local _stage = {};
local Common = require("common")

function _stage.GetAward()
	mSleep(4000)
	--偵測[恭]..喜獲得
	x, y = findMultiColorInRegionFuzzy(0xffe5b5,"0|6|0xffe3ac,1|11|0xffe1a3,15|11|0xffe1a3,15|0|0xffe5b5,9|11|0xffe1a3", 95, 380,21,582,168, 0, 0)
	if x > -1 then
		toast("取得物品")
		touchDown(1, 900, 350)
		mSleep(50)
		touchUp(1, 900, 350) 
		mSleep(2000)
		return true
	else
		toast("沒有物品")
		return false
	end
end

function _stage.SweepClick()
	mSleep(2000)
	x, y = findMultiColorInRegionFuzzy(0xffc256,"0|9|0xffbd56,0|24|0xffb456", 95, 72, 458, 156, 494, 0, 0)
	if x > -1 then
		touchDown(1, x, y)	
		mSleep(50)
		touchUp(1, x, y)  
		mSleep(2500)
		return true
	end
	return false	
end

function _stage.Enter()
	mSleep(1500)
	--關卡去完成
	x, y = findMultiColorInRegionFuzzy(0xffbf56,"1|6|0xffba53,4|16|0xffb556", 95, 548, 244, 630, 279, 0, 0)
	if x > -1 then
		touchDown(1, x, y)	
		mSleep(50)
		touchUp(1, x, y)  
		mSleep(3000)
		return true
	end	
	mSleep(1000)
	return false
	
end

function _stage.Exit()
	mSleep(1500)
	touchDown(1, 40, 40)	
	mSleep(50)
	touchUp(1, 40, 40)  
	mSleep(2500)
end

function _stage.Sweep_OneTimes()
	x, y = findMultiColorInRegionFuzzy(0xffc256,"0|9|0xffbd56,0|24|0xffb456", 95, 377, 251, 463, 285, 0, 0)
	if x > -1 then
		touchDown(1, x, y)	
		mSleep(50)
		touchUp(1, x, y)  
		mSleep(2500)		
	end
end

function _stage.Sweep_FiveTimes()
	x, y = findMultiColorInRegionFuzzy(0xffc256,"0|9|0xffbd56,0|24|0xffb456", 95, 501, 251, 582, 285, 0, 0)
	if x > -1 then
		touchDown(1, x, y)	
		mSleep(50)
		touchUp(1, x, y)  
		mSleep(2500)		
	end
end

function _stage.runTask(mtype)
	local _scf = _stage.SweepClick()
	if _scf then
	
		if mtype == Common.Stage.OneTime then
			_stage.Sweep_OneTimes()
		elseif mtype == Common.Stage.FiveTimes then
			_stage.Sweep_FiveTimes()
		end			
		local _gaf = _stage.GetAward()
		if _gaf == false then
			Common.config.EnergyEnough = 0
			sysLog("體力不足")
			toast("體力不足")
		end
		_stage.Exit()			
		_stage.Exit()
	else
		toast("Stage 畫面錯誤")
	end
	
end

return _stage

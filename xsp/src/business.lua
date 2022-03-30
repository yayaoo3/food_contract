local mbusiness = {};
local Icefield = require("icefield")
local Restaurant = require("restaurant")
local Common = require("common")
local Market = require("market")
local GI = require("gameinterface")
local Stage = require("stage")
local Login = require("login")

local FRIEND = 1
function mbusiness.enter()	
	local _ohpf = GI.OnHomePage()
	if _ohpf then
		mSleep(300)
		touchDown(1, 58, 205)
		mSleep(90)
		touchUp(1, 58, 205)  		
		sysLog("進入經營")
		mSleep(500)
	end	
end


function mbusiness.exit()
	mSleep(1000)
	-- 離開經營
	touchDown(1, 912, 212)
	mSleep(50)
	touchUp(1, 912, 212) 
	sysLog("離開經營")
	mSleep(2000)
end

function mbusiness.runIceFieldTask()
	--主畫面進入
	mbusiness.enter();
	Icefield.enter()
	Icefield.removeLiveFoodSpirit()
	Icefield.exit()
	mbusiness.exit()
end

function mbusiness.runIceFieldWithForceRemoveTask()
	--主畫面進入
	mbusiness.enter();
	Icefield.enter()
	Icefield.ForceRemove()
	Icefield.exit()
	mbusiness.exit()
end

function mbusiness.runRecoverFoodSpiritTask()
	--主畫面進入
	mbusiness.enter();
	Icefield.enter()
	Icefield.putFoodSpirit()
	Icefield.exit()
	mbusiness.exit()
end

function mbusiness.runRestaurantTask()
	--主畫面進入
	mbusiness.enter()
	Restaurant.enter()
	Restaurant.run()
	Restaurant.exit()
	mbusiness.exit()
	if Login.DetectAnswerQ() then
		Login.Restart()
	end
end

function mbusiness.runRubiTask()
	--主畫面進入
	mbusiness.enter()
	Restaurant.enter()
	Restaurant.RubiTask(Common.Restaurant.FRIEND)
	Restaurant.exit()
	mbusiness.exit()
end

function mbusiness.runMarketTask()
	--主畫面進入
	mbusiness.enter()
	Market.runTask()
	mbusiness.exit()
end

function mbusiness.AutoSpendEnergy()
	toast("自動耗體Task")
	mSleep(2000)
	touchDown(1, 767, 230)
	mSleep(90)
	touchUp(1, 767, 230) 		
	sysLog("研究")
	mSleep(1500)
	touchDown(1, 700, 200)
	mSleep(90)
	touchUp(1, 700, 200) 	
	mSleep(2000)
	x, y = findMultiColorInRegionFuzzy(0xffc056,"2|10|0xffb240,1|16|0xffb452", 95, 388, 220, 474, 255, 0, 0)
	if x <= -1 then
		sysLog("Error AutoSpendEnergy")
		return
	end	
	sysLog("開發")
	mSleep(1500)
	touchDown(1, 600, 60)
	mSleep(90)
	touchUp(1, 600, 60) 
	sysLog("食材圖鑑")
	mSleep(2500)
	
	--選擇食材
	mbusiness.MoveFoodPage()
	mbusiness.ClickPosXY()
	
	--663,413,729,479
	--583,413,650,479
	--501,415,566,477
	
	
	--獲取
	x, y = findMultiColorInRegionFuzzy(0xffc156,"-6|13|0xffb246", 95, 289, 446, 377, 481, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(86)
		touchUp(1, x, y)  
		mSleep(1500)
		--去完成
		x, y = findMultiColorInRegionFuzzy(0xffc156,"-6|13|0xffb246", 95, 545, 243, 632, 281, 0, 0)
		if x > -1 then
			local _ef = Stage.Enter()			
			if _ef then
				sysLog("Common.config.SweepTime:"..tostring(Common.config.SweepTime))
				Stage.runTask(Common.config.SweepTime)							
				
			end
		else
			toast("先手動刷關好不?")	
		end			
	end		
	
	
	--連續返回
	touchDown(1, 920, 300)
	mSleep(90)
	touchUp(1,  920, 300)
	mSleep(2000)
	touchDown(1, 920, 300)
	mSleep(90)
	touchUp(1,  920, 300)
	mSleep(2000)
	touchDown(1, 920, 300)
	mSleep(90)
	touchUp(1,  920, 300)
	mSleep(2000)
	
	mSleep(500)
end

function mbusiness.ClickPosXY()
	local pos = Common.config.AutoStagePos
	local gap_x = (pos) % 4 - 1;
	local gap_y = math.floor( (pos - 1) / 4 ); --(0~2)
	
	if gap_x == -1 then
		gap_x = 3
	end
	x = 450 + 80 * gap_x
	y = 120 + 80 * gap_y
	
	if tonumber(pos) >= 21 or tonumber(pos) <=0  then
		toast("食材圖鑑位置 錯誤!!")
	else		
		mSleep(1000)
		toast("我要第"..tostring(pos).."食材圖鑑!")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)	
	end
	
	mSleep(2000)
end

function mbusiness.MoveFoodPage()
	local page = Common.config.AutoStagePage
	local showStr = 2
	while(page>1)
	do	
		toast("第"..tostring(showStr).."頁")
		--滑到最底下
		touchDown(1, 455, 450)
		mSleep(50)
		touchMove(1, 455, 400)
		mSleep(50)
		touchMove(1, 455, 350)
		mSleep(50)
		touchMove(1, 455, 300)
		mSleep(50)
		touchMove(1, 455, 250)
		mSleep(50)
		touchMove(1, 455, 200)
		mSleep(50)
		touchMove(1, 455, 150)
		mSleep(50)
		touchMove(1, 455, 100)
		mSleep(50)
		touchUp(1, 455, 100)
		page = page -1
		showStr = showStr +1
		mSleep(2000)
	end
	
end

function mbusiness.runEnergyTask()
	--主畫面進入	
	if Common.config.EnergyEnough == 1 then
		mbusiness.enter()
		mbusiness.AutoSpendEnergy()
		mbusiness.exit()
	end
end

return mbusiness

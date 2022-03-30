local bb = require("badboy")
local json = bb.json
local Login = require("login")
local Common = require("common")
local schoolsupply = require("schoolsupply")
local Business = require("business")
local Challenge = require("challenge")
local Restaurant = require("restaurant")
local Battle = require("battle")
local Icefield = require("icefield")
local Kegare = require("kegare")
local Explore = require("explore")
local Mission = require("mission")
local Stage = require("stage")
local Parse = require("Parse")
local Delivery = require("delivery")
local PVP = require("pvp")
local Market = require("market")
hit_bad_guy = 1 
local FRIEND = 1
local checkTime = 1


local TaskType = {
	[Common.Model.RUBI] = function()    -- for case 1		
		toast("RUBI Task")
		mSleep(1500)
		Business.runRubiTask()
	end,
	[Common.Model.COOK] = function()    -- for case 2		
		toast("COOK Task")	
		mSleep(1500)
		Business.runIceFieldTask()
		Business.runRestaurantTask()		
		if Common.Restaurant.ForceRemoveNumber > 0  then
			Business.runIceFieldWithForceRemoveTask()
			Business.runRestaurantTask()
		end
	end,
	[Common.Model.KEGARE] = function()    -- for case 3	
		toast("KEGARE Task")	
		mSleep(1500)	
		Kegare.runTask()	
	end,
	[Common.Model.SCHOOLSUPPLY] = function()    -- for case 4	
		if Common.Model.SCHOOLSUPPLY > 0 then
			toast("SCHOOLSUPPLY Model")	
			mSleep(1500)
			Challenge.runSchoolTask()	
		else
			toast("補給 次數用完 skip")
		end	
	end,	
	[Common.Model.EXPLORE] = function()    -- for case 5		
		toast("EXPLORE Model")	
		mSleep(1500)
		Explore.run()
	end,
	[Common.Model.ICEFIELD] = function()    -- for case 6		
		toast("ICEFIELD Model")	
		mSleep(1500)
		Business.runRecoverFoodSpiritTask()
	end,
	[Common.Model.Cthulhu] = function()    -- for case 7		
		if Common.Model.Cthulhu > 0 then
			toast("Cthulhu Model")
			mSleep(1500)
			Challenge.runCthulhuTask()
		else
			toast("邪神 次數用完 skip")
		end
	end	,
	[Common.Model.PVP] = function()    -- for case 8		
		if Common.Model.PVP > 0 then
			toast("PVP Model")	
			mSleep(1500)
			Challenge.runPVPTask()
		else
			toast("PVP 次數用完 skip")
		end
	end	
}

function initconfig()

	s = Parse.split(results["SupportFunction"],"@")	
	 
	--Common.config.Mission_Award 
	MA_T = Parse.split(results["cb_MissionAward"],"@")	
	--Common.config.Mission_Job 
	MJ_T = Parse.split(results["cb_MissionJob"],"@")	
	--Common.config.MedicineUsed
	RM_C = Parse.split(results["cb_Medicine"],"@")	
	--購買任務
	PJ_C = Parse.split(results["cb_PurchaseJob"],"@")	
	
	
	Common.config.KEGAREPos = results["et_GERAREPos"]
	Common.config.DishPos = results["et_DishPos"]
	
	--隊伍限制
	Common.config.DeliveryNum = tonumber(results["cb_DeliveryNum"])
	Common.config.ExploreNum = tonumber(results["cb_ExploreNum"])
	
	--腳本重新執行時間
	Common.config.CountTime = results["et_CountTime"]
	Common.config.Script = tonumber(results["cb_Script"])
	
	
	Common.config.DishType = results["cb_DishType"]
	
	
	Common.config.CookNum = tonumber(results["cb_CookNum"])
	Common.config.SweepTime = tonumber(results["cb_SweepTime"])
	
	
	Common.config.Explore_Stage = tonumber(results["cb_Explore_Stage"])
	Common.config.Explore_Material = tonumber(results["cb_Explore_Material"])
	--商店配置
	Common.config.StoreSetting = results["cb_StoreSetting"]
	local str = Parse.split(Common.config.StoreSetting,"@" )	
	for i,v in ipairs(str) do
		if tonumber(v) == Common.Market.MarketLeaf then
			Common.Mission.MarketLeaf = 1
		elseif tonumber(v) == Common.Market.MarketFood then 
			Common.Mission.MarketFood = 1
		end
	end
	
	--邪神遺跡配置
	Common.config.Saber = results["et_Saber"]
	Common.config.Healer = results["et_Healer"]
	Common.config.Meat = results["et_Meat"]
	Common.config.Caster = results["et_Caster"]
	Common.config.AutoStagePage = tonumber(results["et_AutoStagePage"])
	Common.config.AutoStagePos = tonumber(results["et_AutoStagePos"])
	--[[
	sysLog("Caster"..tostring(Common.config.Caster).."")
	sysLog("Healer"..tostring(Common.config.Healer).."")
	sysLog("Saber"..tostring(Common.config.Saber).."")
	sysLog("Meat"..tostring(Common.config.Meat).."")
	]]
	--喝水配置
	RM_C = Parse.split(results["cb_Medicine"],"@")

	for i,v in ipairs(RM_C) do
		
		if v=="0" then
		Common.config.Waiter_2 = 1
		elseif v=="1" then
		Common.config.Waiter_3 = 1
		elseif v=="2" then
		Common.config.Cooker_R = 1
		end
		--[[
		sysLog("Waiter_2"..tostring(Common.config.Waiter_2).."")
		sysLog("Waiter_3"..tostring(Common.config.Waiter_3).."")
		sysLog("Cooker_R"..tostring(Common.config.Cooker_R).."")]]
	end  
	
	checkTime = tonumber(Common.config.CountTime)
	
	

end
	
local content = getUIContent("ui.json")   --获得文件ui.json的内容

lua_value = json.decode(content)   --对获取到的json字符串解码	
--lua_value.width = 500     --将ui窗口宽度赋值为500
--lua_value.height = 400    --将ui窗口宽度赋值为450


ret, results = showUI(json.encode(lua_value))
init("0", 1)


if ret == 1 then
	
	initconfig()

	ISRUN = true
	--ISRUN = false
else
	toast("取消，不執行腳本")
	ISRUN = false
end

--while(false)
while(ISRUN)
do
	--重新啟動，初始化體力Flag
	Common.config.EnergyEnough = 1
	
	init("0", 1); --以当前应用 Home 键在右边初始化
	setScreenScale(540,960)
	math.randomseed(os.time())
	--
	local Runnungflag = appIsRunning("com.efun.twszqy"); 
	sysLog("Runnungflag:"..tostring(Runnungflag))
	if Runnungflag == 0 then 			
		r = runApp("com.efun.twszqy"); 
		mSleep(10 * 1000);  --等待程序响应
		sysLog("r="..tostring(r))
		if r ~= 0 then
			closeApp("com.efun.twszqy");
			sysLog("關閉遊戲")
			toast("启动应用失败");
		else
			sysLog("開啟遊戲")
			update_f = Login.run()
		end
	else
		toast("应用已經啟動，請確保起初在主介面");
		mSleep(1300)
	end
		
	mtime = 0	
	
	--update_f = false
	--update_f = Login.Relogin()
	
	if update_f then
		--還沒想到要做啥，用從開解決這問題好了。
		checkTime = 0
	else
			
		-- Model
		for i,v in ipairs(s) do 			
			f = TaskType[v+1]
			if (f) then
				f()
			else
				toast("RUNTYPE error  , default")		
			end	
			mSleep(1000)
		end  
		
		-- Mission
		---- Award
		for i,v in ipairs(MA_T) do		
			Mission.runAwardTask(tonumber(v+1))
			mSleep(1000)
		end  
		---- Job
		for i,v in ipairs(MJ_T) do
		
			Mission.runJobTask(tonumber(v+1))	
			mSleep(1000)
		end 
		---- Purchase
		local _pmf = false
		for i,v in ipairs(PJ_C) do
			if v == 0 then
				--市場食物選項
				MarketFood = 1
				v = 0
				_pmf = true
			elseif v == 1 then
				--市場葉子選項
				 MarketLeaf = 1
				 v= 0
				 _pmf = true
			end
			sysLog(tonumber(v+1))	
			Mission.runPurchaseTask(tonumber(v+1))	
			mSleep(1000)
		end 
		--特地離開公會界面使用 
		--This is Hard Code
		--Show error message is normal
		Mission.runPurchaseTask(tonumber(-1))
		
		--AutoStage
		if Common.config.AutoStagePage > 0 and Common.config.AutoStagePos > 0 then
			Business.runEnergyTask()		
		end
		
	end
	
	if Common.config.Script == Common.Login.Reload then
		update_f = Login.Relogin()
	elseif Common.config.Script == Common.Login.Restart then
		closeApp("com.efun.twszqy");
		sysLog("關閉遊戲")
	end

	
	toast("剩餘"..tostring(checkTime).."分鐘")
	
	
	
	while(mtime < checkTime )
	do
		mtime = mtime +1	
		
		mSleep(60*1000)
		toast("剩餘"..tostring(checkTime-mtime).."分鐘")
		sysLog("剩餘"..tostring(checkTime-mtime).."分鐘")
	end 
end
	
	
	
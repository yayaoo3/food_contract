local _mission = {};
local Common = require("common")
local Airtransport = require("airtransport")
local Delivery = require("delivery")
local Business = require("business")
local Market = require("market")
local GI = require("gameinterface")

local AwardTask = {
	[Common.Mission.Daily] = function()    -- for case 1		
		toast("Daily Task")
		mSleep(1500)
		local _dtef = _mission.DailyTaskEnter()	
		if _dtef then
			_mission.DailyAward()	
			_mission.DailyTaskExit()
		end		
		mSleep(1500)
	end,
	[Common.Mission.GameAssociation] =function()
		toast("Association Task")
		mSleep(1500)
		local _dtef = _mission.GameAssociationEnter()	
		if _dtef then	
			_mission.GameAssociationAward()
			_mission.GameAssociationExit()		
		end		
		mSleep(1500)	
	end,
	[Common.Mission.Energy_50] =function()
		toast("Energy_50 Task")
		mSleep(1500)
		local _ohpf = GI.OnHomePage()
		if _ohpf then
			_mission.ActivityEnter()
			_mission.EnergyAward()	
			_mission.ActivityExit()
		end
		mSleep(1500)	
	end,	
	[Common.Mission.Email] =function()
		toast("Email Task")		
		local _ohpf = GI.OnHomePage()
		if _ohpf then
			_mission.MailAward()
		end
		mSleep(1500)	
	end,	
	[Common.Mission.GoldEgg] =function()
		toast("Gold Egg Task")		
		local _ohpf = GI.OnHomePage()
		if _ohpf then
			_mission.GoldEggAward()
		end
		mSleep(1500)	
	end
	
}

local JobTask = {
	[Common.Mission.GameAssociationBuild] = function()
		toast("Association Build Task")
		mSleep(1500)
		local _dtef = _mission.GameAssociationEnter()	
		if _dtef then			
			_mission.GameAssociationBuild()
			_mission.GameAssociationExit()
		end		
		mSleep(1500)	
	end,
	[Common.Mission.AirTransport] = function()
		toast("Airtransport Task")
		Airtransport.runTask()
	end,
	[Common.Mission.Delivery] = function()
		toast("Delivery  Task")
		Delivery.RunTask()
	end	
}


local PurchaseTask = {	
	[Common.Mission.Market] = function()
		toast("Market Purchase Task")
		local _ohpf = GI.OnHomePage()
		if _ohpf then
			Business.runMarketTask()
		end
		mSleep(1500)
	end,
	[Common.Mission.Store] = function()
		toast("Store Purchase Task")
		local _ohpf = GI.OnHomePage()
		if _ohpf then
			Market.StoreTask()
		end
		mSleep(1500)
	end,
	[Common.Mission.AssociationStore_ItalyPiece] = function()
		toast("Association ItalyPiece Task")
		local _dtef = _mission.GameAssociationEnter()	
		if _dtef then	
			_mission.AssociationStoreTask(Common.Mission.AssociationStore_ItalyPiece)				
		else
			local _ogapf = _mission.OnGameAssociationPage()
			if _ogapf then
				_mission.AssociationStoreTask(Common.Mission.AssociationStore_ItalyPiece)		
			end
		end
		mSleep(1500)
	end,
	[Common.Mission.AssociationStore_LeafPiece] = function()
		toast("Association LeafPiece Task")
		local _dtef = _mission.GameAssociationEnter()	
		if _dtef then	
			_mission.AssociationStoreTask(Common.Mission.AssociationStore_LeafPiece)				
		else
			local _ogapf = _mission.OnGameAssociationPage()
			if _ogapf then
				_mission.AssociationStoreTask(Common.Mission.AssociationStore_LeafPiece)		
			end
		end
		mSleep(500)
	end,
	[Common.Mission.AssociationStore_Underpants] = function()
		toast("Association Underpants Task")
		local _dtef = _mission.GameAssociationEnter()	
		if _dtef then	
			_mission.AssociationStoreTask(Common.Mission.AssociationStore_Underpants)				
		else
			local _ogapf = _mission.OnGameAssociationPage()
			if _ogapf then
				_mission.AssociationStoreTask(Common.Mission.AssociationStore_Underpants)		
			end
		end
		mSleep(500)
	end,
	
}

function _mission.GoldEggAward()
	touchDown(1, 780, 20)
	mSleep(50)
	touchUp(1, 780, 20)
	mSleep(3000)
	local i=0
	repeat
		x, y = findMultiColorInRegionFuzzy(0xd35545,"8|-5|0xd35545,16|-7|0xd35545,25|-10|0xd35545,54|-21|0xd35545", 95, 206, 231, 304, 289, 0, 0)
		if x > -1 then		
			x, y = findMultiColorInRegionFuzzy(0xffffff,"4|3|0x3d6bd4,4|6|0x5c70de,1|6|0x9cd1ff", 95, 439, 389, 522, 423, 0, 0)
			if x > -1 then
				toast("要錢自己按...")
				break
			else
				x, y = findMultiColorInRegionFuzzy(0xffc056,"0|10|0xffb13c,-1|20|0xffb355", 95, 440, 388, 523, 422, 0, 0)
				if x > -1 then
					toast("冰糖葫蘆，賜予我力量 給我X10")
					--離開
					touchDown(1, x, y)
					mSleep(50)
					touchUp(1, x, y)
					mSleep(3000)
				else
					toast("Error....")
					break
				end
				
			end
		else
			toast("冰糖葫蘆不見了，有問題哦~")
			break
		end
		i = i + 1
	until i==4
	--離開
	touchDown(1, 50, 120)
	mSleep(50)
	touchUp(1, 50, 120)
	mSleep(3000)

end

function _mission.OnHomePage()
	mSleep(3000)
	--判斷主介面的燈籠是否存在
	x, y = findMultiColorInRegionFuzzy(0xcb2010,"5|0|0xe60000,10|0|0x7d0000,5|-5|0xd6331f,5|2|0xe60000", 95, 308, 45, 336, 132, 0, 0)
	if x > -1 then
		return true
	end
	toast("非主介面")
	return false
end

function _mission.DailyTaskEnter()
	mSleep(3000)
	--判斷主介面的燈籠是否存在
	local _ohpf = _mission.OnHomePage()
	if _ohpf  then
		touchDown(1, 800, 70)
		mSleep(50)
		touchUp(1, 800, 70) 
		mSleep(3000)
		toast("每日任務")
		return true
	end	
	return false
end

function _mission.DailyTaskExit()
	mSleep(1000)	
	touchDown(1, 45, 126)
	mSleep(50)
	touchUp(1, 45, 126) 
	mSleep(1500)
end

function _mission.GetAward()
	mSleep(2000)
	--偵測[恭]..喜獲得
	x, y = findMultiColorInRegionFuzzy(0xffe5b5,"0|6|0xffe3ac,1|11|0xffe1a3,15|11|0xffe1a3,15|0|0xffe5b5,9|11|0xffe1a3", 95, 378, 117, 429, 167, 0, 0)
	if x > -1 then
		toast("取得物品")
		touchDown(1, 900, 350)
		mSleep(50)
		touchUp(1, 900, 350) 
		mSleep(3000)
		return true
	else
		toast("沒有物品")
		return false
	end
end

function _mission.MailAward()

	touchDown(1, 675, 75)
	mSleep(50)
	touchUp(1, 675, 75)
	mSleep(2500)
	
	local i = 0 
	repeat
		mSleep(1500)
		x, y = findMultiColorInRegionFuzzy(0xffc256,"-3|16|0xffb34b", 95, 515, 452, 600, 485, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(2500)
			_mission.GetAward()
		else
			break
		end
		i=i+1
	until i==5
	
	_mission.DailyTaskExit()
end

function _mission.DailyAward()
	mSleep(1000)
	local i=0
	repeat
		x, y = findMultiColorInRegionFuzzy(0xffc156,"-2|8|0xffbd56,-2|17|0xffb550", 95, 714, 223, 801, 434, 0, 0)
		if x > -1 then			
			toast("經驗獎勵")
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(2500)
			_mission.GetAward()
		else
			break
		end
		i=i+1
	until i>10
	
	i=0
	local x1,y1,x2,y2 = 300,115,360,160
	
	repeat
		local mcount = 0
		x_a = x1 + i * 100
		x_b = x2 + i * 100
		repeat			
			--活動箱子偵測 會跳動 同一地點 重複偵測數次
			x, y = findMultiColorInRegionFuzzy(0xb27644,"6|-3|0xb77943", 95, x_a, y1, x_b, y2, 0, 0)			
			--x, y = findMultiColorInRegionFuzzy(0xba7332,"-7|1|0xbd7e42,-2|8|0xb1764d,10|3|0xb06d35,-8|15|0xffffff,-5|15|0xffffff,0|30|0xb0743b,7|30|0xac6b30", 95, x_a, y1, x_b, y2, 0, 0)
			if x > -1 then							
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(2500)				
				local _gaf = _mission.GetAward()
				if _gaf then
					toast("活躍獎勵")					
				else
					break
				end
			end
			mSleep(50)
			mcount = mcount+1
		until mcount==2
		i=i+1
	until i>5
	
end


function _mission.GameAssociationEnter()
	mSleep(3000)
	--判斷主介面的燈籠是否存在
	local _ohpf = _mission.OnHomePage()
	if _ohpf  then
		touchDown(1, 375, 485)
		mSleep(50)
		touchUp(1, 375, 485) 
		mSleep(3000)
		toast("公會")
		return true
	end	
	return false
end

function _mission.OnGameAssociationPage()
	mSleep(3000)
	--偵測公會柱子是否存在
	x, y = findMultiColorInRegionFuzzy(0x3e3f43,"1|10|0x454547,1|14|0x404145,1|21|0x3e3f43", 95, 47, 72, 80, 133, 0, 0)
	if x > -1 then
		return true
	end
	toast("非公會介面")
	return false
end


function _mission.AssociationStoreTask(TypeIndex)
	local _gapf = _mission.OnGameAssociationPage()
	if _gapf then
		touchDown(1, 735, 480)
		mSleep(50)
		touchUp(1, 735, 480) 
		mSleep(2000)
		if TypeIndex == Common.Mission.AssociationStore_ItalyPiece then		
			_mission.ItalyPiece() 
			--sysLog("ItalyPiece :"..tostring(TypeIndex).."*")
		elseif (TypeIndex == Common.Mission.AssociationStore_LeafPiece) then
			_mission.LeafPiece()
			--sysLog("LeafPiece :"..tostring(TypeIndex))
		elseif (TypeIndex == Common.Mission.AssociationStore_Underpants) then
			_mission.Underpants()
		end		
		--離開商店，回到公會界面
		touchDown(1, 280, 530)
		mSleep(50)
		touchUp(1, 280, 530) 
		mSleep(750)
		touchDown(1, 280, 530)
		mSleep(50)
		touchUp(1, 280, 530) 
		mSleep(750)
		touchDown(1, 280, 530)
		mSleep(50)
		touchUp(1, 280, 530) 
		mSleep(750)
	end	
end

function _mission.ItalyPiece()
	--偵測紅色
	x, y = findMultiColorInRegionFuzzy(0xa52a38,"-5|0|0xab282b,-14|2|0xce3821,-22|3|0xdd4622", 95, 135, 375, 212, 451, 0, 0)
	if x > -1 then
		toast("買義大利")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y) 
		mSleep(1500)
		
		x, y = findMultiColorInRegionFuzzy(0xffc156,"-1|10|0xffb442,-1|22|0xffb455", 95, 436, 411, 524, 445, 0, 0)
		if x > -1 then
			--增加數量
			touchDown(1, 560, 350)
			mSleep(50)
			touchUp(1, 560, 350) 
			mSleep(1000)
			--確認購買
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(1500)
			_mission.GetAward()
		end		
	end
end

function _mission.Underpants()
	--偵測葉子白綠色
	x, y = findMultiColorInRegionFuzzy(0xa1eef1,"29|-5|0xa0edf2,27|16|0x6fd6d4,17|23|0x75d0d1,12|13|0x6699d4", 95, 449, 384, 513, 443, 0, 0)
	if x > -1 then
		toast("買內褲")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y) 
		mSleep(1500)
		x, y = findMultiColorInRegionFuzzy(0xffc156,"-1|10|0xffb442,-1|22|0xffb455", 95, 436, 411, 524, 445, 0, 0)
		if x > -1 then
			--更改數量
			touchDown(1, 500, 350)
			mSleep(50)
			touchUp(1, 500, 350) 
			mSleep(1000)
			--數字2
			touchDown(1, 370, 280)
			mSleep(50)
			touchUp(1, 370, 280) 
			mSleep(1000)
			--數字0
			touchDown(1, 800, 380)
			mSleep(50)
			touchUp(1, 800, 380) 
			mSleep(1000)
			--橘色確認
			touchDown(1, 800, 500)
			mSleep(50)
			touchUp(1, 800, 500) 
			mSleep(1000)
			--確認購買
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(1500)
			_mission.GetAward()			
		end		
	end
end

function _mission.LeafPiece()
	--偵測葉子白綠色
	x, y = findMultiColorInRegionFuzzy(0xfbffff,"-2|4|0xf5fffe,2|8|0xe6ffff,9|11|0x5cbd76", 95, 289, 198, 364, 224, 0, 0)
	if x > -1 then
		toast("買葉子")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y) 
		mSleep(1500)
		x, y = findMultiColorInRegionFuzzy(0xffc156,"-1|10|0xffb442,-1|22|0xffb455", 95, 436, 411, 524, 445, 0, 0)
		if x > -1 then
			--更改數量
			touchDown(1, 500, 350)
			mSleep(50)
			touchUp(1, 500, 350) 
			mSleep(1000)
			--數字2
			touchDown(1, 370, 280)
			mSleep(50)
			touchUp(1, 370, 280) 
			mSleep(1000)
			--數字0
			touchDown(1, 800, 380)
			mSleep(50)
			touchUp(1, 800, 380) 
			mSleep(1000)
			--橘色確認
			touchDown(1, 800, 500)
			mSleep(50)
			touchUp(1, 800, 500) 
			mSleep(1000)
			--確認購買
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(1500)
			_mission.GetAward()			
		end		
	end
end
function _mission.GameAssociationExit()
	mSleep(2000)	
	local _gapf = _mission.OnGameAssociationPage()
	if _gapf then
		touchDown(1, 40, 40)
		mSleep(50)
		touchUp(1, 40, 40) 
		mSleep(3000)
	end	
end

function _mission.GameAssociationBuild()	
	mSleep(2000)	
	local _gapf = _mission.OnGameAssociationPage()
	if _gapf then
		touchDown(1, 550, 475)
		mSleep(50)
		touchUp(1, 550, 475) 
		mSleep(3000)
		--低階建造
		local count = 0
		repeat 
			
			--10次
			x, y = findMultiColorInRegionFuzzy(0xffc04f,"4|0|0xffc04f,13|-1|0xffc151", 95, 224, 410, 307, 449, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(3000)
				_mission.GetAward()
			end
			--1次
			x, y = findMultiColorInRegionFuzzy(0xffc04f,"4|0|0xffc04f,13|-1|0xffc151", 95, 82, 414, 164, 447, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(3000)
				_mission.GetAward()
			end
			count = count + 1
		until count > 10
	end
	touchDown(1, 280, 520)
	mSleep(50)
	touchUp(1, 280, 520) 
	mSleep(1500)
end

function _mission.GameAssociationAward()
	mSleep(1000)	
	local _gapf = _mission.OnGameAssociationPage()
	if _gapf then
		touchDown(1, 645, 480)
		mSleep(50)
		touchUp(1, 645, 480) 
		mSleep(3000)
		local count = 0
		repeat 
			x, y = findMultiColorInRegionFuzzy(0xffc056,"11|-3|0xffc151,29|0|0xffc056", 95, 633, 169, 717, 445, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(3000)
				_mission.GetAward()
			end		
			count = count + 1
		until count > 4
	end
	touchDown(1, 280, 520)
	mSleep(50)
	touchUp(1, 280, 520) 
	mSleep(1500)
end


function _mission.ActivityEnter()
	mSleep(3000)
	--判斷主介面的燈籠是否存在
	local _ohpf = _mission.OnHomePage()
	if _ohpf  then
		touchDown(1, 850, 70)
		mSleep(50)
		touchUp(1, 850, 70) 
		mSleep(3000)
		toast("活動")
		return true
	end	
	return false
end



function _mission.ActivityExit()
	mSleep(2000)	
	x, y = findMultiColorInRegionFuzzy(0xed9d43,"1|11|0xeba14a,2|64|0xc5a587,4|81|0xcfaf92", 95, 38, 82, 172, 196, 0, 0)
	if x > -1 then
		touchDown(1, 40, 40)
		mSleep(50)
		touchUp(1, 40, 40) 
		mSleep(3000)
	end	
end

function _mission.EnergyAward()	
	x, y = findMultiColorInRegionFuzzy(0xed9d43,"1|11|0xeba14a,2|64|0xc5a587,4|81|0xcfaf92", 95, 38, 82, 172, 196, 0, 0)
	if x > -1 then
		x, y = findMultiColorInRegionFuzzy(0xfeb656,"0|9|0xfeb95d,-1|17|0xffb756", 95, 488, 356, 896, 395, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(1000)
			_mission.GetAward()
		end
	end	
	
	
end



function _mission.runAwardTask(mType)
	
	local f = AwardTask[mType]
	if (f) then
		f()
	else
		toast("AwardTask error")		
	end	
	mSleep(1000)	
	
end

function _mission.runJobTask(mType)
	
	local f = JobTask[mType]
	if (f) then
		f()
	else
		toast("JobTask error")		
	end	
	mSleep(1000)		
end

function _mission.runPurchaseTask(mType)
	
	local f = PurchaseTask[mType]
	if (f) then
		f()
	else
		--離開公會
		local _ogapf = _mission.OnGameAssociationPage()
		if _ogapf then		
			_mission.GameAssociationExit()
		else
			toast("PurchaseTask error")
		end
	end	
	mSleep(500)
		
	
end

return _mission

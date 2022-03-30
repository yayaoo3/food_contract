local _M = {};
local Common = require("common")
local Parse = require("Parse")
local GI = require("gameinterface")
local Battle = require("battle")
math.randomseed(os.time())
local battle_flag = false

function _M.Enter()
	mSleep(1000)
	touchDown(1, 650, 300)
	mSleep(50)
	touchUp(1, 650, 300)
	sysLog("進入邪神遺跡")
end

function _M.Exit()
	
	mSleep(3500)
	-- 離開歷練
	touchDown(1, 50, 39)
	mSleep(50)
	touchUp(1, 50, 39)
	sysLog("離開邪神遺跡")
	mSleep(5000)
	
end

function _M.OnRuinPage()
	--在邪神遺跡裡挑戰畫面	
	--判斷燈旁邊的裝飾物
	--燈會隨挑戰熄滅，不可當作判斷物
	x, y = findMultiColorInRegionFuzzy(0x442d27,"0|-3|0x422f28,0|-6|0x442b26,-107|1|0x422d24,-107|-1|0x422d24,-107|-7|0x422d24", 95, 713, 108, 860, 175, 0, 0)
	if x > -1 then
		return true
	end
	return false
end

function _M.EditTeam()
	local i = 0
	repeat 
		mSleep(500)
		x, y = findMultiColorInRegionFuzzy(0xffffff,"7|1|0xffffff,18|1|0xffffff,12|-12|0xffffff,12|-8|0xffffff,11|11|0xffffff", 95, 253, 434, 319, 496, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y)		
			return true
		end
		i=i+1
	until i>5
	return false
end

function _M.PickFoodSpirit()
	local str = "0"
	local len = 0
	local i = 1
	sysLog("遺跡角色配置")
	--邪神遺跡配置
	--[[Common.config.Saber = results["et_Saber"]
	Common.config.Healer = results["et_Healer"]
	Common.config.Meat = results["et_Meat"]
	Common.config.Caster = results["et_Caster"]
	]]
	local _x , _y = 130 ,375   
	
	mSleep(1500)
	--魔法系
	str = Common.config.Caster
	len = string.len(str)
	x, y = findMultiColorInRegionFuzzy(0xc086bd,"8|0|0xc086bd", 95, 24, 448, 53, 474, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)
		mSleep(1500)
		_M.GetPosition(str,len)		
	end	
	--戰鬥系
	str = Common.config.Saber
	len = string.len(str)
	x, y = findMultiColorInRegionFuzzy(0xce7f6d,"0|2|0xd38b7b", 95, 24, 407, 52, 436, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)
		mSleep(1500)
		_M.GetPosition(str,len)		
	end	
	--防禦系
	str = Common.config.Meat
	len = string.len(str)
	x, y = findMultiColorInRegionFuzzy(0x819cbc,"-2|1|0x879fbe,-1|2|0x879ebb", 95, 26, 367, 50, 395, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)
		mSleep(1500)
		_M.GetPosition(str,len)		
	end
	--輔助系
	str = Common.config.Healer
	len = string.len(str)
	x, y = findMultiColorInRegionFuzzy(0x7aac66,"11|0|0x86b374", 95, 25, 485, 53, 514, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)
		mSleep(1500)
		_M.GetPosition(str,len)		
	end
	
	x, y = findMultiColorInRegionFuzzy(0xffbf56,"0|6|0xffbb53,3|14|0xffb655", 95, 866, 493, 952, 524, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)
	end
	mSleep(1500)
	x, y = findMultiColorInRegionFuzzy(0xffbf56,"0|6|0xffbb53,3|14|0xffb655", 95, 866, 493, 952, 524, 0, 0)
	if x > -1 then
		toast("人數配置錯誤")
		return false
	end
	mSleep(1500)
	return true
end

function _M.GetPosition(str,len)
	
	local _x , _y = 20 ,375  	
	local config = Parse.split(str,"@")
	
	for i,v in ipairs(config) do				
		
		local k = tonumber(v)
		if( k>= 8)then
			_y = 480
			k = (k % 8) +1
		else
			_y = 375
		end
		local x,y = _x + 110*k , _y
		
		touchDown(1, x , y)
		mSleep(50)
		touchUp(1, x, y)
		mSleep(1500)
	end  
	
	
end

function _M.Start()
	x, y = findMultiColorInRegionFuzzy(0xfcd8b0,"26|-1|0xfed1a0,61|-2|0xfed09e", 95, 790, 413, 946, 509, 0, 0)
	if x > -1 then
		sysLog("_M.Start(Yes)")
		touchDown(1, x , y)
		mSleep(50)
		touchUp(1, x, y)
		mSleep(1500)
		
		x, y = findMultiColorInRegionFuzzy(0xffc256,"2|12|0xffb84f,0|22|0xdf9a51", 95, 497, 305, 582, 341, 0, 0)
		if x > -1 then
			toast("掃蕩進入")
			sysLog("_M.Start(true)")
			touchDown(1, x , y)
			mSleep(50)
			touchUp(1, x, y)
			mSleep(1500)
			GI.GetAward()
		end
	else
		sysLog("_M.Start(false)")
		return false
	end
	return true
end

function _M.EditFightTeam()
	local i = 0
	repeat
		--判斷編輯黑底
		x, y = findMultiColorInRegionFuzzy(0x442a23,"7|-1|0x442a24,16|-1|0x452a24", 95, 62,330,128,364, 0, 0)
		if x > -1 then		
			touchDown(1, x , y)
			mSleep(50)
			touchUp(1, x, y)
			mSleep(4000)
		end
		--判斷黃色確認
		x, y = findMultiColorInRegionFuzzy(0xffc156,"0|16|0xffb653", 95, 738, 487, 827, 520, 0, 0)
		if x > -1 then
			sysLog("編輯霸者隊伍")
			return true
		end
		i=i+1
	until i>5
	sysLog("霸者隊伍，(Error OR 已編輯)")
	return false
end

function _M.SelectFivePeople()
	
	local i=0
	local x1,y1,x2,y2 = 100,300,190,380
	repeat
		
		x, y = findMultiColorInRegionFuzzy(0xffa800,"0|7|0xffa800,0|19|0xffa800", 95, x1+i*100, y1, x2+i*100, y2, 0, 0)
		if x > -1 then
			sysLog("角色"..tostring(i).."已選擇")
		else
			touchDown(1,  x1+i*100 +30, y1+30)
			mSleep(50)
			touchUp(1,  x1+i*100 +30, y1+30)		
			mSleep(1500)
		end
		i=i+1
	until i==5
	
end

function _M.KingContract()
	
	_M.SelectFivePeople()
	
	mSleep(1500)
	touchDown(1, 716 , 90)
	mSleep(math.random(50)+50)
	touchUp(1, 716, 90)
	mSleep(1500)
	x, y = findMultiColorInRegionFuzzy(0xff7000,"0|-4|0xff7000,0|-11|0xff7000,0|-13|0xff7000,0|-20|0xff7000", 95, 101, 284, 585, 485, 0, 0)
	if x > -1 then
		toast("契約1不成立")		
		touchDown(1, 716 , 90)
		mSleep(math.random(50)+50)
		touchUp(1, 716, 90)		
		mSleep(1500)
	end	
	touchDown(1, 716 , 160)
	mSleep(math.random(50)+50)
	touchUp(1, 716, 160)
	mSleep(1500)
	x, y = findMultiColorInRegionFuzzy(0xff7000,"0|-4|0xff7000,0|-11|0xff7000,0|-13|0xff7000,0|-20|0xff7000", 95, 101, 284, 585, 485, 0, 0)
	if x > -1 then
		toast("契約2不成立")		
		touchDown(1, 716 , 160)
		mSleep(math.random(50)+50)
		touchUp(1, 716, 160)		
		mSleep(1500)
	end
	touchDown(1, 716 , 230)
	mSleep(math.random(50)+50)
	touchUp(1, 716, 230)
	mSleep(1500)
	x, y = findMultiColorInRegionFuzzy(0xff7000,"0|-4|0xff7000,0|-11|0xff7000,0|-13|0xff7000,0|-20|0xff7000", 95, 101, 284, 585, 485, 0, 0)
	if x > -1 then
		toast("契約3不成立")		
		touchDown(1, 716 , 230)
		mSleep(math.random(50)+50)
		touchUp(1, 716, 230)		
		mSleep(1500)
	end
	x, y = findMultiColorInRegionFuzzy(0xffc156,"0|16|0xffb653", 95, 738, 487, 827, 520, 0, 0)
	if x > -1 then
		touchDown(1, x , y)
		mSleep(math.random(50)+50)
		touchUp(1, x, y)
		mSleep(1500)
	end
	
end

function _M.ReadyToBattle()
	local i=0
	
	--N次防呆，5次太少，有時候須等人物走到位，挑戰才會被觸發
	while(i<20)
	do	
	
		mSleep(math.random(300)+500)
		local _orpf = _M.OnRuinPage()
		if _orpf then
			sysLog("OnRuinPage")
			x, y = findMultiColorInRegionFuzzy(0xffd3a7,"0|5|0xffd3a7,-2|4|0xffd3a7,-2|-4|0xffd3a7", 95, 835, 428, 944, 536, 0, 0)
			if x > -1 then
				sysLog("挑戰下一關")
				touchDown(1, x , y)
				mSleep(math.random(40)+40)
				touchUp(1, x, y)
				mSleep(math.random(1200)+2000)
				x, y = findMultiColorInRegionFuzzy(0xffd3a7,"0|5|0xffd3a7,-2|4|0xffd3a7,-2|-4|0xffd3a7", 95, 835, 428, 944, 536, 0, 0)
				if x <= -1 then					
					sysLog("Runnung Battle")
					battle_flag = true
					local _bf = Battle.run(150)	--約150*3秒		
					mSleep(3000)
					if _bf == false then						
						return false
					end
				else
					sysLog("邪神 挑戰點擊 失敗")
				end	
			else
				--畫面跳轉沒有很穩，結束戰鬥後，若無即時抓到挑戰畫面，則不適合在這邊使用break
				--使用i++，使迴圈更快結束
				i=i+1
				sysLog("挑戰下一關，失敗")
			end
		else
			--並不在邪神遺跡挑戰畫面的話，為怕是挑戰結束時候，擷取畫面Delay
			--所以使用i=i+3，使迴圈更快結束
			i=i+3
		end
		i=i+1
		sysLog("邪神 Battle i="..tostring(i))
	end
	if battle_flag then
		toast("邪神 Battle Done")
		sysLog("邪神 Battle Done")
		return true
	else
		sysLog("Never Battle ")
		return false
	end
	
end

function _M.GiveUpToExit()
	mSleep(4000)
	local _orpf = _M.OnRuinPage()
	if _orpf then
		touchDown(1, 100 , 515)
		mSleep(math.random(50)+50)
		touchUp(1, 100, 515)
		mSleep(1500)
		x, y = findMultiColorInRegionFuzzy(0xffc356,"-1|16|0xffb342,-3|23|0xffb553", 95, 502, 328, 578, 359, 0, 0)
		if x > -1 then
			touchDown(1, x , y)
			mSleep(math.random(50)+50)
			touchUp(1, x, y)
			mSleep(3000)
		end		
	end
	
end

function _M.run()
	--
	_M.Enter()
	battle_flag = false
	
	local _f = _M.EditTeam()
	if _f then
		local _pfsf = _M.PickFoodSpirit()		
	end
	
	--有無使用遺跡次數
	local _sf = _M.Start()
	if _sf then		
		mSleep(5000)
	end
	
	sysLog("非使用新次數")
	
	local _ftf = _M.EditFightTeam()
	if _ftf then
		_M.KingContract()				
	end
	
	--防呆，怕上次打完沒有領寶香
	GI.GetTreasure()
	
	local _rtbf = _M.ReadyToBattle()
	-- _rtbf == false >>--失敗 或 無任何Battle情形 或 Battle失敗
	
	if _sf == false and _rtbf == false and 	battle_flag == false then
		sysLog("無法進入，也無法Battle，氣數已盡")
		toast("次數用完")
		Common.Model.Cthulhu = -1
		_M.Exit()
		return
	end	
	
	
	--失敗 或無 任何Battle情形 或 Battle失敗
	if _rtbf == false then
		_M.GiveUpToExit()
		_M.Exit()
		return
	else
		GI.GetTreasure()
		toast("推久也很累，回去補菜，下次再來窩～σ≡σ☆")
		_M.Exit()
		return
	end
	
	
	
	
	
	--[[找不到編輯按鈕代表可能已經編輯完成。
	local _ftf = _M.EditFightTeam()
	if _ftf then		
		_M.KingContract()				
	end
	local _rtbf = _M.ReadyToBattle()
	if _rtbf == false then
		_M.GiveUpToExit()
	end
	GI.GetTreasure()]]
	
end



return _M
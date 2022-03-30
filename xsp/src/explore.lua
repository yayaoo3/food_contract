_explore = {};
local Common = require("common")
local Battle = require("battle")
local GI = require("gameinterface")

local MapType = {
	[Common.Explore.GREELOW] = function()    -- for case 1	
		_explore.MapEnter()
		toast("去格瑞洛")	
		touchDown(1, 350, 270)
		mSleep(50)
		touchUp(1, 350, 270) 
		mSleep(5000)
		toast("北離島")
		touchDown(1, 450, 140)
		mSleep(50)
		touchUp(1, 450, 140) 
		mSleep(3000)
	end,
	[Common.Explore.YAO] = function()    -- for case 2	
		_explore.MapEnter()
		toast("去耀之洲")
		touchDown(1, 540, 160)
		mSleep(50)
		touchUp(1, 540, 160) 
		mSleep(5000)
		toast("天城")
		touchDown(1, 560, 400)
		mSleep(50)
		touchUp(1, 560, 400) 
		mSleep(3000)
		
	end,	
	[Common.Explore.NEFIRA] = function()    -- for case 3
		_explore.MapEnter()
		toast("去奈芙拉")
		touchDown(1, 300, 150)
		mSleep(50)
		touchUp(1, 300, 150) 
		mSleep(5000)		
		toast("地質觀測站")
		touchDown(1, 600, 320)
		mSleep(50)
		touchUp(1, 600, 320) 
		mSleep(3000)
	end,
	[Common.Explore.SAKURA] = function()    -- for case 4	
		_explore.MapEnter()
		toast("去櫻之島")
		touchDown(1, 100, 200)
		mSleep(50)
		touchUp(1, 100, 200) 
		mSleep(5000)
		toast("羅生柱")
		touchDown(1, 470, 400)
		mSleep(50)
		touchUp(1, 470, 400) 
		mSleep(3000)
		
	end,
}


function _explore.MapEnter()
	toast("進入地圖")
	mSleep(2000)
	-- 進入世界地圖ˊ
	touchDown(1, 900, 410)
	mSleep(50)
	touchUp(1, 900, 410) 
	mSleep(3000) 
end
function _explore.MapExit()
	toast("離開世界地圖")
	mSleep(1000)
	-- 進入世界地圖ˊ
	touchDown(1, 900, 500)
	mSleep(50)
	touchUp(1, 900, 500) 
	mSleep(2000) 
end

function _explore.Exit()
	toast("離開探索")
	mSleep(1000)
	-- 進入世界地圖ˊ
	touchDown(1, 40, 40)
	mSleep(50)
	touchUp(1, 40, 40) 
	mSleep(2000) 
end

function _explore.GetTreasure()
	local i=0
	repeat
		--偵測紅色箭頭
		x, y = findMultiColorInRegionFuzzy(0xff6b09,"5|3|0xff6b09,5|6|0xff6b09,12|-3|0xff6b09", 95, 651, 201, 883, 331, 0, 0)
		if x > -1 then
			toast("打開寶箱 i:"..tonumber(i))
			touchDown(1, x, y+40)
			mSleep(50)
			touchUp(1, x, y+40) 
			mSleep(4000)
			--確認領取寶箱物品
			x, y = findMultiColorInRegionFuzzy(0xffc256,"-1|15|0xffb344", 95, 441, 433, 522, 466, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(1000)
			end
		end
		i=i+1
		mSleep(50)
	until i>10 --寶箱會跳
	toast("沒有寶箱")
end

function _explore.GetAward()
	mSleep(2000)
	--偵測[恭]..喜獲得
	x, y = findMultiColorInRegionFuzzy(0xffe5b5,"0|6|0xffe3ac,1|11|0xffe1a3,15|11|0xffe1a3,15|0|0xffe5b5,9|11|0xffe1a3", 95, 378, 117, 429, 167, 0, 0)
	if x > -1 then
		toast("取得物品")
		touchDown(1, 900, 350)
		mSleep(50)
		touchUp(1, 900, 350) 
		mSleep(3000)		
	else
		toast("沒有物品")
	end
end

function _explore.IsNeedFight()
	--偵測天賦 燒烤盛宴
	x, y = findMultiColorInRegionFuzzy(0xfcc809,"-13|2|0xbc2000,-25|-1|0xfab709,-27|16|0xd74100,-14|21|0xdc4500", 95, 3,225,528,527, 0, 0)
	if x > -1 then
	else
		--點選天賦一
		touchDown(1, 60, 420)
		mSleep(50)
		touchUp(1, 60, 420) 
		mSleep(1500)
		--天賦更換 燒烤盛宴
		x, y = findMultiColorInRegionFuzzy(0xfcc809,"-13|2|0xbc2000,-25|-1|0xfab709,-27|16|0xd74100,-14|21|0xdc4500", 95, 3,225,528,527, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(1500)
			
			x, y = findMultiColorInRegionFuzzy(0xffbd56,"0|12|0xffb556,-58|-4|0xffbf56,-55|4|0xffab27", 95, 621, 192, 703, 223, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(1500)
			end
			
			touchDown(1, 900, 300)
			mSleep(50)
			touchUp(1, 900, 300) 
			mSleep(1500)
		else
			toast("未學習燒烤盛宴")
			touchDown(1, 900, 300)
			mSleep(50)
			touchUp(1, 900, 300) 
			mSleep(1500)
		end
	end
		
	--此處挑戰的火不會抖動，所以偵測紅色區塊
	x, y = findMultiColorInRegionFuzzy(0xe10002,"3|-2|0xde0000,5|1|0xe10002,11|2|0xe10002,7|-2|0xfb501d,10|-2|0xfb511d", 95, 862, 475, 920, 509, 0, 0)
	if x > -1 then
		toast("扁他")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y) 
		mSleep(3000)
		Battle.ExploreRun()
		mSleep(8000)
	end	
	
	--偵測挑戰失敗後，需要鑽石
	x, y = findMultiColorInRegionFuzzy(0xf3ffff,"0|3|0xffffff,2|8|0xa5cafb,5|3|0x3e73d7", 95, 884, 510, 916, 538, 0, 0)
	if x > -1 then		
		x, y = findMultiColorInRegionFuzzy(0xffc056,"-2|11|0xffb74f,-1|17|0xffb656", 95, 847, 51, 930, 88, 0, 0)
		if x > -1 then
			--點選撤離
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(1500)
			--點選確定退出
			x, y = findMultiColorInRegionFuzzy(0xffc156,"0|10|0xffb442,0|20|0xffb556", 95, 495, 326, 580, 362, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(3000)
				_explore.FinishJob()
				return false
			end
		end
	end
	
	return true
end


function _explore.DoNextStage()
	--偵測繼續前進btn
	x, y = findMultiColorInRegionFuzzy(0xffc256,"0|4|0xffbf56,0|11|0xffbc56,-1|23|0xffb556", 95, 918, 435, 931, 472, 0, 0)
	if x > -1 then
		toast("繼續探索")
		touchDown(1, 900, 455)
		mSleep(50)
		touchUp(1, 900, 455) 
		mSleep(3000)
		return true
	else
		sysLog("無繼續前進紐")
		toast("無繼續前進紐")
		return false
	end
	
	
end

function _explore.NextTeam()
	x, y = findMultiColorInRegionFuzzy(0xffe5ae,"-1|26|0xffda99,9|12|0xffe2a8,0|13|0xffe5ae", 95, 770,198,815,497, 0, 0)
	if x > -1 then		
		toast("換隊伍")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y) 
		mSleep(3000)	
		return true
	end
	--
	toast("無可用隊伍")
	return false
end

function _explore.SelectTeamToExplore()
	mSleep(1000)
	--偵測是否為第一隊伍
	sysLog("SelectTeamToExplore")
	local _teamf = _explore.NextTeam()
	while(_teamf)
	do
		--
		sysLog("while SelectTeamToExplore")
		x, y = findMultiColorInRegionFuzzy(0xffdab3,"-6|-15|0xffd4aa,-6|-28|0xffd3a7,10|-48|0xffd3a7", 95, 842,198,936,492, 0, 0)
		if x > -1 then
			--點擊探索
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(3000)
			--842,198,936,492 大
			--843, 418, 933, 504 
			--不沿用DoNextExplore ，流程不一樣，位置也不一樣。 這裡需要換隊伍
			--探索按鈕若仍存在，表示新鮮度不足 or 隊伍在忙
			x, y = findMultiColorInRegionFuzzy(0xffdab3,"-6|-15|0xffd4aa,-6|-28|0xffd3a7,10|-48|0xffd3a7", 95, 842,198,936,492, 0, 0)
			if x > -1 then	
				_teamf = _explore.NextTeam()
				if _teamf == false then
					_explore.Exit()		
					_explore.Exit()
					return false
				end
			else
				mSleep(2000)
				_explore.Exit()
				break								
			end
		end
	end
	
end

function _explore.GetMaterial(mtype)
	local x = -1
	local i = 0 
	mSleep(1500)
	
	while(x==-1)
	do
		if(mtype == 0 or x==-1) then
			mSleep(59)
			math.randomseed(os.time())
			mtype = math.random(4) --获取1-4的随机数 
			sysLog("搜尋mtype"..tostring(mtype))			
		end
		
		if mtype == Common.Explore.SCREW then
			sysLog("搜尋螺絲釘")
			--螺絲釘
			x, y = findMultiColorInRegionFuzzy(0x848c91,"7|4|0x787f84,-3|7|0xbdc3c6,-11|16|0x99a0a5,-4|18|0x6a7176,-12|28|0x6b7276", 95, 141, 378, 816, 435, 0, 0)
			if x > -1 then			
				touchDown(1, x, y-100)
				mSleep(50)
				touchUp(1, x, y-100) 
				toast("選べ(erabe)螺絲釘")
				mSleep(2000)
			end
		elseif mtype == Common.Explore.BRICK then
			sysLog("搜尋空心板磚")
			--空心板磚
			x, y = findMultiColorInRegionFuzzy(0x3c3329,"2|0|0x3c3329,2|-12|0x946c3f,-2|-17|0x997042,-13|-20|0xbc9664,-13|-9|0x785043", 95, 141, 378, 816, 435, 0, 0)
			if x > -1 then
				
				touchDown(1, x, y-100)
				mSleep(50)
				touchUp(1, x, y-100) 
				toast("選べ(erabe)空心板磚")
				mSleep(2000)
			end
		elseif mtype == Common.Explore.STEEL then
			sysLog("搜尋鋼材")
			--鋼材
			x, y = findMultiColorInRegionFuzzy(0xaaacbc,"8|0|0xabadbd,17|3|0x706f93,5|14|0x878ba4,-1|14|0x75769a", 95, 141, 378, 816, 435, 0, 0)
			if x > -1 then			
				touchDown(1, x, y-100)
				mSleep(50)
				touchUp(1, x, y-100)
				toast("選べ(erabe)鋼材")	
				mSleep(2000)
			end	
		elseif mtype == Common.Explore.BOARD then	
			sysLog("搜尋木板")
			--木板
			x, y = findMultiColorInRegionFuzzy(0xb48756,"12|1|0xb48756,-1|9|0x947450,11|14|0x947450,18|8|0xddc885,22|13|0x947450", 95, 141, 378, 816, 435, 0, 0)
			if x > -1 then			
				touchDown(1, x, y-100)
				mSleep(50)
				touchUp(1, x, y-100) 
				toast("選べ(erabe)木板")
				mSleep(2000)			
			end
		end
		
		i = i+1
		if i>=5 then
			break
		end
	end
	return x
end

function _explore.WhichStage(pos)
	
	if (pos==0) then
		math.randomseed(os.time())
		pos = math.random(3) --获取1-3的随机数 	
	end
	
	local x = 750
	if pos == Common.Explore.RIGHT then
		x = 750
	elseif pos == Common.Explore.LEFT then
		x = 480
	elseif pos == Common.Explore.MIDDLE then
		x = 200
	end
	--右邊探索地點
	touchDown(1, x, 250)
	mSleep(50)
	touchUp(1, x, 250) 
	mSleep(2000)	
end

function _explore.DoNextExplore()
	--偵測探索Btn
	x, y = findMultiColorInRegionFuzzy(0xffd3a7,"0|6|0xffd3a8,0|17|0xffd5ac,14|-20|0xffd3a7,23|-20|0xffd3a7", 95, 847, 442, 931, 523, 0, 0)
	if x > -1 then		
		--點擊探索
		touchDown(1, 900, 455)
		mSleep(50)
		touchUp(1, 900, 455) 
		mSleep(3000)		
		
		--探索按鈕若仍存在，表示新鮮度不足
		x, y = findMultiColorInRegionFuzzy(0xffd3a7,"0|6|0xffd3a8,0|17|0xffd5ac,14|-20|0xffd3a7,23|-20|0xffd3a7", 95, 840, 193, 941, 295, 0, 0)
		if x > -1 then
			--返回
			touchDown(1, 400, 60)
			mSleep(50)
			touchUp(1, 400, 60) 
			mSleep(1500)
			----偵測測退Btn
			x, y = findMultiColorInRegionFuzzy(0xffc056,"1|7|0xffbd56,1|20|0xffb454", 95, 703, 490, 786, 525, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(1500)
				
				----偵測退出的確定Btn
				x, y = findMultiColorInRegionFuzzy(0xffc156,"2|14|0xffb343,2|17|0xffb44d", 95, 496, 325, 578, 361, 0, 0)
				if x > -1 then
					touchDown(1, x, y)
					mSleep(50)
					touchUp(1, x, y) 
					mSleep(1500)
					_explore.FinishJob()
					
				end				
			end			
		end
		
		_explore.Exit()
	end
end

function _explore.GetMapisOnRun()
	
	mSleep(3000)	
	--偵測撤回btn	
	x, y = findMultiColorInRegionFuzzy(0xffc356,"-1|5|0xffc056,-1|20|0xffb652,0|24|0xffb354", 95, 817, 432, 836, 471, 0, 0)
	if x > -1 then
		toast("探索中")		
		return true
	end
	mSleep(500)
	return false
	
end

function _explore.FinishJob()
	mSleep(1500)
	--偵測關閉紐
	x, y = findMultiColorInRegionFuzzy(0xffc156,"2|14|0xffb343,2|17|0xffb44d", 95, 831, 474, 918, 508, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y) 
		mSleep(1500)
	end
end

function _explore.RecallTeam()
	--偵測對話框
	x, y = findMultiColorInRegionFuzzy(0xfaf2e9,"46|0|0xfffaf5,87|0|0xfffaf5,124|13|0xfffaf5,166|20|0xf9f1e8,255|9|0xf4e9de,258|-15|0xfffaf5,230|-3|0xfffaf5,30|-54|0xfffaf5,94|-53|0xfffaf5,162|-57|0xfffaf5,226|-53|0xfffaf5", 95, 440, 77, 724, 174, 0, 0)
	if x > -1 then
		toast("撤回")
		--偵測撤回btn (無路可走的那種)
		x, y = findMultiColorInRegionFuzzy(0xffc056,"1|7|0xffbd56,1|20|0xffb454", 95, 817,433,903,471, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			mSleep(1500)
			--偵測退出的確定Btn
			x, y = findMultiColorInRegionFuzzy(0xffc156,"2|14|0xffb343,2|17|0xffb44d", 95, 496, 325, 578, 361, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y) 
				mSleep(1500)
				_explore.FinishJob()
				
			end				
			_explore.FinishJob()
		end		
	end
	

end

function _explore.run()
	--SCREW = 0 , STEEL = 1 , BOARD = 2 , BRICK = 3
	
	--
	--
	local f = false
	local i=1
	while(i<=Common.config.ExploreNum)	
	do	
		local _ohpf = GI.OnHomePage()
		if _ohpf then	
			f = MapType[i]
		end
		
		if (f) then		
			f()
			local _n = _explore.GetMaterial(Common.config.Explore_Material)
			if _n > -1 then
				local _tf = _explore.SelectTeamToExplore()			
				if _tf == false then
					--return
				end				
			else
				local _morf = _explore.GetMapisOnRun()
				if _morf == false then				
					--以下 不Flag原因，崩潰無順序可言
					_explore.GetAward()
					local _inff = _explore.IsNeedFight()
					if _inff then
						_explore.GetTreasure()				
						local _dnsf = _explore.DoNextStage()
						if _dnsf then
							--選擇探索地點
							_explore.WhichStage(Common.config.Explore_Stage)	
							_explore.DoNextExplore()
						else
							--寶箱開完之後沒路走了
							_explore.RecallTeam()
							_explore.Exit()
						end
					end
				else
					_explore.RecallTeam()
					_explore.Exit()
				end
			end			
		else
			toast("探索 error ")		
		end	
		i=i+1
	end
	
	
	
end





return _explore
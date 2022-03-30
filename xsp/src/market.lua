local _M = {};
local GI = require("gameinterface")
local Parse = require("Parse")
local Common = require("common")

local TipStore = 0
local MedalStore = 1

function _M.Enter()
	mSleep(1000)
	touchDown(1, 750, 300)
	mSleep(50)	
	touchUp(1, 750, 300) 
	mSleep(4000)
end

function _M.Exit()
	mSleep(1000)
	touchDown(1, 900, 500)
	mSleep(50)	
	touchUp(1, 900, 500)  
	mSleep(1000)
end

function _M.MainStoreEnter()
	
	touchDown(1, 920, 80)
	mSleep(50)	
	touchUp(1, 920, 80)  
	mSleep(1000)
	
end

function _M.MainStoreExit()
	
	touchDown(1, 40, 40)
	mSleep(50)	
	touchUp(1, 40, 40)  
	mSleep(1000)	
end

function _M.GoTipStore()
	mSleep(1000)
	touchDown(1, 120, 400)
	mSleep(50)	
	touchUp(1, 120, 400)  
	mSleep(1000)
	x, y = findMultiColorInRegionFuzzy(0x91230d,"-13|0|0x962c0d,-27|0|0x94240d,-50|0|0x91220d", 95, 71, 374, 167, 420, 0, 0)
	if x > -1 then
		toast("小費商店")
		mSleep(1500)		
		return true
	end
	return false
end
function _M.GoMedalStore()
	mSleep(1000)
	touchDown(1, 120, 460)
	mSleep(50)	
	touchUp(1, 120, 460)  
	mSleep(1000)
	x, y = findMultiColorInRegionFuzzy(0x91230d,"-13|0|0x962c0d,-27|0|0x94240d,-50|0|0x91220d", 95, 71,439,166,484, 0, 0)
	if x > -1 then
		toast("勳章商店，這邊嘦UR卡")
		mSleep(1500)
		return true
	end
	return false
end

function _M.MainStoreTask(Kind)
	local kind = Kind
	
	local str = Parse.split(Common.config.StoreSetting,"@" )
	local i,v = -1,-1
	local index,count = 0 ,0
	
	for i,v in ipairs(str) do		
		
		--勳章商店 嘦 UR
		if kind == MedalStore then
			if tonumber(v) ~= Common.Market.UR then
				return
			end
		end	
		
		repeat		
			local mTurn = false
			if tonumber(v) == Common.Market.UR then
				--sysLog("找UR")
				if _M.Find_UR_Card() == false then
					mTurn = true
				end
			elseif tonumber(v) == Common.Market.M then
				--sysLog("找M")
				if _M.Find_M_Card() == false then
					mTurn = true
				end
			elseif tonumber(v) == Common.Market.SR then
				--sysLog("找SR")
				if _M.Find_SR_Card() == false then
					mTurn = true
				end
			elseif tonumber(v) == Common.Market.Leaf then
				sysLog("找 Leaf")
				if _M.Find_Leaf() == false then
					mTurn = true
				end	
			elseif tonumber(v) == Common.Market.Energy then
				--sysLog("找 愛心")
				if _M.Find_Energy() == false then
					mTurn = true
				end
			elseif tonumber(v) == Common.Market.Strawberry then
				--sysLog("找 愛心")
				if _M.Find_Strawberry() == false then
					mTurn = true
				end				
			else
				--其他購買選項
				mTurn = true
			end
			mSleep(1000)
			count = count + 1
			--sysLog("count"..tostring(count).." mTurn="..tostring(mTurn))
		until mTurn or count>40
	end  			
	
end
--206,154,788,479


function _M.MainStoreBuy()
	local x, y = findMultiColorInRegionFuzzy(0xffc056,"0|6|0xffbc56,-3|16|0xffb555", 95, 440, 410, 520, 442, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)	
		touchUp(1, x, y)  
		mSleep(1000)
		local f = GI.GetAward()
		if f == false then
			_M.MainStoreExit()
		end
		return f
	end
	return false
end

function _M.Find_Strawberry()
	x, y = findMultiColorInRegionFuzzy(0xfef1df,"-1|15|0xfeefdc,-1|41|0xfdebd6,0|61|0xfce8d0,-1|82|0xfbe4cb,53|83|0xfce4cb,89|82|0xfbe5cb,89|55|0xfde9d2,84|19|0xfeeeda,78|-2|0xfff1df,41|4|0xd5d5d5,5|54|0xdddddd,9|58|0xe3e3e3,14|69|0x8f7e7e,29|75|0xe3e3e3,66|78|0xcbcbcb,40|52|0xfff7f3,19|55|0xd94345,74|56|0xffffff", 95, 206,154,788,479, 0, 0)
	if x > -1 then
		toast("可買的草莓")
		mSleep(2000)
		touchDown(1, x, y)
		mSleep(50)	
		touchUp(1, x, y)  
		mSleep(1000)
		return _M.MainStoreBuy()
	end
	return false
end


function _M.Find_M_Card()
	x, y = findMultiColorInRegionFuzzy(0xd0d0d0,"-1|-16|0xcccccc,42|-23|0xd9d9d9,65|-24|0xe2e2e2,73|-13|0xe2e2e2,72|-1|0xdfdfdf,69|50|0xcccccc,41|50|0xd0d0d0,9|50|0xe1e1e1,2|50|0xe3e3e3,-12|-27|0xfff0de,-13|0|0xfeedd9,-13|63|0xfbe3c9,38|82|0xfbe0c5,78|80|0xfbe1c5,86|37|0xfce8d0,83|-27|0xfff1de", 95, 206,154,788,479, 0, 0)
	if x > -1 then
		toast("可買的M卡")
		mSleep(2000)
		touchDown(1, x, y)
		mSleep(50)	
		touchUp(1, x, y)  
		mSleep(1000)
		return _M.MainStoreBuy()
	end
	return false
end

function _M.Find_SR_Card()
	x, y = findMultiColorInRegionFuzzy(0xe34ee7,"0|17|0xe654e7,2|41|0xef61e7,6|53|0x70356d,8|54|0x70356d,12|57|0x70356d,6|61|0xef61e7,63|64|0xd94bdc,73|57|0xe44fe7,73|22|0xeb5ae7,83|-1|0xfeefdb,45|-17|0xfff0de,-6|1|0xfeefdb,-9|27|0xfdebd6,0|72|0xfbe4cb", 95, 205, 158, 784, 476, 0, 0)
	if x > -1 then
		toast("可買的SR卡")
		mSleep(2000)
		touchDown(1, x, y)
		mSleep(50)	
		touchUp(1, x, y)  
		mSleep(1000)
		return _M.MainStoreBuy()
	end
	return false
end

function _M.Find_UR_Card()
	x, y = findMultiColorInRegionFuzzy(0xfcb01d,"0|9|0xfaab20,3|33|0xef8d3b,11|52|0x634a34,6|50|0x634a34,42|60|0xfbad1e,68|60|0xffb71f,72|16|0xffab4a,73|-3|0xffa55a,86|-10|0xfeefdd,9|-21|0xfff1df,34|-21|0xfff1df,-11|9|0xfeedd9,79|59|0xfce5cd,29|66|0xfce5cb", 95, 206, 154, 788, 479, 0, 0)
	if x > -1 then
		toast("可買的UR卡")
		mSleep(2000)
		touchDown(1, x, y)
		mSleep(50)	
		touchUp(1, x, y)  
		mSleep(1000)
		return _M.MainStoreBuy()
	end
	return false
end

function _M.Find_Leaf()
	x, y = findMultiColorInRegionFuzzy(0xb5db86,"0|16|0xb2d684,1|33|0xb0d281,-5|34|0xfde8d0,-7|10|0xfdebd6,-5|-14|0xfeeedb", 95, 203, 150, 786, 474, 0, 0)
	if x > -1 then
		toast("可買的葉子")
		mSleep(2000)
		touchDown(1, x, y)
		mSleep(50)	
		touchUp(1, x, y)  
		mSleep(1000)
		return _M.MainStoreBuy()
	end
	return false
end

function _M.Find_Energy()
	x, y = findMultiColorInRegionFuzzy(0xeda41f,"0|23|0xe8952c,1|60|0xe6873b,65|60|0xf5b01c,75|-4|0xffa55a,31|8|0xff8aa2,56|9|0xff7e84,45|-19|0xfef0de,-6|-8|0xfeefdc,-6|26|0xfdebd5,-4|63|0xfbe5cb,79|66|0xfbe4cb,84|40|0xfce8d2", 95, 206, 154, 788, 479, 0, 0)
	if x > -1 then
		toast("可買的體力")
		mSleep(2000)
		touchDown(1, x, y)
		mSleep(50)	
		touchUp(1, x, y)  
		mSleep(1000)
		return _M.MainStoreBuy()
	end
	return false
end

function _M.ScanGoods()		
	
	local i=0
	repeat 				
		local pos = 0
		local _x , _y = 200 ,180  	
		
		if i~=0 then
			
			if i==1 then
				if Common.Mission.MarketFood == 1 then
					toast("第二頁，不買水果調味料")				
					pos = 3
				end
			end
			
			repeat		
				if pos % 3 == 0 and pos ~= 0 then
					_y = _y + 80
					_x = 200	
				end
				
				local x = _x + 250 * (pos % 3)
				local y = _y			
				
				if (i==2 and pos == 11) or i>=3 then					
					_M.SearchLeafToBuy()
					return
				else
					if Common.Mission.MarketFood == 1 then		
						touchDown(1, x , y)
						mSleep(50)
						touchUp(1, x, y)
						mSleep(1500)
					end
				end
								
				local c_x, c_y = findMultiColorInRegionFuzzy(0xffbf56,"0|4|0xffbd56,2|13|0xffb551", 95, 439, 406, 522, 438, 0, 0)
				if c_x > -1 then				
					touchDown(1, c_x, c_y)
					mSleep(50)	
					touchUp(1,  c_x, c_y)  
					--toast("買")
					mSleep(1000)
				end		
				
				pos = pos + 1
			until pos == 12
		elseif i==0 then
			toast("第一頁，不買。")
		end
		i = i + 1
		_M.NextPage()
	until i==5  
end

function _M.SearchLeafToBuy()
	if Common.Mission.MarketLeaf == 0 then
		return
	end
	sysLog("找葉子")
	local i=0
	repeat
		mSleep(500)
		x, y = findMultiColorInRegionFuzzy(0x8ec97f,"12|2|0x8eca82,27|-3|0x5cbd78,28|-12|0x5cbd78,17|-14|0x91cf84", 90, 109, 144, 777, 463, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)	
			touchUp(1, x, y)  
			mSleep(2000)
			
			x, y = findMultiColorInRegionFuzzy(0xffc156,"4|7|0xffbc56,3|18|0xffb455", 95, 436, 404, 524, 441, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)	
				touchUp(1, x, y)  
				mSleep(1000)
				i = i - 1
			end		
		else
			_M.NextPage()
		end
		i = i + 1
	until i==4
end

function _M.NextPage()
	touchDown(1, 800, 400)
	mSleep(50)	
	touchUp(1, 800, 400)  
	mSleep(3500)
end

function _M.runTask()
	if Common.Mission.MarketFood == 1 or Common.Mission.MarketLeaf == 1  then
		toast("確認有購買事項，LAG亂買破慘 後果請自負")				
		--這才是市場function
		_M.Enter()
		_M.ScanGoods()
		_M.Exit()
	else
		toast("市場無購買事項skip")	
	end
	
end


function _M.StoreTask()
	--小費商店 幻晶石商店
	_M.MainStoreEnter()
	_M.GoTipStore()
	_M.MainStoreTask(TipStore)		
	_M.GoMedalStore()
	_M.MainStoreTask(MedalStore)		
	_M.MainStoreExit()		
	_M.BackToHomePage()	
end

function _M.BackToHomePage()
	local _ohpf = false
	while(_ohpf==false)
	do	
		_ohpf = GI.OnHomePage()
		if _ohpf == false then
			_M.MainStoreExit()	
		end
	end
end

return _M
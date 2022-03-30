local _M = {};
local Common = require("common")


local MapType = {
	[Common.Explore.GREELOW] = function()    -- for case 1	
		_explore.MapEnter()
		toast("去格瑞洛")	
		touchDown(1, 350, 270)
		mSleep(50)
		touchUp(1, 350, 270) 
		mSleep(5000)--[[
		toast("北離島")
		touchDown(1, 450, 140)
		mSleep(50)
		touchUp(1, 450, 140) 
		mSleep(3000)]]
	end,
	[Common.Explore.YAO] = function()    -- for case 2	
		_explore.MapEnter()
		toast("去耀之洲")
		touchDown(1, 540, 160)
		mSleep(50)
		touchUp(1, 540, 160) 
		mSleep(5000)--[[
		toast("天城")
		touchDown(1, 560, 400)
		mSleep(50)
		touchUp(1, 560, 400) 
		mSleep(3000)]]
		
	end,	
	[Common.Explore.NEFIRA] = function()    -- for case 3
		_explore.MapEnter()
		toast("去奈芙拉")
		touchDown(1, 300, 150)
		mSleep(50)
		touchUp(1, 300, 150) 
		mSleep(5000)	--[[	
		toast("地質觀測站")
		touchDown(1, 600, 320)
		mSleep(50)
		touchUp(1, 600, 320) 
		mSleep(3000)]]
	end,
	[Common.Explore.SAKURA] = function()    -- for case 4	
		_explore.MapEnter()
		toast("去櫻之島")
		touchDown(1, 100, 200)
		mSleep(50)
		touchUp(1, 100, 200) 
		mSleep(5000)--[[
		toast("羅生柱")
		touchDown(1, 470, 400)
		mSleep(50)
		touchUp(1, 470, 400) 
		mSleep(3000)]]		
	end,
}

function _M.ChangeMap(mMap)
	
	if _M.OnHomePage() then
		local f = MapType[mMap]	
		if (f) then
			f()
		else
			toast("ChangeMap error ")		
		end
	end
	
end

function _M.OnHomePage()
	mSleep(2000)
	--判斷主介面的燈籠是否存在
	x, y = findMultiColorInRegionFuzzy(0xcb2010,"5|0|0xe60000,10|0|0x7d0000,5|-5|0xd6331f,5|2|0xe60000", 95, 308, 45, 336, 132, 0, 0)
	if x > -1 then
		return true
	end
	--toast("非主介面")
	return false
end

function _M.GetAward()
	mSleep(2000)
	--偵測[恭]..喜獲得
	x, y = findMultiColorInRegionFuzzy(0xffe5b5,"0|6|0xffe3ac,1|11|0xffe1a3,15|11|0xffe1a3,15|0|0xffe5b5,9|11|0xffe1a3", 95, 380,21,582,168, 0, 0)
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

function _M.GetTreasure()
	local i=0
	repeat
		--偵測紅色箭頭
		x, y = findMultiColorInRegionFuzzy(0xff6b09,"5|3|0xff6b09,5|6|0xff6b09,12|-3|0xff6b09", 95, 651, 201, 883, 331, 0, 0)
		if x > -1 then
			toast("打開寶箱 i:"..tonumber(i))
			touchDown(1, x, y+50)
			mSleep(50)
			touchUp(1, x, y+50) 
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

return _M
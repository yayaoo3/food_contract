local _M = {};

local GI = require("gameinterface")
local Battle = require("battle")
local Common = require("common")

local SearchPeople = {
	[1] = function(x1,y1,x2,y2)    -- for case 1		
		sysLog("1 People Task")
		mSleep(100)
		return _M.OnePeople(x1,y1,x2,y2)
	end,
	[2] = function(x1,y1,x2,y2)    -- for case 1		
		sysLog("2 People Task")
		mSleep(100)
		return _M.TwoPeople(x1,y1,x2,y2)
	end
	,[3] = function(x1,y1,x2,y2)    -- for case 1		
		sysLog("3 People Task")
		mSleep(100)
		return _M.ThreePeople(x1,y1,x2,y2)
	end
	,[4] = function(x1,y1,x2,y2)    -- for case 1		
		sysLog("4 People Task")
		mSleep(100)
		return _M.FourPeople(x1,y1,x2,y2)
	end
}

function _M.Enter()
	
	touchDown(1, 400, 300)
	mSleep(50)
	touchUp(1,  400, 300)
	mSleep(4000)
	
end

function _M.Exit()
	
	touchDown(1, 40,40)
	mSleep(50)
	touchUp(1, 40,40)
	mSleep(4000)
	
end

function _M.OnPVPPage()
	--活躍獎勵 紅色寶箱
	mSleep(1000)
	x, y = findMultiColorInRegionFuzzy(0xb14245,"12|0|0xb14245,32|15|0xb14245,33|23|0xb14245", 95, 770, 58, 853, 138, 0, 0)
	if x > -1 then
		return true
	end
	return false
end

function _M.OnePeople(x1,y1,x2,y2)
	x, y = findMultiColorInRegionFuzzy(0xf6e8dc,"-13|-1|0xf6e9dc,-27|0|0xf6e9dc,-42|0|0xf7e9dd,-60|0|0xf7eade,-76|0|0xf7eadf,-92|0|0xf8eadf,-111|0|0xf8ebe1,-130|2|0xf9ece1,-152|2|0xf9ece2,-168|2|0xf9ede2,-181|2|0xf9ede3,-194|2|0xfaede4,-212|1|0xfbeee4,-222|0|0xfaefe5,-232|0|0xfbefe6", 95, x1,y1,x2,y2, 0, 0)
	if x > -1 then
		sysLog("4 slot")
		return true
	end
	return false
end

function _M.TwoPeople(x1,y1,x2,y2)
	x, y = findMultiColorInRegionFuzzy(0xf9ebe1,"8|1|0xf8ebe0,15|1|0xf8ebe0,23|1|0xf8ebe0,30|1|0xf8ebdf,37|1|0xf7eadf,45|0|0xf8eadf,58|0|0xf8eade,65|0|0xf7e9de,71|0|0xf7e9dd,83|1|0xf7e9dd,96|1|0xf6e8dc,116|0|0xf6e8dc,131|0|0xf6e8db,143|2|0xf6e7da,161|2|0xf5e7d9,169|2|0xf5e6d9,175|2|0xf5e7d9", 95, x1,y1,x2,y2, 0, 0)
	if x > -1 then
		sysLog("3 slot")
		return true
	end
	return false
end

function _M.ThreePeople(x1,y1,x2,y2)
	x, y = findMultiColorInRegionFuzzy(0xf7e9de,"7|-1|0xf8eade,11|0|0xf7e9dd,19|0|0xf7e9dd,25|1|0xf6e8dd,31|1|0xf7e8dc,45|0|0xf7e9dc,52|-1|0xf7e8dd,60|-1|0xf6e8dc,75|0|0xf6e7db,86|1|0xf5e7da,103|1|0xf5e7d9,109|1|0xf5e7d9", 95, x1,y1,x2,y2, 0, 0)
	if x > -1 then
		sysLog("2 slot")
		return true
	end
	return false
end

function _M.FourPeople(x1,y1,x2,y2)
	x, y = findMultiColorInRegionFuzzy(0xf7e9de,"7|-1|0xf8eade,11|0|0xf7e9dd,19|0|0xf7e9dd,25|1|0xf6e8dd,31|1|0xf7e8dc,45|0|0xf7e9dc,52|-1|0xf7e8dd,60|-1|0xf6e8dc,75|0|0xf6e7db,86|1|0xf5e7da,103|1|0xf5e7d9,109|1|0xf5e7d9", 95, x1,y1,x2,y2, 0, 0)
	if x > -1 then
		sysLog("1 slot")
		return true
	end
	return false
end

function _M.SearchWeakTeam()
	local i=0
	local jtype=0
	repeat
		jtype=jtype+1
		i=0
		repeat 
			i=i+1	
			local x1,y1,x2,y2 = _M.GetTeamRegion(i , jtype)
			sysLog("-找"..tostring(jtype).."人------第"..tostring(i).."隊伍--")
			--sysLog("x1,y1,x2,y2----------"..tostring(x1).."--"..tostring(y1).."--"..tostring(x2).."---"..tostring(y2).."-----------")
			
			local f = SearchPeople[jtype]
			if (f) then
				local _peoplef = f(x1,y1,x2,y2)
				if _peoplef then
					_M.ClickIt(x1,y1)
					return true
				end	
			else
				toast("SearchPeople error")	
				return
			end				
			--sysLog("----------------------------")
		until i==4
	until jtype==4 
	return false
end

function _M.GetTeamRegion(order , mtype)
	--190,150,430,210
	--575,150,827,210
	--190,315,430,375
	--572,315,833,375
	-- order : 第幾序隊
	-- mtype : 隊伍中 幾人
	local x1,y1,x2,y2 = 0,0,0,0
	if order == 1 then
		x1,y1,x2,y2 = 190,155,430,165
	elseif order == 2 then
		x1,y1,x2,y2 = 575,155,830,165
	elseif order == 3 then
		x1,y1,x2,y2 = 190,325,430,335
	elseif order == 4 then
		x1,y1,x2,y2 = 575,325,830,335 
	end
	
	x1 = x1 + (mtype-1) * 60
	
	
	return x1,y1,x2,y2 
	
end

function _M.ClickIt(x1, y1)
	touchDown(1, x1, y1)
	mSleep(50)
	touchUp(1,  x1, y1)
	mSleep(5000)
end

function _M.GetFirstVictory()
	touchDown(1, 70, 120)
	mSleep(50)
	touchUp(1,  70, 120)
	mSleep(3000)
	local k = GI.GetAward()
	if k == false then
		touchDown(1, 70, 120)
		mSleep(50)
		touchUp(1,  70, 120)
		mSleep(3000)
	end
end

function _M.OneOnOne()
	--挑戰開始
	x, y = findMultiColorInRegionFuzzy(0xffd3a7,"0|8|0xffd3a8,4|20|0xffd5ab", 95, 432, 392, 523, 489, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1,  x, y)
		mSleep(3000)
		
		x, y = findMultiColorInRegionFuzzy(0xffd3a7,"0|8|0xffd3a8,4|20|0xffd5ab", 95, 432, 392, 523, 489, 0, 0)
		if x > -1 then							
			sysLog("次數用盡")
			Common.Model.PVP = -1
			return false
		else
			Battle.run(100)
			mSleep(3500)
			GI.GetAward()					
		end			
	end
	return true
end

function _M.run()
	
	_M.Enter()
	local i=0
	repeat
		i = i + 1
		local _oppf =  _M.OnPVPPage()	
		if _oppf then
			touchDown(1, 650,330)
			mSleep(50)
			touchUp(1, 650,330)
			mSleep(4000)
			local _swtf = _M.SearchWeakTeam()
			--_swtf = false
			if _swtf == false then				
				--換一批
				x, y = findMultiColorInRegionFuzzy(0xffc056,"4|11|0xffb753,5|17|0xffb556", 95, 436, 437, 522, 473, 0, 0)
				if x > -1 then				
					--是不是需要鑽石
					xp, yp = findMultiColorInRegionFuzzy(0xeeffff,"2|1|0xddffff,2|4|0x8dd8f7,-2|5|0xc8dcff", 95, 439, 436, 523, 474, 0, 0)
					if xp > -1 then
						toast("需要鑽石zz")
						mSleep(1000)
						math.randomseed(os.time())
						mSleep(87)
						local mTeam = math.random(4) --获取1-4的随机数 
						toast("都很強的樣子,選"..tostring(mTeam).."隊吧qq")
						local _xa, _ya, _xb, _yb  = _M.GetTeamRegion(mTeam , 1)
						touchDown(1, _xa, _ya)
						mSleep(50)
						touchUp(1, _xa, _ya)
						mSleep(4000)
						local _ooof = _M.OneOnOne()
						if _ooof ==false then
							break
						end
					else
						touchDown(1, x, y)
						mSleep(80)
						touchUp(1, x, y)
						mSleep(2000)
						--確認
						x, y = findMultiColorInRegionFuzzy(0xffc056,"0|6|0xffbc56,-2|15|0xffb450", 95, 495, 305, 580, 340, 0, 0)
						if x > -1 then
							touchDown(1, x, y)
							mSleep(80)
							touchUp(1, x, y)
							mSleep(4000)
							_M.Exit()
						end		
					end			
				end								
			else
				local _ooof = _M.OneOnOne()
				if _ooof ==false then
					break
				end
			end
			
			
			
		end
	until i==5
	_M.GetFirstVictory()
	_M.Exit()
end

return _M
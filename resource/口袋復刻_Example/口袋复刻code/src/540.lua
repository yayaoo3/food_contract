require "public"
local t = {}
t["主界面"] = --取色列表
{
	{917,411,0xff5c3b},
	{923,411,0xff5c3b},
	{931,417,0xe0331a},
	{908,432,0xffffff},
	
	click = function ()   --第一次恢复精灵球
		tap(918,427)
		mSleep(2000)
		tap(131,486)
		mSleep(1000)
		tap(530,46)
		mSleep(1000)
	end
}

t.findNew = function()
	local x, y =  findMultiColor({0xfde400, "11|-7|0xfdf600,10|8|0xfdcc00,31|4|0xffd802,34|0|0xfde401", 95, 5, 5, 955, 535})
		if x > -1 then
			tap(x + 30, y + 30)
			return true
		else
			return false
		end
end

t["藏宝屋"] = {
	click = function ()
		tap(644,302)
	end,
	
	
	leftSwip = function ()
		swip(776,  345,  401,  341)
	end,
	
	rightSwip = function ()
		swip(401,  341, 776,  345)
	end,
	
	select = function (i)
		local tmp = {{428,360}, {585,358}, {734,357}}
		tap(tmp[i][1], tmp[i][2])
	end,
}

t["联盟试炼"] = {
	click = function ()
		tap(315,309)
		mSleep(3000)
		tap(474,314)
	end,	
}

t["试炼"] = {
	click = function ()
		tap(916,144)
	end
}


t["冒险"] = 
{
	
	click = function ()
		tap(72,222)
	end,	
}


t["冒险挑战"] =
{
	{728,276,0x2daff7},
	{787,278,0x3db4f6},
	{833,52,0xffffff},
	{840,59,0xffffff},
	
	click = function ()
		tap(760,280)
	end,
	
	close = function ()
		tap(835,52)
	end,
	
	findXB = function ()
		return findMultiColor({0xf8d47c, "-5|-1|0xf9d780,5|-1|0xf9d780,0|5|0xf3c669", 90, 860, 490, 890, 513})
	end
}

t["试炼挑战"] = --取色列表
{
	{735,454,0x2db0f8},
	{741,454,0x2db0f8},
	{802,455,0x38b4f6},
	{827,88,0xffffff},
	
	click = function ()
		tap(774,459)
	end
}


t["自动"] = 
{
	{885,37,0x401f0e},
	{875,37,0x401f0e},
	{893,38,0x401f0e},
	{908,49,0x401f0e},
	{867,47,0x401f0e},
	
	click = function()
		tap(890,39)
	end,
}

t["奖励"] = --取色列表
{
	{478,470,0x05a1f4},
	{496,467,0x05a1f4},
	{445,463,0x05a1f4},
	{394,82,0xf9c844},
	{558,87,0xf5b350},
	
	click = function ()
		tap(480,451)
	end
}



t["出战精灵"] = 
{
	{713,153,0x802e1d},
	{745,166,0x6d1a0a},
	{727,197,0x737373},
	{700,187,0x808080},
	{697,180,0x808080},
	
	
	go = function ()
		for i=1,6 do
			tap(191+(i-1)*120,292)
			mSleep(500)
		end
	end,
	
	ok = function ()
		tap(820,166)
	end
}

t["恢复精灵"] = {
	click = function ()
		tap(929,310)
		mSleep(2000)
		tap(131,486)
		mSleep(1000)
		tap(530,46)
		mSleep(1000)
	end,
}

t["次数满"] = --取色列表
{
	{349,347,0x07a0f2},
	{393,327,0xc8eafc},
	{423,327,0x44b8f5},
	{419,347,0x07a0f2},
	{568,346,0x07a0f2},
	
	click = function ()
		tap(567,335)
	end,
	
	close = function ()
		tap(828,88)
		mSleep(1500)
		tap(828,88)
		mSleep(2000)
	end,
	
	
	oneClose = function ()
		tap(828,88)
		mSleep(2000)
	end
	
}

t["野外遇怪"] = --取色列表
{
	{423,484,0x05a1f4},
	{400,484,0x05a1f4},
	{545,487,0x05a1f4},
	{564,487,0x05a1f4},
	
	click = function ()
		tap(427,468)
	end
}

return t










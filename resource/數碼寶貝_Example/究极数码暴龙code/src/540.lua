require "public"
local t = {}

t["主界面"] =
{
	{497,66,0x27f6fb},
	{224,49,0x727c86},
	{314,49,0x727c86},
	{41,65,0x33f8fb},
}

t["确定"] = --取色列表
{
	{309,596,0x05a5ff},
	{309,577,0x6ccdff},
	{215,576,0x699dff},
	{227,570,0xd6dbff},
	{234,595,0x4aa5ff},
	
	
	click = function ()
		tap(265,585)
	end
}

t["确定1"] = --取色列表
{
	{214,675,0x6495ff},
	{311,671,0x78cdff},
	{305,694,0x06a1ff},
	{236,690,0x54a7ff},
	
	click = function ()
		tap(264,680)
	end
}


t["升级"] = --取色列表
{
	{83,415,0xf9c824},
	{113,415,0xf9cd26},
	{112,442,0xf4a615},
	{173,424,0xf8bf20},
	
	click = function ()
		tap(261,751)
	end
}

t["屠魔次数完"] = 
{
	{416,450,0xffffa3},
	{370,449,0xffffae},
	{129,457,0x5091ff},
	{231,475,0x02b2ff},
	
	click = function ()
		tap(178,460)
	end
}

return t










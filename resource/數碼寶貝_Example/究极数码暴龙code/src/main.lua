require "public"
local t = require "540"

function qhb()
	while (true) do
		touchDown(1, 148,804)
		mSleep(20)
		touchUp(1, 148,804)
		mSleep(20)
	end
end

function tm()
	tap(312,908)  --点击屠魔
	mSleep(2000)
	
	local s_time = 0
	local ddqhb = getNumberConfig("等待屠魔抢红包", 1)
	local m = getNumberConfig("屠魔间隔", 10)
	while (true) do
		tap(261,519)
		mSleep(200)
		
		keepScreen(true)
		if cmpColorEx(t["确定"]) then
			t["确定"].click()
		end

		if cmpColorEx(t["确定1"]) then
			t["确定1"].click()
		end
		
		if cmpColorEx(t["升级"]) then
			t["升级"].click()
		end
		
		
		if cmpColorEx(t["屠魔次数完"]) then
			t["屠魔次数完"].click()
			mSleep(2000)
			s_time = os.clock()
			while (true) do
				if os.clock() - s_time >= m*60*1000 then
					toast("继续屠魔")
					mSleep(2000)
					break
				elseif ddqhb == 1 then
					touchDown(1, 148,804)
					mSleep(20)
					touchUp(1, 148,804)
					mSleep(20)
				else
					mSleep(5000)
				end
			end	
		end
		
		
		keepScreen(false)
		mSleep(100)
	end
	keepScreen(false)

end

function Split(str, split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end

function main()
	width, height = getScreenSize()
	if (width == 540 and height == 960) or (width == 720 and height == 1280) or (width == 1080 and height == 1920) or (width == 1440 and height == 2560) then
		sysLog("540*960分辨率")
		setScreenScale(540, 960)
	else
		toast("不支持该分辨率!")
		mSleep(2000)
		lua_exit()
	end


	init("0", 0)
	local ret,results = showUI("ui.json")
	if ret == 0 then
		lua_exit()
	end
	mSleep(500)
	
	
	if false == cmpColorEx(t["主界面"]) then
		dialog("在主界面启动", 0)
		lua_exit()
	end
	toast("在主界面")
	mSleep(2000)
	

	setNumberConfig("屠魔间隔", tonumber(results["102"]))
	if results["103"] == "0" then
		setNumberConfig("等待屠魔抢红包", 1)
	else
		setNumberConfig("等待屠魔抢红包", 0)
	end
	
	
	
	if results["101"] ~= "" then
		for _v,v in ipairs(Split(results["101"],'@')) do
			if v == "0" then
				qhb()
			elseif v == "1" then
				tm()
			end
		end
	end
end

main()



require "public"
local t = require "540"
function zdmx()
	t["冒险"].click()
	mSleep(3000)
	
	while (true) do
		if t.findNew() == true then
			mSleep(100)
			toast("发现冒险")
			break
		end
			
		mSleep(1000)
	end

	local i = 0
	while (true) do
		keepScreen(true)
		if cmpColorEx(t["冒险挑战"]) == true then
			if getNumberConfig("恢复", 0) == 1 then
				i = i + 1
				if i > getNumberConfig("恢复次数", 2) then
					toast("恢复精灵")
					i = 0
					t["冒险挑战"].close()
					mSleep(1000)
					t["恢复精灵"].click()
					keepScreen(false)
					mSleep(1000)
					while (true) do
						if t.findNew() == true then
							toast("发现冒险")
							mSleep(2000)
							break
						end
						mSleep(1000)
					end
				end
			end
		
			t["冒险挑战"].click()
			toast("点击挑战")
		end
		
		
		if cmpColorEx(t["自动"]) == true then
			t["挑战"].click()
			toast("点击自动")
		end
		
		
		local x, y = t["冒险挑战"].findXB()
		if x > -1 then
			tap(x, y)
			mSleep(1000)
		end
		
		keepScreen(false)
		mSleep(2000)
	end	
end


function lmsl() --联盟试炼
	t["试炼"].click()
	mSleep(2000)
	
	local flag = false
	for i=1,3 do
		t["联盟试炼"].click()
		mSleep(3000)
		
		if czjl() == true then
			t["次数满"].oneClose()
			flag = true
			break
		end
	end
	
	if flag == false then
		t["次数满"].oneClose()
	end
	
end


function czjl()   --出战精灵
	local flag = false
		t["藏宝屋"].leftSwip()
		mSleep(1500)
		for i=3,1,-1 do
			t["藏宝屋"].select(i)
			mSleep(2000)
			
			if cmpColorEx(t["次数满"]) == true then
				t["次数满"].click()
				mSleep(1000)
				t["次数满"].close()
				return true
			end
			
			
			if cmpColorEx(t["试炼挑战"]) == true then
				t["试炼挑战"].click()
				flag = true
				break
			end
		end
		
		if flag == false then
			t["藏宝屋"].rightSwip()
			mSleep(2000)
			for i=2,1,-1 do
				t["藏宝屋"].select(i)
				mSleep(1000)
				if cmpColorEx(t["试炼挑战"]) == true then
					t["试炼挑战"].click()
					break
				end
			end
		end
	mSleep(1000)	
	
	if true == cmpColorEx(t["出战精灵"]) then
		t["出战精灵"].go()
	end
	t["出战精灵"].ok()
	
	
	while (true) do
		keepScreen(true)
		if true == cmpColorEx(t["奖励"]) then
			t["奖励"].click()
			break
		end
		keepScreen(false)
		mSleep(1000)
	end
	keepScreen(false)
	mSleep(2000)
	return false
end

function cbw() --藏宝屋
 	t["试炼"].click()
	mSleep(2000)
	
	for i=1, 3 do
		t["藏宝屋"].click()
		mSleep(2000)
		
		if czjl() == true then
			break
		end
	end
	
	if flag == false then
		t["次数满"].oneClose()
	end
	
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


	init("0", 1)
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
	
	
	t["主界面"].click()
	
	--写入
	if results["102"] == "0" then
		setNumberConfig("恢复", 1)
		setNumberConfig("恢复次数", tonumber(results["103"]))
	else
		setNumberConfig("恢复", 0)
		setNumberConfig("恢复次数", tonumber(results["103"]))
	end
	
	if results["101"] ~= "" then
		for _v,v in ipairs(Split(results["101"],'@')) do
			if v == "0" then
				cbw()
			elseif v == "1" then
				lmsl()
			elseif v == "2" then
				zdmx()
			end
		end
	end
end

main()



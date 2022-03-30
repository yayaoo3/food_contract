local Battle = require("battle")
local Common = require("common")
local schoolsupply = {};


function schoolsupply.enter()
mSleep(1000)
touchDown(1, 126, 284)
mSleep(50)
touchUp(1, 126, 284)
sysLog("進入學院補給")

end

function schoolsupply.exit()
mSleep(1000)
touchDown(1, 41, 37)
mSleep(50)
touchUp(1, 41, 37)
sysLog("離開學院補給")

end

function schoolsupply.Fight()


mSleep(1000)
touchDown(1, 892, 472)
mSleep(50)
touchUp(1,  892, 472)
sysLog("點擊 戰鬥")

return Battle.run(30)

end

function schoolsupply.detectCount()

	mSleep(1000)
	touchDown(1, 150, 350)
	mSleep(50)
	touchUp(1, 150, 350)
	sysLog("點擊第一挑戰")
	
	mSleep(3000)
	--點擊最左挑戰，偵測有無挑戰按鈕
	x, y = findMultiColorInRegionFuzzy(0xffd3a7,"0|2|0xffd3a7,0|10|0xffd3a8,0|22|0xffd6ac", 95, 840, 410, 946, 514, 0, 0)
	if x > -1 then
		toast("仍有次數可以打")		
		return true
	end
	--return [false] to end repeat loop
	return false
end


function schoolsupply.run()
	schoolsupply.enter()
	local i=0
	repeat 
		local f = schoolsupply.detectCount()
		if f then
			status = schoolsupply.Fight()
			if status == false then
				sysLog("可能打輸或未知錯誤")
				toast("可能打輸或未知錯誤")
				break;
			end
			sysLog("schoolsupply Fight Done")
			mSleep(4000)
		else
			toast("次數用完")
			sysLog("學院No Battle.. Count Done")
			Common.Model.SCHOOLSUPPLY = -1
		end
		mSleep(500)
	i = i+1
	until i==10 or f==false
	--schoolsupply.exit()
end

return schoolsupply
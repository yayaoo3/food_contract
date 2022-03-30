--(ケガレ)
--（バサラ）
local Common = require("common")
local mkegare = {};
local GI = require("gameinterface")



function mkegare.enter()	
	mSleep(1000)
	touchDown(1, 470, 470)
	mSleep(50)
	touchUp(1, 470, 470)	
	toast("進入墮神")
	mSleep(1000)
end

function mkegare.exit()
	mSleep(1000)
	toast("離開墮神")
	touchDown(1, 40, 40)
	mSleep(50)
	touchUp(1, 40, 40)	
	mSleep(5000)
end

--選擇靈體
function mkegare.selectType(pos)


	sysLog("pos"..pos)
	
	gap_x = tonumber(pos) % 4 - 1;
	gap_y = math.floor( (tonumber(pos)-1) / 4 ); --(0~2)
	if gap_x == -1 then
		gap_x = 3
	end
	x = 670 + 80*gap_x
	y = 130 + 70*gap_y
	--sysLog("(x,y)"..x..","..y)
	if tonumber(pos) >= 17 or tonumber(pos) <=0  then
		toast("墮神位置 錯誤!!")
	else		
		mSleep(1000)
		toast("第"..tostring(pos).."墮神!")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)	
	end
    --[[
	x1 = 900
	y1 = 120 + pos*75
	mSleep(1000)
	toast("選擇墮神")
	touchDown(1, x1 , y1)
	mSleep(50)
	touchUp(1, x1 , y1)
	mSleep(1000)]]
		
	
end

--偵測淨化按鈕
function mkegare.detectHatchBtn()
	mSleep(1000)
	x, y = findMultiColorInRegionFuzzy(0xffbd56,"1|8|0xffb349,2|14|0xffb355,4|14|0xffb455", 95, 181, 481, 269, 521, 0, 0)
	if x > -1 then
		return true,x,y
	end
	return false,x,y
end

function mkegare.Hatch()
	local mpos = tonumber(Common.config.KEGAREPos)
	i=0
	count = 5
	while(count>i)
	do		
		mkegare.selectType(mpos)--這參數可能是要放i的		
		f,x,y = mkegare.detectHatchBtn()	
		if f then
			mSleep(500)
			toast("QQ牛里脊肉")
			touchDown(1, x , y)
			mSleep(50)
			touchUp(1, x , y)
			mSleep(1000)
		else
			toast("該位置無靈體，位置 減1")
			mpos = mpos -1
		end
		i=i+1
		--防呆
		if i>=5 then
		break
		end
	end
end

function mkegare.Getkegare()
	mSleep(1500)
	i = 0	
	x_a=150
	y_a=100
	
	repeat			
		x1 = x_a+i*85
		y1 = y_a
		touchDown(1, x1 , y1)
		mSleep(50)
		touchUp(1, x1 , y1)
		mSleep(1500)
		i=i+1
		
		f = mkegare.checkBoxOpen()
		if f then
			--領取	
			--偵測領取黃色按鈕 --vs(綠色鑽石加速按鈕)
			x, y = findMultiColorInRegionFuzzy(0xffb150,"6|-1|0xffb04d,19|0|0xffb14f,33|-2|0xffb24e,43|0|0xffb354", 95, 291, 471, 363, 518, 0, 0)
			if x > -1 then		
				touchDown(1, x , y)
				mSleep(50)
				touchUp(1, x , y)
				mSleep(1000)			
				sysLog("取得第"..tostring(i).."槽墮神")
				mSleep(5000)
				
				x, y = findMultiColorInRegionFuzzy(0xffb150,"6|-1|0xffb04d,19|0|0xffb14f,33|-2|0xffb24e,43|0|0xffb354", 95, 826, 468, 907, 505, 0, 0)
				if x > -1 then
					touchDown(1, x , y)
					mSleep(50)
					touchUp(1, x , y)
					toast("油蝦")
					mSleep(3000)
					
				else
					toast("Getkegare eror")
				end
			else
				toast("第"..tostring(i).."槽墮神還在孵化中或空槽")
			end
		else
			toast("未解鎖")
			mSleep(1000)
			touchDown(1, 40, 40)
			mSleep(50)
			touchUp(1, 40, 40)	
			mSleep(2000)
			break
		end		
		
	until i==5
	
	mSleep(1500)
	
end


function mkegare.checkBoxOpen()
	--淨化皿確認
	mSleep(2000)
	x, y = findMultiColorInRegionFuzzy(0xffbf56,"0|9|0xffb13a,1|20|0xffb355", 95, 498, 326, 579, 359, 0, 0)
	if x > -1 then
		return false
	end
	return true
end


function mkegare.runTask()
	local _ohpf = GI.OnHomePage()
	if _ohpf  then
		mkegare.enter()		
		mkegare.Getkegare()	
		mkegare.Hatch()				
		mkegare.exit()
	end
end

return mkegare

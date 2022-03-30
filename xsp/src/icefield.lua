local micefield = {};
local Common = require("common")

function micefield.enter()
	mSleep(1000)
	touchDown(1, 766, 366)
	mSleep(50)
	touchUp(1, 766, 366)
	
	toast("進入冰場")
	mSleep(2000)
end

function micefield.exit()
	mSleep(1000)
	-- 離開經營
	touchDown(1, 40, 40)
	mSleep(50)
	touchUp(1, 40, 40) 
	toast("離開冰場")
	mSleep(3000)
end

function micefield.tiredEnter()
	mSleep(1000)
	-- 進入疲勞食靈
	touchDown(1, 90, 500)
	mSleep(50)
	touchUp(1, 90, 500) 
	toast("點開介面")
	mSleep(1000)
end

function micefield.tiredExit()
	mSleep(1000)
	-- 進入疲勞食靈
	touchDown(1, 500, 250)
	mSleep(50)
	touchUp(1, 500, 250) 
	toast("離開介面")
	mSleep(1000)
end


function micefield.detectLive()
	mSleep(3000)
	local i=0
	while(true)
	do
		i=i+1
		x, y = findMultiColorInRegionFuzzy(0x5b8440,"2|2|0x5b8440,4|3|0x5b8440,7|0|0x5c8441,11|-2|0x5b8440,13|-5|0x5b8440", 95, 227, 10, 739, 64, 0, 0)
		if x > -1 then			
			-- 進入疲勞食靈
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y) 
			toast("給我放開他!")
		else
			toast("無完整食靈")
			break
		end
		mSleep(2500)
		if i>=10 then
		--防呆
			break
		end
	end
end

--偵測冰場位子鎖數量
function micefield.CheckLockGrid()	
	mSleep(1000)
	--第八 651,488,694,527
	--第七 594,488,637,529	
	local i=0		
	local lockNum = 0
	repeat
		x1 = 650 - i * 60
		y1 = 488
		x2 = 700 - i * 60
		y2 = 527
		mSleep(100)		
		x, y = findMultiColorInRegionFuzzy(0xffffff,"1|8|0xffffff,14|8|0xffffff,15|2|0xffffff,7|2|0x592e2a,6|-6|0xffffff", 95, x1, y1, x2, y2, 0, 0)
		if x > -1 then
			lockNum = lockNum +1
			--toast(tostring(lockNum))
			--sysLog("(x,y)"..x..","..y.." locknum:"..tostring(lockNum))
		end
		i = i+1
	until i>=5
	toast("Lock數量:"..tostring(lockNum))
	return lockNum
end

--偵測冰場位子空數量
function micefield.GetNumEmptyGrid()	
	--toast("偵測Empty數量")
	mSleep(100)
	--第八 680,7,736,59  746,6,801,59
	--第七 614,5,669,59	
	local i=1
	local EmptyNum = 0
	repeat
		x1 = 745  - 65 * ( i )
		y1 = 5
		x2 = 810 - 65 * ( i )
		y2 = 60		
		mSleep(10)		
		x, y = findMultiColorInRegionFuzzy(0x592e2a,"-1|8|0x592e2a,14|10|0x592e2a,15|-1|0x592e2a,-11|-15|0x592e2a,-9|23|0x592e2a,26|24|0x592e2a,25|-11|0x592e2a", 95, x1, y1, x2, y2, 0, 0)
		if x > -1 then
			EmptyNum = EmptyNum +1			
			--sysLog("(x,y)"..x..","..y.." EmptyNum:"..tostring(EmptyNum))
		end
		i = i+1
	until i>=9
	--toast("EmptyNum:"..tostring(EmptyNum))
	return EmptyNum
end

function micefield.detectTriedFoodSpirit(x1,y1,x2,y2)
	x, y = findMultiColorInRegionFuzzy(0x9e9898,"0|4|0x9e9898,0|6|0x9e9898", 95, x1,y1,x2,y2, 0, 0)

	return x,y
end

function micefield.putFoodSpirit()	
	
	local lockNum = micefield.CheckLockGrid()
	--
	micefield.tiredEnter()	
	micefield.detectLive()
	--
	local oriEmptyNum = micefield.GetNumEmptyGrid()
	local EmptyNum = oriEmptyNum
	local EnableNum = oriEmptyNum - lockNum
	if EnableNum == 0 then
		return
	end
	local i=0
	local p=0 --防呆用
	repeat
		
		--sysLog("start i:"..tostring(i))
		
		x1 = 100  + 130 * ( i )
		y1 = 505
		x2 = 180 + 130 * ( i )
		y2 = 525

		x_a , y_a = micefield.detectTriedFoodSpirit(x1,y1,x2,y2)
		if x_a > -1 then
			-- 放入食靈
			touchDown(1, x_a, y_a)
			mSleep(50)
			touchUp(1, x_a, y_a)
			--toast("你能進去溜冰嗎~?")
			--sysLog("人"..tostring(i))
		else
			toast("沒人疲倦囉~")
			--sysLog("沒人"..tostring(i))
			break
		end		
		
		
		--重新偵測數量
		EmptyNum = micefield.GetNumEmptyGrid()
		
		if EmptyNum == oriEmptyNum then
			toast("抱歉，不行 Pos:"..tostring(i+1))
			i = i+1
			mSleep(200)					
			if i>=6 then
				toast("下一頁")
				touchDown(1, 915, 435)
				mSleep(50)
				touchUp(1, 915, 435)
				mSleep(1000)
				i=0
				p= p + 1 
			end
			
		else
			toast("謝謝!")	
			oriEmptyNum = EmptyNum
			EnableNum = EmptyNum - lockNum
		end
				
		--sysLog("end i:"..tostring(i))
	until p>5 or EnableNum == 0
	
	
	micefield.tiredExit()
end


function micefield.ForceRemove()	
	mSleep(1500)
	local lockNum = micefield.CheckLockGrid()
	toast("lockNum:"..tostring(lockNum))
	mSleep(1000)
	-- 進入疲勞食靈
	micefield.tiredEnter()		
	mSleep(1500)	
	if Common.Restaurant.ForceRemoveNumber > 0 then
		local i=0
		repeat			
			i = i+1
			-- x座標 shift
			x1 = 770  - 65 * (lockNum + i )
			y1 = 33		
				touchDown(1, x1, y1)
				mSleep(50)
				touchUp(1, x1, y1) 
				toast("Force Remove")
			mSleep(2000)	
		until i==Common.Restaurant.ForceRemoveNumber
	end
	--	
	micefield.tiredExit()
end

function micefield.removeLiveFoodSpirit()
	micefield.tiredEnter()
	
	micefield.detectLive()
	
	micefield.tiredExit()
end





return micefield
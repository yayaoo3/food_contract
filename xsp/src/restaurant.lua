local mrestaurant = {};
local Common = require("common")
local Battle = require("battle")
local Login = require("login")

math.randomseed(os.time())
local DelayClick = 1000

function mrestaurant.enter()
	mSleep(1000)
	touchDown(1, 564, 373)
	mSleep(80)
	touchUp(1, 564, 373)  
	
	sysLog("進入餐廳")
	mSleep(1000)
end


function mrestaurant.exit()
	mSleep(1000)
	-- 各種離開
	touchDown(1, 40, 40)
	mSleep(66)
	touchUp(1, 40, 40) 
	sysLog("離開")
	mSleep(2000)
end

function mrestaurant.RubiTask(mtype)
	
	mrestaurant.waitforHarvest()
	
	mSleep(2500)
	if mtype ==  Common.Restaurant.FRIEND then
		mSleep(500)		
		--click friend list
		toast("朋友清單")
		touchDown(1, 930, 260)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 930, 260) 
		mSleep(1500)		
		--清單有著驚嘆號的路比
		x, y = findMultiColorInRegionFuzzy(0xff7937,"1|3|0xff7937,1|6|0xff7937,-8|-4|0xff7937,-8|-2|0xff7937", 95, 86, 1, 960, 479, 0, 0)
		if x > -1 then	
			--Nothing
		else
			--清單的路比
			x, y = findMultiColorInRegionFuzzy(0x2f060b,"0|1|0x240202,1|5|0xffffff,-2|8|0xffffff,1|10|0xfffcf9", 95, 881, 133, 952, 502, 0, 0)			
		end
		mSleep(3000)
		if x > -1 then		
			toast("拔刀相助，GO!")
			touchDown(1, x, y)
			mSleep(80)
			touchUp(1, x, y)  			
			mSleep(2500)
			
			--縮回右側清單
			touchDown(1, 300, 30)
			mSleep(60)
			touchUp(1, 300, 30) 
			mSleep(2500)
			f = mrestaurant.FindRubi()
			if f then
				mrestaurant.killRubi()
			else
				toast("偵測不到路比")
			end
			
			
		end
	end
	
	mSleep(1000)
	
	mrestaurant.exit()
	
end



function mrestaurant.killRubi()
	x, y = findMultiColorInRegionFuzzy(0xfae7c5,"0|1|0xfbe6c5,-1|3|0xfbe5c3,-1|7|0xfcd9b0,-1|16|0xfbdcb7", 95, 767, 468, 852, 501, 0, 0)
	if x > -1 then
		--偵測獵殺按鈕
		toast("有獵殺紐")
		touchDown(1, x, y)
		mSleep(50)
		touchUp(1, x, y)  			
		mSleep(2000)
		--有確認紐
		x, y = findMultiColorInRegionFuzzy(0xffc156,"1|8|0xffbc56,1|15|0xffb44c", 95, 498, 306, 580, 339, 0, 0)
		if x > -1 then
			toast("死ぬ")
			touchDown(1, x, y)
			mSleep(70)
			touchUp(1, x, y)  			
			mSleep(2500)
			
			mrestaurant.waitforHarvest()
		else
			toast("次數不足")
		end	
	else
		toast("RUBI偵測錯誤")
	end
end

function mrestaurant.FindRubi()
	
	
	
	local i = 1
	local k = 1
	--find rubi
	repeat
		--x, y = findMultiColorInRegionFuzzy(0x706e5a,"0|2|0x706f5a,-4|3|0xffffff,-7|6|0xfffffe,-8|9|0xfffcf9,-16|11|0xfff4f0,-23|12|0xffc3b5,-20|19|0xffbaab,-23|20|0xd27765,-20|23|0xbd7157,-23|32|0xd6b4a6,-23|33|0x967e71,1|-23|0xabcb68,2|-24|0xadcb68,4|-27|0xffffff,4|-29|0xe4a095", 75, 98,75,959,478, 0, 0)
		x, y = findMultiColorInRegionFuzzy(0xffffff,"3|0|0xffffff,6|-2|0x6e6a57,13|-3|0x706f5a,16|-9|0xffffff,24|-6|0xffffff,18|10|0xfff0ec,27|9|0xffbfb3,25|12|0xffbaaa,23|13|0xffbaab", 95, 98, 75, 959, 478, 0, 0)
		if x > -1 then			
			toast("找到面左邊RUBI#x"..tostring(x)..",y"..tostring(y))
			sysLog("找到面左邊RUBI#x"..tostring(x)..",y"..tostring(y))
			touchDown(1, x, y)
			mSleep(80)
			touchUp(1, x, y)  
			
			mSleep(2000)
			return true					
			
		else
			sysLog("沒有面左邊型態的RUBI")
		end
		
		mSleep(10)
		i = i+1
		
	until i==70
	
	mSleep(1000)
	
	repeat
		--ori
		--x, y = findMultiColorInRegionFuzzy(0x6e6a57,"1|0|0x6e6a57,11|2|0xfefefe,9|0|0x706f5a,9|-5|0xf1f0ee,9|-8|0xb1afa5,10|-12|0xffffff,10|-15|0xc5806e,10|-21|0xdceac0,20|-25|0xffc9be,21|-20|0xffcbc0,20|-16|0xce8d7e,16|-16|0xc67967", 75, 98,75,959,478, 0, 0)
		x, y = findMultiColorInRegionFuzzy(0xffc9be,"2|9|0xb5bdb3,10|13|0xffffff,15|16|0x706e59,21|17|0x6e6a57,15|20|0xffffff,22|24|0xffffff,6|33|0xffbaab,2|32|0xffb7a7,0|29|0xffbeaf", 95, 98, 75, 959, 478, 0, 0)
		if x > -1 then
			
			toast("找到面右邊RUB#x"..tostring(x)..",y"..tostring(y))
			sysLog("找到面右邊RUB#x"..tostring(x)..",y"..tostring(y))
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y)  
			
			mSleep(2000)
			
			
			return true
		else
			sysLog("沒有面右邊的RUBI")
		end
		
		mSleep(10)
		k = k+1
		
	until k==70
	
	toast ("Rubi掃描結束")
	
end

function mrestaurant.FindKingMeal()
	
	toast("霸王餐偵測")
	hit_bad_guy = 1;
	--scan for bad guy	
	
	local i = 1
	repeat 
		--黑色
		x, y = findMultiColorInRegionFuzzy(0x382a26,"5|2|0x392a26,11|1|0x3c2b26,15|1|0x3e2b26,2|6|0x362926,5|6|0x372a26,8|6|0x382a26,11|6|0x392a26", 95, 97,28,836,462, 0, 0)
		
		--x, y = findMultiColorInRegionFuzzy(0x3c2a26,"-6|-7|0x382722,-5|-6|0x3c2b26,0|-10|0xffffff,2|-13|0x583d37,2|-13|0x583d37,-9|-18|0x9e598c,-15|-17|0x402a2d,-6|-18|0x4d2c32,-13|-17|0x653052,-11|-17|0xffdfff,-10|-16|0xffe2ff,-9|-15|0x874573,-11|-15|0xc383b6,-19|-13|0x372a26,3|0|0x3d2b26,7|-14|0x462620,4|-21|0x742f52,-9|-20|0x572d3f,-12|-19|0x622f4e", 65, 1, 0, 958, 543, 0, 0)
		if x > -1 then
			sysLog("Find bad gay!"..x.." "..y)
			touchDown(1, x, y+70)
			mSleep(50)
			touchUp(1, x, y+70)
			mSleep(3000)
			if hit_bad_guy == 1 then	
				--偵測教訓她btn
				x, y = findMultiColorInRegionFuzzy(0xe40001,"3|-3|0xe10002,9|1|0xe10002,17|-2|0xe10002", 95, 862, 489, 940, 529, 0, 0)
				if x > -1 then		
					toast("打霸王餐,教訓她")
					touchDown(1, x, y)
					mSleep(68)
					touchUp(1, x, y)
					mSleep(2500)
					--叉子
					x, y = findMultiColorInRegionFuzzy(0xffd3a8,"4|4|0xffd4a9,16|-10|0xffffff,22|-14|0xffffff,48|-4|0xffffff", 95, 669, 318, 775, 422, 0, 0)
					--x, y = findMultiColorInRegionFuzzy(0xfffdf8,"0|6|0xfffdf8,2|17|0xfffefb,-7|0|0xffd3a7,-8|8|0xffd3a7,-8|14|0xffd3a8", 95, 670, 329, 769, 413, 0, 0)
					if x > -1 then
						-- 戰鬥
						touchDown(1, 715, 363)
						mSleep(72)
						touchUp(1, 715, 363)
						--
						--偵測至戰鬥結束
						if Battle.run(30) then
							 return true
						else
							 return false
						end
					else
						toast("教訓霸王餐，錯誤異常")
					end
				else
					toast("點不到霸王餐")					
				end			
				
				
			else
				sysLog("求救")
				touchDown(1, 781, 492)
				mSleep(80)
				touchUp(1, 781, 492)
			end
			break
		else
			sysLog("沒找到霸王餐")
		end
		i = i+1 
		mSleep(100)
	until i == 5
	mSleep(3000)
	return false
end



--[[
function mrestaurant.exitVetory()
	--打贏霸王餐後離開
	mSleep(1000)
	touchDown(1, 645, 392)
	mSleep(50)
	touchUp(1, 645, 392)
	
	
end
]]

function mrestaurant.waitforHarvest()
	--等待營收
	mSleep(5000)
	-- enter Restaurent
	touchDown(1, 776, 417)
	mSleep(50)
	touchUp(1, 776, 417) 
	sysLog("確認營收")
	mSleep(2000) -- wating for check harvest
end

function mrestaurant.moveIceFieldOrMedicine(mtype)
	
	
	if mtype == Common.Restaurant.COOKER then
		x1,y1,x2,y2 = 84,94,478,324
		
	end
	if mtype == Common.Restaurant.WAITER then
		--範圍是2號3號服務員
		x1,y1,x2,y2 = 1,161,97,354--4 , 163, 110, 537
		
	end
	x , y = mrestaurant.detectGhost(x1,y1,x2,y2)
	if x>-1 then
		sysLog("偵測吐魂")
		toast("偵測吐魂！");	
		mSleep(1000)
		--點擊魂魄
		--sysLog(x..","..y)
		touchDown(1, x-5, y+70)
		mSleep(50)
		touchUp(1, x-5, y+70)
		mSleep(1500)
		--確認點選該位食靈
		x_f, y_f = findMultiColorInRegionFuzzy(0xdbe6ff,"10|10|0xe0ebff,32|10|0xe4eeff,42|7|0xc7ceff", 95, 557, 466, 641, 521, 0, 0)
		if x_f > -1 then			
			sysLog("Cooker_R"..tostring(Common.config.Cooker_R).."")
			--廚師
			if (x > 275 and  x1 == 84) then
				if Common.config.Cooker_R == 1 then
					sysLog("Cooker_R"..tostring(Common.config.Cooker_R).."")
					toast("廚師RIGHT 喝水")
					local _umf = mrestaurant.UseMedicine()
					if _umf then
						return x,y
					end
				end
			elseif (x1== 1) then
				--位置三
				if (y>250) then
					if Common.config.Waiter_3 == 1 then
						toast("服務員3 喝水")
						sysLog("服務員3 喝水")
						local _umf = mrestaurant.UseMedicine()
						if _umf then
							return x,y
						end
					else
						
					end
				else
					--位置二
					if Common.config.Waiter_2 == 1 then
						sysLog("服務員2 喝水")
						local _umf = mrestaurant.UseMedicine()
						if _umf then
							return x,y
						end
					end
				end
			end
			
			
			
			
			--擊入冰場
			touchDown(1, 600, 500)
			mSleep(50)
			touchUp(1, 600, 500)			
			mSleep(2000)
			--擊入確認冰場是否已滿
			x_ice, y_ice = findMultiColorInRegionFuzzy(0xdfeaff,"-2|0|0xdee7ff,3|11|0xd3deff,10|17|0xd7e3ff", 95, 562, 459, 635, 535, 0, 0)
			if x_ice > -1 then
				toast("冰場已滿")
				sysLog("冰場已滿")
				Common.Restaurant.ForceRemoveNumber = Common.Restaurant.ForceRemoveNumber + 1
				-- 各種離開
				touchDown(1, 80, 40)
				mSleep(50)
				touchUp(1, 80, 40) 			
				mSleep(2000)
			end		
		end
		
		
	end
	
	
	return x,y
end

function mrestaurant.UseMedicine()
	-- 餵食
	touchDown(1, 835, 500)
	mSleep(math.random(1000)+DelayClick)
	touchUp(1, 835, 500)	
	mSleep(2000)
	--100%藥劑
	x, y = findMultiColorInRegionFuzzy(0x8676e7,"5|2|0x8c86e9,4|8|0x9fa2ee,17|11|0xd1e2f8,17|2|0xadc6f0", 95, 823, 348, 905, 430, 0, 0)
	if x > -1 then
		touchDown(1, x, y)
		mSleep(math.random(300)+50)
		touchUp(1, x, y)	
		mSleep(2000)
	end
	
	--研究 -- 去完成
	x, y = findMultiColorInRegionFuzzy(0xffc056,"-3|15|0xffb554", 95, 546, 245, 633, 279, 0, 0)
	if x > -1 then	
		toast("無藍水，改使用綠水")
		touchDown(1, 800, 70)
		mSleep(math.random(300)+50)
		touchUp(1, 800, 70)
		mSleep(2000)
		-- 餵食
		touchDown(1, 835, 500)
		mSleep(math.random(300)+50)
		touchUp(1, 835, 500)	
		mSleep(2000)
		
		--找綠水
		local x_g, y_g = findMultiColorInRegionFuzzy(0x68d584,"9|5|0x9fe39a,5|14|0xacebaf", 95, 720, 352, 801, 425, 0, 0)
		if x_g > -1 then			
			local k=0
			repeat
				touchDown(1, x_g, y_g)
				mSleep(math.random(300)+50)
				touchUp(1, x_g, y_g)
				mSleep(1000)
				--研究 -- 去完成
				x, y = findMultiColorInRegionFuzzy(0xffc056,"-3|15|0xffb554", 95, 546, 245, 633, 279, 0, 0)
				if x > -1 then
					toast("沒水想還想拚排名????????")
					touchDown(1, 800, 70)
					mSleep(math.random(300)+50)
					touchUp(1, 800, 70)
					mSleep(2000)
					return false
				end		
				k=k+1
			until k==3
		end
	else
		toast("已服用藍水，請繼續賣肝")
	end
	
	
	touchDown(1, 800, 70)
	mSleep(math.random(300)+50)
	touchUp(1, 800, 70)
	mSleep(2000)
	return true
end


function mrestaurant.clickMake()

	local i=0
	repeat
		i = i+1
		mSleep(2000)
		x, y = findMultiColorInRegionFuzzy(0xffbe56,"1|7|0xffb84f,1|9|0xffb652,3|14|0xffb556,2|17|0xffb456", 95, 355, 457, 468, 497, 0, 0)
		if x > -1 then		
			toast("製作")					
			randomTap(x, y)
			
			return	
		end
	until i == 3
	toast("製作失敗，可能無廚師")
end

function mrestaurant.openStove(type)
	if type == Common.Restaurant.RIGHT then
		mSleep(math.random(1000)+DelayClick)
		toast("RIGHT開爐!")
		randomTap(400, 350)
		--[[touchDown(1, 400, 350)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 400, 350)]]
	elseif type == Common.Restaurant.LEFT then 
		mSleep(math.random(1000)+DelayClick)
		toast("LEFT開爐!")
		randomTap(150, 350)
		--[[touchDown(1, 150, 350)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 150, 350)]]
	end
	mSleep(1500)
end


function mrestaurant.clickDish(pos)
	
	
	gap_x = tonumber(pos) % 3 - 1;
	gap_y = math.floor( (tonumber(pos)-1) / 3 ); --(0~2)
	if gap_x == -1 then
		gap_x = 2
	end
	x = 600 + 150*gap_x
	y = 150 + 150*gap_y
	
	if tonumber(pos) >= 10 or tonumber(pos) <=0  then
		toast("菜餚位置 錯誤!!")
	else		
		mSleep(math.random(1000)+DelayClick)
		toast("我要第"..tostring(pos).."道菜!")
		randomTap(x, y)
		--[[touchDown(1, x, y)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, x, y)	]]
	end
end

function mrestaurant.detectCook(ptype)
	--偵測爐上鍋子
	mSleep(2000)
	if ptype == Common.Restaurant.RIGHT then
		x, y = findMultiColorInRegionFuzzy(0xbab9b8,"2|14|0xaba7a1,13|6|0xbbbaba,14|15|0xb0afaf,23|4|0xc6c6c6,24|14|0xbbbaba", 95, 303, 298, 491, 390, 0, 0)
		if x > -1 then
			toast("RIGHT 在忙")
		else
			return true
		end
	elseif  ptype == Common.Restaurant.LEFT then
		x, y = findMultiColorInRegionFuzzy(0xbab9b8,"2|14|0xaba7a1,13|6|0xbbbaba,14|15|0xb0afaf,23|4|0xc6c6c6,24|14|0xbbbaba", 95, 81, 294, 238, 400, 0, 0)
		if x > -1 then
			toast("LEFT 在忙")
		else
			return true
		end
	end
	return false
end

function mrestaurant.detectGhost(x1,y1,x2,y2)
	
	mSleep(100)--25, 5, 956, 449
	x, y = findMultiColorInRegionFuzzy(0xffffff,"0|1|0xffffff,0|3|0xffffff,0|7|0xffffff,0|18|0x553d35,-5|12|0x553d35,-9|10|0x553d35,-13|8|0x553d35,-16|6|0x553d35,-20|3|0x553d35,-25|0|0x553d35,-28|-3|0x553d35", 95, x1,y1,x2,y2, 0, 0)
	
	return x,y
	
end

function mrestaurant.hireEnter()
	--點選雇員	
	mSleep(1000)
	touchDown(1, 700, 500)
	mSleep(50)
	touchUp(1, 700, 500)
end

function mrestaurant.detectEmpty()
	--偵測十字記號
	mSleep(5000)
	x, y = findMultiColorInRegionFuzzy(0x946961,"0|12|0x946961,0|22|0x946961,21|22|0x946961,19|12|0x946961,20|-2|0x946961,20|-4|0x946961", 95, 361, 92, 911, 464, 0, 0)
	
	return x,y
end

function mrestaurant.emplyeeSelect(type)
	
	mSleep(500)	
	--第六位置550,190,650,290	
	local i = 0 
	
	count = 0
	if type == Common.Restaurant.WAITER then			
		x1 = 400 
		y1 = 150
	elseif type == Common.Restaurant.COOKER then
		x1 = 400 
		y1 = 350
	end
	
	repeat		
		x_a = x1 + i*100
		y_a = y1
		--第11位子 400 350
		mSleep(2000)
		touchDown(1, x_a, y_a)
		mSleep(50)
		touchUp(1, x_a, y_a)
		
		mSleep(3000)
		
		--替換/雇用
		mSleep(500)
		touchDown(1, 200, 475)
		mSleep(50)
		touchUp(1, 200, 475)
		
		--如果沒有成功替換
		mSleep(700)
		x, y = findMultiColorInRegionFuzzy(0xfbe7c6,"0|5|0xfbe4c2,0|14|0xfbddb8,0|15|0xfbdcb8", 95, 377, 300, 469, 344, 0, 0)
		if x > -1 then
			--點選取消		
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y)
			toast("還沒恢復好，取消替換")			
		else					
			x, y = findMultiColorInRegionFuzzy(0xffbe56,"1|7|0xffb84f,1|9|0xffb652,3|14|0xffb556,2|17|0xffb456", 95, 156,454,247,491, 0, 0)
			if x > -1 then		
				toast("更換失敗，已經在工作")		
			else
				toast("更換成功")	
				break
			end		
			
		end		
		i=i+1
		
		if i==5 then
			--如果第二次還要換第二排，表示無人可用
			if y1 == 250 then
				return -2,-2
			end
			y1 = 250
			toast("換第二排")
			i=0							
		end
		
		count = count+1;
		
		if count == 20 then
			toast("沒人了")
			return -2,-2
		end
		
		
	until i==5
	
	
	
	
	return x,y
end



function mrestaurant.cookEnter()
	--點選備菜	
	mSleep(1000)
	touchDown(1, 600, 500)
	mSleep(50)
	touchUp(1, 600, 500)
	mSleep(1500)
end

function mrestaurant.checkWaiterDie()
	toast("服務生魂魄偵測")
	local i=0;
	repeat
		mSleep(500)
		i = i+1
		--偵測N次 服務生死亡並移入冰場
		x,y = mrestaurant.moveIceFieldOrMedicine(Common.Restaurant.WAITER)
		if(x==-1) then
			sysLog("服務生 Nothing")
		end
	until i==3
	sysLog("checkWaiterDie Done")
	
end

function mrestaurant.checkCookerDie()
	--偵測備菜頁面，廚師死亡與否
	toast("廚師魂魄偵測")
	mrestaurant.cookEnter()	
	local i=0;
	repeat
		i = i+1
		--偵測N次 廚師死亡並移入冰場
		x,y = mrestaurant.moveIceFieldOrMedicine(Common.Restaurant.COOKER)
		
		if x>270 then 
			toast("RIGHT 廚師死亡")
		elseif x==-1 then
			sysLog("廚師 Nothing")
		else
			toast("LEFT 廚師死亡")
		end
		mSleep(500)
	until i==4
	
	
	--離開備菜
	mrestaurant.exit()	
	
end

local DishSwitch = {
	[Common.Restaurant.ALLDISH] = function()    -- for case 1
		randomTap(630, 110)
		--[[touchDown(1, 630, 110)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 630, 110)	]]	
		toast("全部 0")
	end,
	[Common.Restaurant.GREELOW] = function()    -- for case 2
		randomTap(630, 160)
		--[[touchDown(1, 630, 160)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 630, 160)	]]
		toast("格瑞洛 1")
	end,
	[Common.Restaurant.YAO] = function()    -- for case 3
		randomTap(630, 200)
		--[[touchDown(1, 630, 200)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 630, 200)]]	
		toast("耀 2")
	end	
	,
	[Common.Restaurant.SAKURA] = function()    -- for case 4
		randomTap(630, 250)
		--[[touchDown(1, 630, 250)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 630, 250)	]]
		toast("櫻之島 3")
	end
	,
	[Common.Restaurant.USHINAWA] = function()    -- for case 5
		randomTap(630, 300)
		--[[touchDown(1, 630, 300)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, 630, 300)	]]
		toast("失落 4")
	end
}


function mrestaurant.selectDish(mDishType)
	mSleep(500)
	x_a, y_a = findMultiColorInRegionFuzzy(0xab6e4e,"12|0|0xab6e4e,29|0|0xab6e4e,52|-2|0xab6e4e", 95, 582, 43, 672, 76, 0, 0)
	toast("選擇菜系"..tostring(mDishType))
	sysLog("選擇菜系"..tostring(mDishType))
	if x_a > -1 then
		randomTap(x_a, y_a)
		--[[
		touchDown(1, x_a, y_a)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, x_a, y_a)]]
		mSleep(math.random(1000)+DelayClick)
		local f = DishSwitch[mDishType]
		if (f) then
			f()
		else
			toast("選擇菜系error , default ALL")
			f = DishSwitch[Common.Restaurant.ALLDISH]
			f()
		end
	end
	mSleep(math.random(1000)+DelayClick)
	x, y = findMultiColorInRegionFuzzy(0xffebc9,"19|-1|0xffebc9,44|-1|0xffebc9,74|-1|0xffebc9,95|-5|0xffebc9", 95, 541, 87, 708, 311, 0, 0)
	
	if x > -1 then
		--未解鎖
		toast("未解鎖菜系，使用預設菜系")
		randomTap(x_a, y_a)
		--[[touchDown(1, x_a, y_a)
		mSleep(math.random(1000)+DelayClick)
		touchUp(1, x_a, y_a)
		mSleep(math.random(1000)+DelayClick)]]
	else
		sysLog("菜系選擇成功")
	end
	mSleep(500)
end

function mrestaurant.runCookTask()
	
	mrestaurant.cookEnter()	
	
	COOKER_POS = Common.Restaurant.LEFT		
	mrestaurant.cookDish(COOKER_POS)	
	
	COOKER_POS = Common.Restaurant.RIGHT	
	mrestaurant.cookDish(COOKER_POS)
	
	mSleep(math.random(500)+500)
	--離開備菜
	mrestaurant.exit()
end

function mrestaurant.cookDish(COOKER_POS)
	--偵測有無鍋子
	f = mrestaurant.detectCook(COOKER_POS)
	
	if f then
		mrestaurant.openStove(COOKER_POS)
		mrestaurant.selectDish(tonumber(Common.config.DishType))
		mrestaurant.clickDish(tonumber(Common.config.DishPos))
		mrestaurant.clickMake()		
	end
end

function mrestaurant.hireJob()
	--進入雇員
	mrestaurant.hireEnter()
	--偵測位子
	local i=0
	while(true)
	do	
		mSleep(1000)
		x,y = mrestaurant.detectEmpty()	
		if x>-1 then 
			if y<300 then
				toast("廚師空,x,y:"..tostring(x)..","..tostring(y))
				-- 600,250 第八位置
				--點選進入食靈之家	
				mSleep(500)
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y)
				p,q = mrestaurant.emplyeeSelect(Common.Restaurant.COOKER)
				if p==-2 then
					--無人可用
					break
				end
			else
				toast("服務生空,x,y:"..tostring(x)..","..tostring(y))
				-- 600,250 第八位置
				--點選進入食靈之家	
				mSleep(500)
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y)
				p,q = mrestaurant.emplyeeSelect(Common.Restaurant.WAITER)
				if p==-2 then		
					--無人可用		
					break
				end
			end
		else
			toast("人員全滿")
			mSleep(1000)
			break
		end
		i=i+1
		--防呆
		if i>=8 then
			break
		end
	end
	mSleep(1000)
	mrestaurant.exit()
	
end

function mrestaurant.run()
	
	
	Common.Restaurant.ForceRemoveNumber = 0
	--
	mrestaurant.waitforHarvest()
	mrestaurant.FindKingMeal()		
	--
	mrestaurant.waitforHarvest()
	mrestaurant.checkCookerDie()
	mrestaurant.checkWaiterDie()
	mrestaurant.hireJob()		
	mrestaurant.runCookTask()

	--	
end

function randomTap(x, y)
  local touchid = math.random(0,9)  
  local ran = 5
  local _x = math.random(0-ran,ran) +x
  local _y = math.random(0-ran,ran) +y
  
  touchDown(touchid, _x, _y);
  --[[
  if _G["visibleTap"] == "0" then 
    id = createHUD()     --创建一个HUD
    if x-12 <1135 and   x-12>0 then
      
      showHUD(id,"",12,"0x00ff0000","finger.png",0,x-2,y,40,48)     --变更显示的HUD内容
    end
    mSleep(math.random(100,200))
    hideHUD(id)     --隐藏HUD
  else
    mSleep(math.random(100,200))
  end]]
  mSleep(math.random(100,200))
  touchUp(touchid, _x, _y);
end

return mrestaurant

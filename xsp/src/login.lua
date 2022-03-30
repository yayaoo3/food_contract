local mlogin = {};
local GI = require("gameinterface")
--遊戲公告
function mlogin.CloseGameAnnouncement()
	local i=0
	repeat 
		i = i+1
		x, y = findMultiColorInRegionFuzzy(0xffb183,"19|2|0xffad7f,10|-8|0xffb680,8|11|0xffa783", 95, 842, 43, 877, 77, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y)
			toast("關閉遊戲公告")
			break
		end
		mSleep(300)
	until i>=15
end

--遊戲資源更新公告
function mlogin.checkUpdate()
	mSleep(1000)
	i=0
	repeat 
		i = i+1
		x, y = findMultiColorInRegionFuzzy(0xffb150,"6|-1|0xffb04d,19|0|0xffb14f,33|-2|0xffb24e,43|0|0xffb354", 95, 437, 445, 524, 482, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y)
			toast("有更新包")		
			
			--預測載入時間20秒可能可以完成
			sysLog("有更新包點擊，等30秒")
			toast("有更新包點擊，等30秒")
			mSleep(30000)
			return	true
		end
		mSleep(1000)
	until i==3
	sysLog("無更新包")
	return false
end

function mlogin.enter()
	mSleep(500)
	local i=0
	repeat 
		i = i+1	
		--判斷更新資源
		f = mlogin.checkUpdate()	
		if f then
			--重開遊戲
			toast("更新")
			return false 
		else
			--判斷食之契約的字眼出現
			x, y = findMultiColorInRegionFuzzy(0x541c0a,"0|4|0x531c0a,0|9|0x521c09,0|15|0x511c09,1|33|0x64260f", 95, 288, 111, 645, 276, 0, 0)
			if x > -1 then	
				mSleep(1500)
				touchDown(1, 450, 450)
				mSleep(50)
				touchUp(1, 450, 450)
				sysLog("點擊進入遊戲,i="..tostring(i))
				mSleep(8000)
				return true		
			end
		end
		
		mSleep(500)
		toast("遊戲載入中.."..tostring(i).."/5")
	until i==5
	toast("登入逾時")
	return false
end

--偵測每日登入的新一天
function mlogin.checkNews()
	mSleep(2000)
	--今日不在顯示
	x, y = findMultiColorInRegionFuzzy(0x98755b,"-4|6|0x98755b,-2|9|0x98755b,8|12|0x98755b,12|4|0x98755b,5|11|0x98755b", 95, 37, 483, 76, 518, 0, 0)
	if x > -1 then	
		touchDown(1, 50, 500)
		mSleep(50)
		touchUp(1, 50, 500)
		toast("新的一天，點擊不再顯示")
		return true
	end
	return false
end
--滑動公告信息
function mlogin.slideNews()
	
	while(true)
	do
		mSleep(2000)
		touchDown(1, 920, 520)
		mSleep(50)
		touchUp(1, 920, 520)
		
		--滑動後確認打勾的框框是否消失
		x, y = findMultiColorInRegionFuzzy(0xf06906,"2|2|0xf06906,5|2|0xf06906,7|-1|0xf06906,9|-3|0xf06906", 95, 43, 486, 70, 515, 0, 0)
		if x > -1 then	
			toast("繼續滑動")
		else
			toast("主畫面")
			mSleep(1000)
			break
		end
	end
end

--簽道獎勵
function mlogin.exitSignGet()
	mSleep(5000)
	x, y = findMultiColorInRegionFuzzy(0x413940,"11|5|0x453b42,27|11|0x463c43,43|20|0x473c42,57|27|0x453a41", 95, 769, 323, 935, 489, 0, 0)
	if x > -1 then
		touchDown(1, 772, 486)
		mSleep(50)
		touchUp(1, 772, 486)
		
		mSleep(3000)
		touchDown(1, 40, 40)
		mSleep(50)
		touchUp(1, 40, 40)
	end
	sysLog("無每日獎勵")
	mSleep(3000)
	
end

function mlogin.DetectAnswerQ()
	mSleep(2000)
	x, y = findMultiColorInRegionFuzzy(0x9b6a42,"50|0|0x9f6c42,143|-1|0xa16f45,394|-1|0xa16e43,464|-1|0x9d6c43,527|-1|0xa06e44,11|49|0xebe0d8,18|126|0xe8ddd5,-4|237|0xe3d6ce,-8|374|0xe0cfc3,-23|413|0xb8aaa3,508|405|0xe0d2c9,485|299|0xe5dad2,481|209|0xe7ddd6,483|126|0xe9ded7,479|52|0xebe0d8", 95, 152, 52, 801, 510, 0, 0)
	if x > -1 then
		toast("又來?")
		sysLog("又來?")
		mlogin.Restart()
	end
end

function mlogin.Relogin()
	
	local _ohpf = GI.OnHomePage()
	if _ohpf then		
		touchDown(1, 40, 40)
		mSleep(50)
		touchUp(1, 40, 40)
		mSleep(1000)
		
		--個人設置
		x, y = findMultiColorInRegionFuzzy(0xead8ca,"9|4|0xead8ca,21|2|0xead8ca", 95, 850, 188, 935, 220, 0, 0)
		if x > -1 then
			touchDown(1, x, y)
			mSleep(50)
			touchUp(1, x, y)
			mSleep(1000)
			
			--重新登入Btn
			x, y = findMultiColorInRegionFuzzy(0xffc152,"13|0|0xffc252,36|0|0xffc355", 95, 547, 443, 632, 479, 0, 0)
			if x > -1 then
				touchDown(1, x, y)
				mSleep(50)
				touchUp(1, x, y)
				mSleep(1000)
				--確定__重新登入Btn
				x, y = findMultiColorInRegionFuzzy(0xffc152,"13|0|0xffc252,36|0|0xffc355", 95, 495, 325, 579, 360, 0, 0)
				if x > -1 then
					touchDown(1, x, y)
					mSleep(50)
					touchUp(1, x, y)
					mSleep(1000)					
					return mlogin.run()
				end
			end			
		end		
	end
	toast("重登失敗，強制重開。")
	closeApp("com.efun.twszqy");
	sysLog("Relogin 關閉遊戲")
end

function mlogin.Restart()
	closeApp("com.efun.twszqy");
	sysLog("Restart 重開遊戲")
	mSleep(8000)	
	
	local Runnungflag = appIsRunning("com.efun.twszqy"); 
	sysLog("Runnungflag:"..tostring(Runnungflag))
	if Runnungflag == 0 then 			
		r = runApp("com.efun.twszqy"); 
		mSleep(10 * 1000);  --等待程序响应
		sysLog("r="..tostring(r))
		if r ~= 0 then
			closeApp("com.efun.twszqy");
			sysLog("關閉遊戲")
			toast("启动应用失败");
		else
			sysLog("開啟遊戲")
			update_f = mlogin.run()
		end
	else
		toast("应用已經啟動，請確保起初在主介面");
		mSleep(1300)
	end
	
end

function mlogin.run()
	mSleep(1500)
	
	mlogin.CloseGameAnnouncement()
	
	f = mlogin.enter()	
	if f == false then
		--時間過久，登入失敗，重開
		--遊戲包更新，重開
		return true
	end
	
	
	f = mlogin.checkNews()
	if f then
		mlogin.slideNews()
		
	end
	
	mlogin.exitSignGet()
	
	return false
end

return mlogin
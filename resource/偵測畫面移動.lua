ColorCheck = {}


function ColorCheck:new_ColorCheckSystem(rigion,point_tab,n,p)
	local o = {};
	setmetatable(o,self); self.__index = self;
	
	local function get_ColorCheckF(rigion,point_tab,n,p)
		local p = p or 1
		local n = n or 5
		local tab = {}
		local point_tab = point_tab
		if not point_tab then
			local x1,y1,x2,y2 = rigion[1][1], rigion[1][2],rigion[2][1], rigion[2][2]
			point_tab = {}
			local math_random = math.random
			for i = 1, n do
				table.insert(point_tab,{math_random(x1,x2),math_random(y1,y2)})
			end
		end
		for k, v in ipairs(point_tab) do
			local x, y = point_tab[k][1], point_tab[k][2]
			table.insert(tab,{x-p,y-p,x+p,y+p,getColor(x,y)})
		end
		action = function()
			keepScreen(true) 
			for i = 1,#tab do 
				local x,y = findColorInRegionFuzzy(tab[i][5],90,tab[i][1],tab[i][2],tab[i][3],tab[i][4]) 
				if x == -1 then keepScreen(false) return false end 
			end; keepScreen(false)
			return true
		end
		return action
	end
	
	o.ColorCheckF = get_ColorCheckF(rigion,point_tab,n,p)
	o.re_check = function() return get_ColorCheckF(rigion,point_tab,n,p) end
	
	function o:DelayCheck(t)
		if not self.reTime then self.reTime = os.time() end
		local t0 = os.time() - self.reTime
		if t0 > t then
			self.reTime = os.time()
			return true
		end
	end

	function o:ColorCheck_TF()
		local ColorCheckF = self.ColorCheckF
		if ColorCheckF() then 
			return true
		else 
			self.ColorCheckF = self.re_check()
			return false
		end
	end
	local o_ = {}
	setmetatable(o_,o); o.__index = o;
	return o_;
end

init("0",0)

local s = ColorCheck:new_ColorCheckSystem({{1,1},{640,960}},nil,10)
while (true) do
	if s:ColorCheck_TF() then toast("无变化") else toast("有变化") end
	mSleep(1000)
end


	
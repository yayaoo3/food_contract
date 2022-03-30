init("0", 1); --以当前应用 Home 键在右边初始化
snapshot('[public]post.png',459,371,1468,786,0.9);
local http = require("G_libs.socket.http")
local ltn12 = require("G_libs.socket.ltn12")
--require "STR_BASE"
local math_random = math.random
local function get_ran_key()
	math.randomseed(os.time())
	return math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)
end
local url = ""
function SendFile(MyUserStr, GameID, FilePath, TimeOut)
		local MyUserStr = MyUserStr or 0
		--sysLog(MyUserStr)
		--do return false end
    GameID = GameID or 1001
    TimeOut = TimeOut or 120
    http.TIMEOUT = timeout
		local files
    local file = io.open(FilePath,"rb")
		sysLog(FilePath)
    if file then
        files = file:read("*a")
        file:close()
    end
    local response_body = {}
		local get_ran_key2=get_ran_key()
    local boundary = "---------------------------7de3a916a0ab0"
		
    local datatable = {
            "--"..boundary.."\n",
            'Content-Disposition: form-data; name="userStr"\n\n',
            MyUserStr,
            "\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="gameid"\n\n',
            GameID,
            "\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="timeout"\n\n',
            TimeOut,
            "\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="rebate"\n\n',
            "2529|2A8079AC9C86849E",
            "\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="daili"\n\n',
            "Haoi",
            "\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="kou"\n\n',
						"\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="beizhu"\n\n',
						"\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="ver"\n\n',
						"Web2",
						"\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="key"\n\n',
						get_ran_key2,
            "\n--"..boundary.."\n",
            'Content-Disposition: form-data; name="img"; filename="post.png"\n',
            'Content-Type: image/png\n\n',
            files,
            "\n--"..boundary.."--"
    }
    local data = table.concat(datatable)
		--local data = datatable
    --sysLog(data)
--	function get_haoai_url()--这里的获取 url 地址 不对   应该包括 端口号 还有就是需要随机选其中一个服务器
--		local res, code = http.request('http://2.haoi23.net/svlist.html')
--		if code == 200 then
--			local b = string.find(res,":")
--			return string.sub(res,4,b+4)
--		end
--	end
--	function get_haoai_url_host()--这里的获取 url 地址 不对   应该包括 端口号 还有就是需要随机选其中一个服务器
--		local res, code = http.request('http://2.haoi23.net/svlist.html')
--		if code == 200 then
--			local b = string.find(res,":")
--			return string.sub(res,4,b+4)
--		end
--	end
	
	  url,post_ = getHaoiHost()
--	url = get_haoai_url()
--	local post_ = get_haoai_url_host()
    local headers = {
        ["Accept"]= "*/*",
        ["Accept-Language"] = "zh-cn",
        ["Content-Type"] = "multipart/form-data; boundary=---------------------------7de3a916a0ab0",
        ["Host"] = post_ ,
        ["Content-Length"] = #data,
        ["Accept-Encoding"] = "gzip, deflate",
        ["User-Agent"] = "ben",
        ["Connection"] = "Keep-Alive",
        ["Expect"] = "100-continue"
    }
		
	local rep , code = http.request{
			url = "http://"..url.."/UploadAPI.aspx",
			method = "POST",
			headers = headers  ,
			source = ltn12.source.string(data),
			sink = ltn12.sink.table(response_body),
	}

	return response_body[1]
end

function GetAnswer (TID)--先把这里改改   host 是读取的url 里的 去掉冒号 后面的内容   你该我看着 
	local str = TID
	local str_ = "id="..str.."&r="..get_ran_key()
	local response_body = {}
	local headers = {
			["Accept"]= "*/*",
			["Accept-Language"] = "zh-cn",
			["Content-Type"] = "application/x-www-form-urlencoded",
			["Host"] = post_ ,
			["Content-Length"] = #str_,
			["Accept-Encoding"] = "gzip, deflate",
			["User-Agent"] = "ben",
			["Connection"] = "Keep-Alive",
			--["Expect"] = "100-continue"
	}
	
	local rep , code = http.request{
			url = "http://"..url.."/getanswer.aspx",
			method = "POST",
			headers = headers  ,
			source = ltn12.source.string(str_),
			
			sink = ltn12.sink.table(response_body),
	}
	return response_body[1]
end


  function getHaoiHost()
    -- 获取好爱Host
    local useUrl
    fwqurl = {
		  'http://0.haoi23.net/svlist.html',
      'http://1.haoi23.net/svlist.html',
      'http://2.haoi23.net/svlist.html',
      'http://3.haoi23.net/svlist.html',
      'http://4.haoi23.net/svlist.html'
    }
    local s=1
    for i=1,5 do
      local res, code = http.request(fwqurl[s])
			sysLog(""..code)
      if code == 200 then
        s=s+1
        local b = string.find(res,":")
        url = string.sub(res,4,b+4)
        post_ =  string.sub(res,4,b-1)
        h="haoi23"
        j=url,post_;
        sysLog("服务器")
        if string.find(j,h) ~= 0 then   --获取成功
          sysLog("获取到服务器地址")
          break
        end
      end
    end
    if code ~= 200 then   --获取失败
      url = 'sv13.haoi23.net:8009'
      post_ = 'sv13.haoi23.net'
    end
    return url,post_;
  end
 res = SendFile("64268637|PTXFY7B2257656E|b:图片放大0.55倍", "X5001", "[public]post.png", 29)
  sysLog("图片 !".."[public]post.png")
while true do
	mSleep(1000)
	sysLog('等待返回答案中')
local res = GetAnswer (res)--这个变量就是答案
      if res then  
      sysLog('返回结果为：'..res)
		  if res == "#编号不存在" then

			break 
			elseif res == "#超时" then

			break 
      elseif res == '1' then

        break 
      elseif res =='2' then

        break 
      elseif res =='3' then

        break 
      elseif res =='4' then

        break 
        
      else
        sysLog('zhaobudao') 
      end
			break 
    end
  end--找到老君

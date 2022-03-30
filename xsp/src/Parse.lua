local _M = {}


function _M.split(s, p)
	--注意，index從1開始
	local rt= {}
	string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
	return rt
end

return _M
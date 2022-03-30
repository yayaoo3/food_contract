local MarkSet = {}
MarkSet.init = function(self,results)
  print(results)
  _G["setting"] = results
end

return MarkSet
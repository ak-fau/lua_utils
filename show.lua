-- Lua utils:
--   show() function to pretty-print Lua data

local ok, rshow
ok, rshow = pcall(function() return require "rshow" end)
if not ok then
  rshow = function(v, i, p)
    if p then
      print(p .. ": " .. tostring(v))
    else
      print(tostring(v))
    end
  end
end

return function (...)
  local v = ...
  if v == nil then
    rshow(v)
  else
    local args = {}
    local max = 1
    for i,v in pairs{...} do
      args[i] = v
      if i>max then max=i end
    end
    if max == 1 then
      rshow(args[1])
    else
      for i=1,max do
        rshow(args[i], -1, "arg "..i)
      end
    end
  end
end

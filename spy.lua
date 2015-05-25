-- Lua utils:
--   wrap a function to print its arguments, return values
--   and CPU time used

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

return function (f, name)
  if type(f) ~= "function" then
    return
  end
  if type(name) ~= "string" then
    name = "<noname>"
  end

  return function(...)
     print()
     print("Function call '" .. name .. "'")
     local args = ...
     if args == nil then
       print "No arguments"
     else
       print "Arguments"
       local args = {}
       local max = 1
       for i,v in pairs{...} do
          args[i] = v
          if i>max then max=i end
       end
       if max == 1 then
          rshow(args[1], 0, "arg")
       else
          for i=1,max do
             rshow(args[i], 0, "arg "..i)
          end
       end
     end

     local start = os.clock()
     -- call target function and collect all its return values
     ret = {f(...)}
     local stop = os.clock()

     print "Results"
     local results = {}
     local max = 1
     for i,v in pairs(ret) do
        results[i] = v
        if i>max then max=i end
     end
     if max == 1 then
        rshow(results[1], 0)
     else
        for i=1,max do
           rshow(results[i], 0, "ret "..i)
        end
     end
     print()
     print("CPU time used: " .. stop - start)
     print()

     -- return everything as if f() has been called directly
     return table.unpack(ret)
  end
end

-- Lua init script
--
-- export LUA_INIT=@init.lua

print("Lua init script (" .. _VERSION .. ")")

for _,u in ipairs {
  "ansicolors",
  "show",
  "spy",
  "reload",
} do
  ok, util = pcall(function() return require(u) end)
  if ok then
    print("  " .. u .. " module is loaded")
    _G[u] = util
  else
    print("Can't load module \"" .. u .. "\":" .. util)
  end
end

ok, init = pcall(function() return dofile("./init.lua") end)
if ok then
  print("Local init file is loaded")
else
  print("No local init file.")
end

print()

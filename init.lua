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
  local ok, util
  ok, util = pcall(function() return require(u) end)
  if ok then
    print("  " .. u .. " module is loaded")
    _G[u] = util
  else
    print("Can't load module \"" .. u .. "\":" .. util)
  end
end

local ok, msg
ok, msg = pcall(function() return dofile("./init.lua") end)
if ok then
  print("Local init file is loaded")
  if msg then init = msg end
else
  print("Cannot load local init file:" .. msg)
end

print()

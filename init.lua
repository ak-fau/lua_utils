-- Lua init script
--
-- Copyright (c) 2015 Anton Kuzmin <anton.kuzmin@cs.fau.de>
--
-- This code is released under dual licenses:
--   MIT public license (same as Lua, MIT-LICENSE.txt)
-- and
--   Community Research and Academic Programming License
--   (CRAPL-LICENSE.txt)
--
-- To load it by default add the following lines to ~/.bashrc
-- (or similar shell initialization file):
--   export LUA_PATH="${HOME}/lua_utils/?.lua;;"
--   export LUA_INIT=@${HOME}/lua_utils/init.lua
--
-- ...and do not try to run Lua from lua_utils/ dir ;-)

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

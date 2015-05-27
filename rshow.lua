-- Lua utils:
--   rshow() -- helper function to recursively print Lua data
--
--   Based on the code by Tobias S\"ulzenbr\"uck and Christoph Beckmann
--   from Lua Programming Gems (ISBN 978-85-903798-4-3), pg. 29-32
--   http://www.lua.org/gems/
--
-- Copyright (c) 2015 Anton Kuzmin <anton.kuzmin@cs.fau.de>
--
-- This code is released under dual licenses:
--   MIT public license (same as Lua, MIT-LICENSE.txt)
-- and
--   Community Research and Academic Programming License
--   (CRAPL-LICENSE.txt)

local c

if ansicolors then
  local function repl(s)
    local colors = {
      key = "cyan",
      hex = "yellow",
      num = "red",
      type = "bright",
    }
    r = colors[s]
    if r then s = r end
    return "%{" .. s .. "}"
  end
  c = function(str)
    return ansicolors(string.gsub(str, "%%{(%a-)}", repl))
  end
else
  c = function(str)
    return string.gsub(str, "%%{%a-}", "")
  end
end

local MAX_DEPTH = 5
local MAX_STRING_LENGTH = 60

local function h32(n)
   return string.format("%08x", n)
end

local function rshow(v, depth, key)
  local _prefix = ""
  local _spaces = ""

  if key ~= nil then
    _prefix = "[" .. c("%{key}" .. tostring(key)) .. "] = "
  end

  if depth == nil then
    depth = 0
  else
    depth = depth + 1
    _spaces = string.rep("  ", depth)
  end

  if depth > MAX_DEPTH then
    print(_spaces .. _prefix .. "<MAX_DEPTH (" .. MAX_DEPTH .. ") is exceeded>")
  else

    if type(v) == 'table' then
      print(_spaces .. _prefix .. c("%{type}(table)"))

      local mt = getmetatable(v)
      if mt ~= nil then
        rshow(mt, depth, "_MT_")
      end

      for tk, tv in pairs(v) do
        rshow(tv, depth, tk)
      end

    elseif type(v) == 'function'
        or type(v) == 'thread'
        or type(v) == 'userdata'
        or      v  == nil
    then
      print(_spaces .. _prefix .. tostring(v))

    elseif type(v) == 'number' then
      if (v>=0) and (v<2^32) and (math.floor(v) == v) then
        print(_spaces .. _prefix .. c("%{type}(number) %{num}" ..
                                        tostring(v) .. "   %{hex}0x" .. h32(v)))
      else
        print(_spaces .. _prefix .. c("%{type}(number) %{num}" .. tostring(v)))
      end

    elseif type(v) == 'boolean' then
      print(_spaces .. _prefix .. "(boolean) " .. tostring(v))

    else -- string
      local len = #v
      if len > MAX_STRING_LENGTH then
        v = string.sub(v, 1, MAX_STRING_LENGTH-3) .. "..."
      end
      print(_spaces .. _prefix .. "(string) len = " .. len .. " '" .. v .. "'")
    end
  end
end

return rshow

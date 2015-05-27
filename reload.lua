-- Lua utils:
--  simple function to force reload of the package from a file
--  in an interactive session
--
-- Copyright (c) 2015 Anton Kuzmin <anton.kuzmin@cs.fau.de>
--
-- This code is released under dual licenses:
--   MIT public license (same as Lua, MIT-LICENSE.txt)
-- and
--   Community Research and Academic Programming License
--   (CRAPL-LICENSE.txt)

return function (pkg)
  package.loaded[pkg] = nil
  _G[pkg] = require(pkg)
  return _G[pkg]
end

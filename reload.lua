-- Lua utils:
--  simple function to force reload of the package from a file
--  in an interactive session

return function (pkg)
  package.loaded[pkg] = nil
  _G[pkg] = require(pkg)
  return _G[pkg]
end

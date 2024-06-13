-- -----------------------------------
-- -------- Filetypes
-- -----------------------------------
local markdown = require("Fau.plugins.filetypes.markdown")
local python = require("Fau.plugins.filetypes.python")


-- -----------------------------------
-- -------- Merge and Return
-- -----------------------------------
local function list_concatenate(...)
  local result = {}
  local pos = 1
  for i = 1, select('#', ...) do
    local t = select(i, ...)
    for j = 1, #t do result[pos] = t[j] pos = pos + 1 end
  end
  return result
end


local filetypes = list_concatenate(markdown, python)
return filetypes

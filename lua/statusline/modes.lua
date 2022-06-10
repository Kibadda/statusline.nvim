local M = {}

M.modes = setmetatable({
  n = "NORMAL",
  v = "VISUAL",
  V = "V-LINE",
  [""] = "V-BLOCk",
  i = "INSERT",
  R = "REPLACE",
  c = "COMMAND",
  t = "TERM",
}, {
  __index = function()
    return "DEFAULT"
  end,
})

M.mode_highlights = setmetatable({
  n = "StatusLineNormal",
  v = "StatusLineVisual",
  V = "StatusLineVisual",
  [""] = "StatusLineVisual",
  i = "StatusLineInsert",
  R = "StatusLineReplace",
  c = "StatusLineCommand",
  t = "StatusLineTerm",
}, {
  __index = function()
    return "StatusLineDefault"
  end,
})

return M

local M = {}

M.modes = {
  n = "NORMAL",
  v = "VISUAL",
  V = "V-LINE",
  [""] = "V-BLOCk",
  i = "INSERT",
  R = "REPLACE",
  c = "COMMAND",
  t = "TERM",
}

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
    return "StatusLineNormal"
  end,
})

return M

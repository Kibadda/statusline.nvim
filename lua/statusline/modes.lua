local M = {}

M.modes = {
  n = "NORMAL",
  v = "VISUAL",
  V = "V-LINE",
  [""] = "V-BLOCk",
  i = "SELECT",
  R = "REPLACE",
  c = "COMMAND",
  t = "TERM",
}

M.mode_highlights = {
  n = "ElNormal",
  v = "ElVisual",
  V = "ElVisualLine",
  [""] = "ElVisualBlock",
  i = "ElInsert",
  R = "ElReplace",
  c = "ElCommand",
  t = "ElTerm",
}

return M

local sections = require "statusline.sections"
local M = {}

function M.setup(opts)
  opts = opts or {}
  opts = vim.tbl_deep_extend("keep", opts, {
    sections = {
      sections.mode,
      sections.git_branch,
      sections.git_changes,
      sections.filler,
      sections.file,
      sections.filler,
      sections.position,
      sections.percentage,
      sections.filetype,
    },
    highlights = {
      command = {
        name = "StatusLineCommand",
        bg = "#262626",
        fg = "#c0c0c0",
      },
      git = {
        name = "StatusLineGit",
        bg = "#3a3a3a",
        fg = "#99cc99",
      },
      filler = {
        name = "StatusLineFiller",
        bg = "#3a3a3a",
        fg = "#99cc99",
      },
      file = {
        name = "StatusLineFile",
        bg = "#3a3a3a",
        fg = "#99cc99",
      },
      position = {
        name = "StatusLinePosition",
        bg = "#3a3a3a",
        fg = "#99cc99",
      },
      percentage = {
        name = "StatusLinePercentage",
        bg = "#3a3a3a",
        fg = "#99cc99",
      },
      filetype = {
        name = "StatusLineFiletype",
        bg = "#3a3a3a",
        fg = "#99cc99",
      },
    },
  })

  M.sections = opts.sections

  M.highlights = opts.highlights
  M.set_highlights()

  vim.opt.statusline = [[%!luaeval('require("statusline").render_statusline()')]]
end

function M.render_statusline()
  local statusline_string = ""

  for _, section in ipairs(M.sections) do
    statusline_string = statusline_string .. section()
  end

  return statusline_string
end

local function set_highlight(group)
  vim.cmd("hi " .. group.name .. " guibg=" .. group.bg .. " guifg=" .. group.fg)
end

function M.set_highlights()
  local group = vim.api.nvim_create_augroup("StatusLineHighlightGroup", { clear = true })
  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
      set_highlight(M.highlights.command)
      set_highlight(M.highlights.git)
      set_highlight(M.highlights.filler)
      set_highlight(M.highlights.file)
      set_highlight(M.highlights.position)
      set_highlight(M.highlights.percentage)
      set_highlight(M.highlights.filetype)

      set_highlight { name = "StatusLineNormal", bg = "#bb2233", fg = "#bbbbbb" }
      set_highlight { name = "StatusLineInsert", bg = "#3322cc", fg = "#bbbbbb" }
      set_highlight { name = "StatusLineVisual", bg = "#22cc33", fg = "#333333" }
      set_highlight { name = "StatusLineCommand", bg = "#cccc22", fg = "#333333" }
      set_highlight { name = "StatusLineTerm", bg = "#aa22aa", fg = "#bbbbbb" }
      set_highlight { name = "StatusLineReplace", bg = "#662233", fg = "#bbbbbb" }
      set_highlight { name = "StatusLineSelect", bg = "#bbbbbb", fg = "#444444" }
      set_highlight { name = "StatusLinePending", bg = "#bbbbbb", fg = "#444444" }
    end,
  })
end

return M

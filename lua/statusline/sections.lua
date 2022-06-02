local Job = require "plenary.job"

local M = {}

function M.mode()
  local modes = require("statusline.modes").modes
  return "%#StatusLineCommand# " .. modes[vim.api.nvim_get_mode().mode] .. " "
end

function M.git_branch()
  local j = Job:new {
    command = "git",
    args = { "branch", "--show-current" },
    cwd = vim.fn.expand "%:h",
  }

  local ok, result = pcall(function()
    return vim.trim(j:sync()[1])
  end)

  if ok then
    return "%#StatusLineGit# " .. result .. " "
  end

  return "%#StatusLineFiller#"
end

function M.filler()
  return "%#StatusLineFiller#%="
end

function M.file()
  return vim.fn.expand "%:p:."
end

function M.position()
  return "[line:col]"
end

function M.percentage()
  return "50"
end

function M.filetype()
  return "[lua]"
end

return M

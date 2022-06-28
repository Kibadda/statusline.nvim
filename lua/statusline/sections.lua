local Job = require "plenary.job"

local M = {}

function M.mode()
  local modes = require "statusline.modes"
  return "%#StatusLineCommand#[" .. modes[vim.api.nvim_get_mode().mode] .. "]"
end

function M.git_branch()
  local ok, result = pcall(function()
    return vim.trim(Job:new({
      command = "git",
      args = { "branch", "--show-current" },
      cwd = vim.fn.getcwd(),
    }):sync()[1])
  end)

  if ok then
    local icon = require("nvim-web-devicons").get_icon ".gitattributes"
    return "%#StatusLineGit#[" .. icon .. " :" .. result .. "]"
  end

  return ""
end

function M.filler()
  return "%#StatusLineFiller#[%=]"
end

function M.file()
  local filename = vim.fn.expand "%:p:."
  if filename == "" then
    return ""
  end
  local filetype = vim.bo.filetype
  if filetype == "term" or filetype == "terminal" then
    filetype = "terminal"
    local splitted = vim.split(filename, ":")
    filename = splitted[#splitted]
  end
  local icon = require("nvim-web-devicons").get_icon(vim.fn.expand "%:t", filetype, { default = true })
  return "%#StatusLineFile#[" .. icon .. " :" .. filename .. "]"
end

function M.position()
  local curpos = vim.fn.getcurpos(0)
  local line = curpos[2]
  local col = curpos[3]
  return "%#StatusLinePosition#" .. string.format("[%03d:%03d]", line, col)
end

function M.percentage()
  local line = vim.fn.getcurpos(0)[2]
  local total_lines = vim.api.nvim_buf_line_count(0)
  local percentage = math.floor((line / total_lines) * 100)
  return "%#StatusLinePercentage#[" .. string.format("%03d", percentage) .. "%%]"
end

function M.filetype()
  return "%#StatusLineFiletype#[" .. vim.bo.filetype .. "]"
end

return M

local Job = require "plenary.job"

local git_insertions = vim.regex [[\(\d\+\)\( insertions\)\@=]]
local git_changed = vim.regex [[\(\d\+\)\( file changed\)\@=]]
local git_deletions = vim.regex [[\(\d\+\)\( deletions\)\@=]]

local parse_shortstat_output = function(s)
  local result = {}

  local insert = { git_insertions:match_str(s) }
  if not vim.tbl_isempty(insert) then
    table.insert(result, string.format("+%s", string.sub(s, insert[1] + 1, insert[2])))
  end

  local changed = { git_changed:match_str(s) }
  if not vim.tbl_isempty(changed) then
    table.insert(result, string.format("~%s", string.sub(s, changed[1] + 1, changed[2])))
  end

  local delete = { git_deletions:match_str(s) }
  if not vim.tbl_isempty(delete) then
    table.insert(result, string.format("-%s", string.sub(s, delete[1] + 1, delete[2])))
  end

  if vim.tbl_isempty(result) then
    return nil
  end

  return string.format("[%s]", table.concat(result, ", "))
end

local M = {}

function M.mode()
  local modes = require "statusline.modes"
  local mode = vim.api.nvim_get_mode().mode
  return "%#" .. modes.mode_highlights[mode] .. "# " .. modes.modes[mode] .. " "
end

function M.git_branch()
  local j = Job:new {
    command = "git",
    args = { "branch", "--show-current" },
    cwd = vim.loop.cwd(),
  }

  local ok, result = pcall(function()
    return vim.trim(j:sync()[1])
  end)

  if ok then
    local icon = require("nvim-web-devicons").get_icon ".gitattributes"
    return "%#StatusLineGit# " .. icon .. " " .. result .. " "
  end

  return ""
end

function M.git_changes()
  local j = Job:new {
    command = "git",
    args = { "diff", "--shortstat", vim.fn.expand "%:p:." },
    cwd = vim.loop.cwd(),
  }

  local ok, result = pcall(function()
    return vim.trim(j:sync()[1])
  end)

  if ok then
    return "%#StatusLineGit#" .. parse_shortstat_output(result) .. ""
  end

  return ""
end

function M.filler()
  return "%#StatusLineFiller#%="
end

function M.file()
  local filename = vim.fn.expand "%:p:."
  if filename == "" then
    return ""
  end
  local icon = require("nvim-web-devicons").get_icon(vim.fn.expand "%:t", vim.fn.expand "%:e", { default = true })
  return "%#StatusLineFile#" .. icon .. " " .. vim.fn.expand "%:p:."
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
  return string.format("%%#StatusLinePercentage#[%03d%%%%]", percentage)
end

function M.filetype()
  return "%#StatusLineFiletype#[" .. vim.bo.filetype .. "]"
end

return M

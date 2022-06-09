# statusline.nvim

## Installation
Install with your favorite plugin manager. \
e.g. [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use {
  "Kibadda/statusline.nvim",
  config = function()
    require("statusline").setup {}
  end),
}
```

![screenshot](https://github.com/Kibadda/statusline.nvim/blob/main/statusline.png?raw=true)

## Configuration

These are the default options: (which can be overwritten individually)
```lua
local opts = {
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
}
```

#### Sections
1. `mode`: Displays current mode
1. `git_branch`: Displays current branch
1. `git_changes`: Displays changes in file
1. `file`: Displays current filename
1. `position`: Displays current position in file
1. `percentage`: Displays current percentage line/total_lines
1. `filetype`: Displays current filetype

#### Highlights
These settings can be overwritten to either change the highlight group name or the colors of the highlight group.

# License
MIT License

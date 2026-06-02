-- [[ mini.nvim ]]
--  A collection of various small independent plugins/modules

local plugins = {
  'https://github.com/nvim-mini/mini.nvim',
}

vim.pack.add(plugins)

require('mini.surround').setup()

-- mini.diff
require('mini.diff').setup()

-- mini animate
local animate = require 'mini.animate'
animate.setup {
  -- Animate cursor movement
  cursor = {
    enable = true,
    timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
    path = animate.gen_path.line { max_length = 1000 },
  },

  -- Animate scrolling
  scroll = {
    enable = true,
    timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
    subscroll = animate.gen_subscroll.equal { max_output_steps = 30 },
  },

  -- Animate window resizing
  resize = {
    enable = true,
    timing = animate.gen_timing.linear { duration = 180, unit = 'total' },
    subresize = animate.gen_subresize.equal { max_output_steps = 2 },
  },

  -- Animate window opening
  open = {
    enable = true,
    timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
    winconfig = animate.gen_winconfig.static { steps = 20 },
    winblend = animate.gen_winblend.linear { from = 90, to = 0 },
  },

  -- Animate window closing
  close = {
    enable = true,
    timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
    winconfig = animate.gen_winconfig.static { steps = 20 },
    winblend = animate.gen_winblend.linear { from = 0, to = 95 },
  },
}

-- mini pairs
require('mini.pairs').setup {
  modes = { insert = true, command = false, terminal = false },
  mappings = {
    ['('] = { action = 'open', pair = '()', neigh_pattern = '^[^\\]' },
    ['['] = { action = 'open', pair = '[]', neigh_pattern = '^[^\\]' },
    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '^[^\\]' },

    [')'] = { action = 'close', pair = '()', neigh_pattern = '^[^\\]' },
    [']'] = { action = 'close', pair = '[]', neigh_pattern = '^[^\\]' },
    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '^[^\\]' },

    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '^[^\\]', register = { cr = false } },
    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '^[^%a\\]', register = { cr = false } },
    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '^[^\\]', register = { cr = false } },
  },
}

-- statusline
---@diagnostic disable-next-line: duplicate-set-field
require('mini.statusline').section_location = function() return '%2l:%-2v' end
require('mini.statusline').setup {
  use_icons = true,
}

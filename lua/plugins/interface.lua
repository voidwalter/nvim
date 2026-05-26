local plugins = {
  'https://github.com/nvimdev/dashboard-nvim',
  'https://github.com/amansingh-afk/milli.nvim',
  'https://github.com/xiyaowong/transparent.nvim',
  'https://github.com/OXY2DEV/markview.nvim',
  'https://github.com/sphamba/smear-cursor.nvim',
}

vim.pack.add(plugins)

local splash = require('milli').load { splash = 'blackhole' }

require('milli').dashboard { splash = 'blackhole', loop = true }
require('dashboard').setup {
  theme = 'hyper',
  config = {
    header = splash.frames[1],
    packages = { enable = false },
    project = { enable = false, limit = 8, icon = ' ', label = 'Directory', action = 'Telescope find_files cwd=' },
    mru = { enable = true, limit = 10, icon = ' ', label = 'Recents (cwd)', cwd_only = true },
    shortcut = {
      { desc = 'Telescope', group = 'Number', action = 'Telescope', key = 't' },
      { desc = 'Recent', action = 'Telescope oldfiles', key = 'r' },
      { desc = 'Cheackheath', group = '@property', action = 'checkhealth', key = 'c' },
      { desc = 'Update', group = '@property', action = 'lua vim.pack.update()', key = 'u' },
      { desc = 'Quit', action = 'qa', key = 'q' },
    },
    footer = { '', "It's not working, let me out!!" },
  },
}

require('smear_cursor').setup {
  smear_between_buffers = true,
  smear_between_neighbor_lines = true,
  scroll_buffer_space = true,
  legacy_computing_symbols_support = true,
  smear_insert_mode = true,
  stiffness = 0.8, -- 0.6      [0, 1]
  trailing_stiffness = 0.6, -- 0.45     [0, 1]
  stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
  trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
  damping = 0.95, -- 0.85     [0, 1]
  damping_insert_mode = 0.95, -- 0.9      [0, 1]
  distance_stop_animating = 0.5, -- 0.1      > 0
}

require('transparent').setup {
  groups = {
    'Normal',
    'NormalNC',
    'Comment',
    'Constant',
    'Special',
    'Identifier',
    'Statement',
    'PreProc',
    'Type',
    'Underlined',
    'Todo',
    'String',
    'Function',
    'Conditional',
    'Repeat',
    'Operator',
    'Structure',
    'LineNr',
    'NonText',
    'SignColumn',
    'CursorLine',
    'CursorLineNr',
    'StatusLine',
    'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {},
  exclude_groups = {},
  on_clear = function() end,
}

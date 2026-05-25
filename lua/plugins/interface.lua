local plugins = {
  'https://github.com/nvimdev/dashboard-nvim',
  'https://github.com/amansingh-afk/milli.nvim',
  'https://github.com/xiyaowong/transparent.nvim',
}

vim.pack.add(plugins)

local splash = require('milli').load { splash = 'blackhole' }

require('milli').dashboard { splash = 'blackhole', loop = true }
require('dashboard').setup {
  theme = 'hyper',
  config = {
    header = splash.frames[1], -- seed header with frame 0
    packages = { enable = false }, -- show how many plugins neovim loaded
    -- limit how many projects list, action when you press key or enter it will run this action.
    -- action can be a function type, e.g.
    -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
    project = { enable = true, limit = 8, icon = ' ', label = 'Recend dir', action = 'Telescope find_files cwd=' },
    mru = { enable = true, limit = 10, icon = ' ', label = 'Recent edits (cwd)', cwd_only = true },
    shortcut = {
      { desc = 'Telescope', group = 'Number', action = 'Telescope', key = 't' },
      { desc = 'Recent', action = 'Telescope oldfiles', key = 'r' },
      { desc = 'Cheackheath', group = '@property', action = 'checkhealth', key = 'c' },
      { desc = 'Update', group = '@property', action = 'lua vim.pack.update()', key = 'u' },
      { desc = 'Quit', action = 'qa', key = 'q' },
    },
    footer = { "It's not working, let me out!!" },
  },
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

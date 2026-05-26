local plugins = {
  'https://github.com/nvimdev/dashboard-nvim',
  'https://github.com/xiyaowong/transparent.nvim',
  'https://github.com/OXY2DEV/markview.nvim',
}

vim.pack.add(plugins)

require('dashboard').setup {
  theme = 'hyper',
  config = {
    header = {
      [[                                                     ]],
      [[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
      [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
      [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
      [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
      [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
      [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
      [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
      [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
      [[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
      [[                                 ░                   ]],
      [[                                                     ]],
    },
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

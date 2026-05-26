local plugins = {
  {
    src = 'https://github.com/romgrk/barbar.nvim',
    dependencies = {
      'https://github.com/lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'https://github.com/nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
  },
}

vim.pack.add(plugins)
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<Space>[', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<Space>]', '<Cmd>BufferNext<CR>', opts)
map('n', '<Space>b[', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<Space>b]', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<Space>1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<Space>2', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<Space>3', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<Space>4', '<Cmd>Space>ferGoto 4<CR>', opts)
map('n', '<Space>5', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<Space>6', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<Space>7', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<Space>8', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<Space>9', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<Space>0', '<Cmd>BufferLast<CR>', opts)

map('n', '<Space>bp', '<Cmd>BufferPin<CR>', opts)
map('n', '<Space>bc', '<Cmd>BufferClose<CR>', opts)
map('n', '<Space>.', '<Cmd>BufferPick<CR>', opts)
map('n', '<Space>b.', '<Cmd>BufferPickDelete<CR>', opts)

-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

require('barbar').setup {
  animation = true,
  auto_hide = true,
  clickable = false,
  focus_on_close = 'left',
  highlight_alternate = false,
  highlight_inactive_file_icons = false,
  highlight_visible = true,
  no_name_title = nil,
  sort = { ignore_case = true },
  icons = {
    buffer_index = false,
    buffer_number = false,
    button = '',
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
      [vim.diagnostic.severity.WARN] = { enabled = false },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = true },
    },
    gitsigns = {
      added = { enabled = false, icon = '+' },
      changed = { enabled = false, icon = '~' },
      deleted = { enabled = false, icon = '-' },
    },
    filetype = {
      custom_colors = false,
      enabled = true,
    },
    separator = { left = '▎', right = '' },

    separator_at_end = true,
    modified = { button = '●' },
    pinned = { button = '', filename = true },

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'slanted',

    alternate = { filetype = { enabled = false } },
    current = { buffer_index = true },
    inactive = { button = '×' },
    visible = { modified = { buffer_number = false } },
  },
}

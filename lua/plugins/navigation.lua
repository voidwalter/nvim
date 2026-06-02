-- search and navigation

local plugins = {
  'https://github.com/romgrk/barbar.nvim',
  {
    src = 'https://github.com/nvim-telescope/telescope.nvim',
    version = 'v0.2.2',
    dependencies = {
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
      { 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
}

vim.pack.add(plugins)

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

require('telescope').setup {
  defaults = {
    mappings = {
      i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    },
  },
  -- pickers = {}
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}

local builtin = require 'telescope.builtin'
-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    -- Find references for the word under cursor.
    vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

    -- Jump to the implementation of the word under cursor.
    vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

    -- Jump to the definition of the word under cursor. press <C-t>, to jump back
    vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

    -- Fuzzy find all the symbols ( variables, functions, types ) in current buffer.
    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

    -- Fuzzy find all the symbols in current workspace.
    vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

    -- Jump to the type of the word under the cursor.
    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})

vim.keymap.set(
  'n',
  '<leader>/',
  function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false }) end,
  { desc = '[/] search in current buffer' }
)

vim.keymap.set(
  'n',
  '<leader>s/',
  function() builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep (active)' } end,
  { desc = 'Grep in open files' }
)

vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[N]eovim config files' })

-- ===============
-- buffer (barbar)

-- others

require('barbar').setup {
  animation = true,
  auto_hide = true,
  clickable = true,
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
      enabled = false,
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

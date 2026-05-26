-- SECTION 1: Basic
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds

do
  -- require 'plugins.debug'
  require 'plugins.navigation'
  require 'plugins.completion'
  require 'plugins.formating'
  require 'plugins.interface'
  require 'plugins.minix'
  require 'plugins.miscellaneous'
end

do
  vim.loader.enable() -- Enable faster startup by caching compiled Lua modules

  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.g.have_nerd_font = true
  vim.o.mouse = 'a'
  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.showmode = false
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
  vim.o.breakindent = true
  vim.o.undofile = true
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.signcolumn = 'yes'
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  vim.o.splitright = true
  vim.o.splitbelow = true
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
  vim.o.inccommand = 'split'
  vim.o.cursorline = true
  vim.o.scrolloff = 10
  vim.o.confirm = true

  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2

  -- [[ Basic Keymaps ]]
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  -- =====================
  -- ===== KEYMAPS =======

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
  map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- map("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- map("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- map("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- map("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- Move to previous/next
  map('n', '<Space>[', '<Cmd>BufferPrevious<CR>', opts)
  map('n', '<Space>]', '<Cmd>BufferNext<CR>', opts)
  map('n', '<Space>b[', '<Cmd>BufferMovePrevious<CR>', opts)
  map('n', '<Space>b]', '<Cmd>BufferMoveNext<CR>', opts)

  -- Goto buffer in position...
  map('n', '<Space>1', '<Cmd>BufferGoto 1<CR>', opts)
  map('n', '<Space>2', '<Cmd>BufferGoto 2<CR>', opts)
  map('n', '<Space>3', '<Cmd>BufferGoto 3<CR>', opts)
  map('n', '<Space>4', '<Cmd>BufferGoto 4<CR>', opts)
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

  -- telescope
  local builtin = require 'telescope.builtin'
  map('n', '<leader>sf', function() builtin.find_files() end, { desc = '[S]earch [F]iles' })
  map('n', '<leader>sg', function() builtin.live_grep() end, { desc = '[S]earch by [G]rep' })
  map('n', '<leader>sh', function() builtin.help_tags() end, { desc = '[S]earch [H]elp' })
  map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  map('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  map('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
  map('n', '<Space>tt', 'Cmd>TransparentToggle<CR>', { desc = 'Toggle Transparency' })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ======================================
-- SECTION 2: PLUGIN MANAGER (built-in)
-- ======================================
-- Because lua is a real programming language, it's possible to apply logic to installation
do
  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 3: CORE PLUGINS
-- ============================================================
do
  vim.pack.add { gh 'nvim-tree/nvim-web-devicons' }

  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    style = 'moon',
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      floats = 'transparent',
      sidebars = 'transparent',
    },
  }

  vim.cmd.colorscheme 'tokyonight-night'
end

-- ============================================================
-- SECTION 4: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  --  See `:help lsp-config`
  ---@type table<string, vim.lsp.Config>
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    --
    stylua = {}, -- Used to format Lua code

    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  require('mason').setup {}

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- bash-language-server
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

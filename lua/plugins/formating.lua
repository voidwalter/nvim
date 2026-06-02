-- formatter, parser and linter config
local plugins = {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/stevearc/conform.nvim',
}

vim.pack.add(plugins)

vim.pack.loadall()

-- Formatting, Conform
vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true, lsp_fallback = true } end, { desc = '[F]ormat buffer' })

require('conform').setup {
  notify_on_error = false,
  -- Enable format on save for specific filetypes
  format_on_save = function(bufnr)
    local enabled_filetypes = {
      lua = true,
      nix = true,
    }

    -- Disable formatting in node_modules or specific ignored paths
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match '/node_modules/' then return end

    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500, lsp_fallback = true }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    nix = { 'nixfmt', 'nixpkgs_fmt', stop_after_first = true },
  },
  formatters = {
    nixfmt = {},
  },
}

-- Treesitter parsers
local parsers = {
  'bash',
  'c',
  'diff',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'nix',
}

require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)

  -- Enable treesitter based indentation if available
  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
  if has_indent_query then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match
    local language = vim.treesitter.language.get_lang(filetype)

    if not language then return end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
    else
      treesitter_try_attach(buf, language)
    end
  end,
})


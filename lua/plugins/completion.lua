local plugins = {
  { src = 'https://github.com/hrsh7th/nvim-cmp', event = 'InsertEnter' },
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
}

vim.pack.add(plugins)

local cmp = require 'cmp'

cmp.setup {
  experimental = { ghost_text = true },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(_, item)
      local icons = {
        Namespace = '󰌗',
        Text = '󰉿',
        Method = '󰆧',
        Function = '󰆧',
        Constructor = '',
        Field = '󰜢',
        Variable = '󰀫',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '󰑭',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈚',
        Reference = '󰈇',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '󰙅',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰊄',
        Table = '',
        Object = '󰅩',
        Tag = '',
        Array = '[]',
        Boolean = '',
        Number = '',
        Null = '󰟢',
        String = '󰉿',
        Calendar = '',
        Watch = '󰥔',
        Package = '',
      }

      local icon = icons[item.kind] or ''
      item.kind = string.format('%s %s', icon, item.kind or '')
      return item
    end,
  },

  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
  },

  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
    { name = 'nvim_lua' },
    { name = 'path' },
  },

  window = {
    completion = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      scrollbar = false,
      sidePadding = 0,
      winhighlight = 'FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel',
    },
    settings = {
      documentation = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        winhighlight = 'FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel',
      },
    },
  },
}

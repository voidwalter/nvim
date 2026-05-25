local plugins = {
  'https://github.com/folke/tokyonight.nvim',
}

vim.pack.add(plugins)

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  style = 'moon',
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    floats = 'transparent',
    sidebars = 'transparent',
  },
}

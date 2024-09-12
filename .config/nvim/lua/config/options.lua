-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt

-- Open files with "gf"
o.path = "**"
o.wildignore = "*/vendor/*,*/node_modules/*,*/var/*,*/public/build/*"

-- Code indentation
o.tabstop = 4
o.expandtab = true
o.smarttab = true
o.smartindent = true
o.shiftwidth = 0

o.swapfile = false

-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
-- https://www.lazyvim.org/extras/lang/php#options
vim.g.lazyvim_php_lsp = "intelephense"

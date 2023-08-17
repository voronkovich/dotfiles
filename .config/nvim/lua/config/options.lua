-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.opt

-- Open files with "gf"
o.path = "**"
o.wildignore = "*/vendor/*,*/node_modules/*,*/var/*,*/public/build/*"

-- Code indentation
o.tabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true
o.smartindent = true

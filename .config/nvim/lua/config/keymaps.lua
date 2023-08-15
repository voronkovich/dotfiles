-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", ";", ":")

-- Move backward and forward in insert mode
map("i", "<C-h>", "<C-o>h")
map("i", "<C-l>", "<C-o>l")

-- Save file
map({ "i", "v", "n", "s" }, "<C-a>", "<cmd>w<cr><esc>", { desc = "Save file" })

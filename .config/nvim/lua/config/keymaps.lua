-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", ";", ":", { desc = "Execute command" })

-- Move backward and forward in insert mode
map("i", "<C-h>", "<C-o>h", { desc = "Move backward" })
map("i", "<C-l>", "<C-o>l", { desc = "Move forward" })
map("i", "<C-j>", "<C-o>A", { desc = "Move to end of line" })

map({ "i", "v", "n", "s" }, "<C-a>", "<cmd>w<cr><esc>", { desc = "Save file" })

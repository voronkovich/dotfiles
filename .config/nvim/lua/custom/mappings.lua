vim.g.mapleader = ','

---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<CR>"] = { ":Telescope find_files<CR>", "Telescope files", opts = { nowait = true } },
    ["<Space>w"] = { ":HopWord<CR>", "Go to Word", opts = { nowait = true } },
    ["<Space>l"] = { ":Telescope buffers<CR>", "Telescope buffers", opts = { nowait = true } },
  },
}

-- more keybinds!

return M

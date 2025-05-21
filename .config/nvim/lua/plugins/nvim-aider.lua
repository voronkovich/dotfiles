return {
  "GeorgesAlkhouri/nvim-aider",
  dependencies = {
    "folke/snacks.nvim",
  },
  cmd = {
    "Aider",
  },
  keys = {
    { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Open Aider" },
    { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>Aider command<cr>", desc = "Send Command To Aider" },
    { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer To Aider" },
    -- { "<leader>aa", "<cmd>Aider add<cr>", desc = "Add File to Aider" },
    {
      "<leader>aa",
      function()
        require("autoread").enable()
        require("nvim_aider").api.add_current_file()
      end,
      desc = "Add File to Aider",
    },
    {
      -- { "<leader>ad", "<cmd>Aider drop<cr>", desc = "Drop File from Aider" },
      "<leader>ad",
      function()
        require("autoread").disable()
        require("nvim_aider").api.drop_current_file()
      end,
      desc = "Drop File from Aider",
    },
    { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add File as Read-Only" },
  },
  opts = {
    auto_reload = true,
    win = {
      position = "bottom",
    },
  },
}

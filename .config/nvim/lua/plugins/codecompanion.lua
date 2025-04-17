vim.g.codecompanion_auto_tool_mode = true

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<Leader>cc", "<cmd>CodeCompanionChat Toggle<CR>" },
  },
  config = {
    adapters = {
      opts = {
        show_defaults = false,
      },
      custom = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "OPENAI_API_BASE",
            api_key = "OPENAI_API_KEY",
          },
          schema = {
            model = {
              default = "o1-mini",
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "custom",
        keymaps = {
          send = {
            modes = {
              n = { "<CR>", "<C-a>" },
              i = { "<C-a>" },
            },
          },
        },
      },
      cmd = {
        adapter = "custom",
      },
      inline = {
        adapter = "custom",
      },
    },
  },
}

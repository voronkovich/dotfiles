return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = {
    adapters = {
      custom = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "http://localhost:1337",
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
